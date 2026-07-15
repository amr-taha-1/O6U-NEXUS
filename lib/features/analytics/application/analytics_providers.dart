import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/transcript/data/transcript_repository.dart';
import '../../../features/transcript/domain/transcript_course.dart';

/// A course code attempted more than once (typically after a W/WF/failing
/// grade), with every attempt's grade in chronological order.
class RepeatedCourse {
  const RepeatedCourse({required this.code, required this.name, required this.attempts});
  final String code;
  final String name;
  final List<String> attempts;
}

/// Courses appearing in more than one semester — computed from the real
/// transcript, not stored separately, so it can never drift out of sync.
final repeatedCoursesProvider = FutureProvider<List<RepeatedCourse>>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  final byCode = <String, List<TranscriptCourse>>{};
  for (final semester in semesters) {
    for (final course in semester.courses) {
      (byCode[course.code] ??= []).add(course);
    }
  }
  return [
    for (final entry in byCode.entries)
      if (entry.value.length > 1)
        RepeatedCourse(code: entry.key, name: entry.value.first.name, attempts: [for (final c in entry.value) c.grade]),
  ];
});

/// One band on the grade-distribution chart.
class GradeBand {
  const GradeBand({required this.label, required this.count});
  final String label;
  final int count;
}

/// How many courses fall into each grade band across the whole transcript
/// (A/B/C/D/F, plus W and Pass/NOD as their own bands since they don't
/// carry quality points the way lettered grades do).
final gradeDistributionProvider = FutureProvider<List<GradeBand>>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  final counts = <String, int>{'A': 0, 'B': 0, 'C': 0, 'D': 0, 'F': 0, 'W': 0, 'Other': 0};
  for (final semester in semesters) {
    for (final course in semester.courses) {
      final grade = course.grade.trim().toUpperCase();
      if (grade.startsWith('A')) {
        counts['A'] = counts['A']! + 1;
      } else if (grade.startsWith('B')) {
        counts['B'] = counts['B']! + 1;
      } else if (grade.startsWith('C')) {
        counts['C'] = counts['C']! + 1;
      } else if (grade.startsWith('D')) {
        counts['D'] = counts['D']! + 1;
      } else if (grade == 'F' || grade == 'WF') {
        counts['F'] = counts['F']! + 1;
      } else if (grade == 'W') {
        counts['W'] = counts['W']! + 1;
      } else {
        counts['Other'] = counts['Other']! + 1;
      }
    }
  }
  return [for (final e in counts.entries) if (e.value > 0) GradeBand(label: e.key, count: e.value)];
});

/// Total courses counted in the distribution (for percentage bars).
final totalGradedCoursesProvider = FutureProvider<int>((ref) async {
  final bands = await ref.watch(gradeDistributionProvider.future);
  return bands.fold<int>(0, (sum, b) => sum + b.count);
});
