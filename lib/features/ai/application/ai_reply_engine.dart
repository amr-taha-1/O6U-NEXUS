import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/data/student_repository.dart';
import '../../../shared/domain/ai_message.dart';
import '../../../shared/domain/student.dart';
import '../../curriculum/application/curriculum_engine.dart';
import '../../schedule/application/schedule_providers.dart';
import '../../schedule/domain/schedule_session.dart';
import '../../transcript/application/transcript_enrichment.dart';

/// The 4 prompts Nexus can answer — same list as before, but every answer
/// below is now computed live from the real record instead of a canned
/// string. See docs/Architecture.md "Real data".
const suggestedAiPrompts = [
  'Can I graduate next semester?',
  'Why is my GPA dropping?',
  'Plan my week',
  'What should I revise tonight?',
];

/// Builds Nexus's reply to [prompt] from the real transcript, schedule, and
/// degree-progress providers — never a canned string, and never a claim
/// this app can't back with real data (no fabricated exam schedule,
/// attendance percentage, or study-block placement, since none of those
/// have a real data source yet).
Future<AiAssistantMessage> buildAiReply(String prompt, Ref ref) async {
  final c = AppColors.dark;

  switch (prompt) {
    case 'Can I graduate next semester?':
      final student = await ref.read(currentStudentProvider.future);
      final estimatedSemesters = await ref.read(estimatedRemainingSemestersProvider.future);
      final remaining = student.creditHoursRemaining;
      final graduatesNextTerm = estimatedSemesters <= 1;
      return AiAssistantMessage(
        verdict: graduatesNextTerm ? 'Close — you could finish next semester.' : 'Not next semester, based on your own pace.',
        body: 'You have $remaining credit hours left toward your ${student.creditHoursTotal}-hour degree. '
            'At your own historical pace, that\'s an estimated $estimatedSemesters more '
            '${estimatedSemesters == 1 ? 'semester' : 'semesters'} — an estimate from your real transcript, not a promise.',
        chips: [
          AiChip(label: '$remaining hrs left', color: c.info),
          AiChip(label: '$estimatedSemesters ${estimatedSemesters == 1 ? 'semester' : 'semesters'} est.', color: c.warning),
          AiChip(label: '${student.cumulativeGpa.toStringAsFixed(2)} CGPA', color: c.accent),
        ],
        ctaLabel: 'Open Degree Progress',
      );

    case 'Why is my GPA dropping?':
      final student = await ref.read(currentStudentProvider.future);
      final semesters = await ref.read(enrichedTranscriptProvider.future);
      final positive = student.gpaDelta >= 0;
      final latest = semesters.isEmpty ? null : semesters.last;
      String? weakestCourse;
      if (latest != null) {
        var weakestPointsPerHour = double.infinity;
        for (final course in latest.courses) {
          final hours = course.creditHours;
          final points = course.points;
          if (hours == null || hours == 0 || points == null) continue;
          final perHour = points / hours;
          if (perHour < weakestPointsPerHour) {
            weakestPointsPerHour = perHour;
            weakestCourse = '${course.name} (${course.grade})';
          }
        }
      }
      return AiAssistantMessage(
        verdict: positive
            ? 'Your GPA isn\'t dropping — it\'s up ${student.gpaDelta.abs().toStringAsFixed(2)}.'
            : weakestCourse == null
                ? 'Your GPA moved ${student.gpaDelta.toStringAsFixed(2)} last semester.'
                : '$weakestCourse pulled your GPA down last semester.',
        body: 'Your cumulative GPA is ${student.cumulativeGpa.toStringAsFixed(2)}, '
            '${positive ? 'up' : 'down'} ${student.gpaDelta.abs().toStringAsFixed(2)} vs. the semester before'
            '${latest != null ? ' (${latest.label}: ${latest.gpa.toStringAsFixed(2)} GPA)' : ''}. '
            'Straight from your official transcript.',
        chips: [
          AiChip(label: '${student.cumulativeGpa.toStringAsFixed(2)} CGPA', color: c.accent),
          AiChip(
            label: '${positive ? '+' : '−'}${student.gpaDelta.abs().toStringAsFixed(2)}',
            color: positive ? c.success : c.danger,
          ),
          if (weakestCourse != null) AiChip(label: weakestCourse, color: c.warning),
        ],
        ctaLabel: 'Open Transcript',
      );

    case 'Plan my week':
      final byDay = await ref.read(weeklyScheduleProvider.future);
      final totalSessions = byDay.values.fold<int>(0, (sum, sessions) => sum + sessions.length);
      final courseNames = <String>{for (final sessions in byDay.values) for (final s in sessions) s.courseName};
      return AiAssistantMessage(
        verdict: totalSessions == 0 ? 'No classes on your real schedule this week.' : '$totalSessions classes on your real schedule this week.',
        body: totalSessions == 0
            ? 'Your real timetable has no sessions registered — nothing to plan around yet.'
            : 'Across ${courseNames.join(', ')}. I don\'t have a real calendar-sync or conflict-detection engine yet, '
                'so I can\'t auto-place study blocks — but here\'s your real weekly load to plan around yourself.',
        chips: [
          AiChip(label: '$totalSessions sessions', color: c.accent),
          AiChip(label: '${courseNames.length} courses', color: c.info),
        ],
        ctaLabel: 'Open Schedule',
      );

    case 'What should I revise tonight?':
      final next = await ref.read(nextSessionProvider.future);
      if (next == null) {
        return AiAssistantMessage(
          verdict: 'No upcoming class on your real schedule.',
          body: 'I don\'t have anything to point you toward tonight — your real timetable has no more sessions this week.',
          chips: [AiChip(label: 'No data', color: c.textDim)],
          ctaLabel: 'Open Schedule',
        );
      }
      return AiAssistantMessage(
        verdict: 'Your next class is ${next.courseName}.',
        body: '${next.day.label} at ${next.timeRangeLabel}, Room ${next.room}. There\'s no official exam or quiz '
            'schedule uploaded yet, so I can\'t tell you exactly what\'s being tested tonight — review your most '
            'recent notes for this course.',
        chips: [
          AiChip(label: next.courseCode, color: c.info),
          AiChip(label: next.day.label, color: c.accent),
        ],
        ctaLabel: 'Open Schedule',
      );

    default:
      return AiAssistantMessage(
        verdict: 'I can only answer from your record.',
        body: 'Try one of the suggestions below — I read your transcript, schedule, and degree progress, and nothing else.',
        chips: [AiChip(label: 'Record-only', color: c.accent)],
        ctaLabel: 'See what Nexus reads',
      );
  }
}
