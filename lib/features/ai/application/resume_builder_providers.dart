import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/data/student_repository.dart';
import '../../../shared/domain/ai_message.dart';
import '../../curriculum/application/curriculum_engine.dart';
import '../../transcript/application/transcript_enrichment.dart';
import '../../transcript/data/transcript_repository.dart';

/// Real completed-course names (transcript + transferred credits, passing
/// grades only — reuses [completedCourseCodesProvider]'s own definition of
/// "completed") for the resume's Skills section. Replaces the previous
/// version, which rendered the fictional `coursesProvider` (CS402/MA201/…)
/// fixtures instead of the real record.
final resumeSkillCourseNamesProvider = FutureProvider<List<String>>((ref) async {
  final completedCodes = await ref.watch(completedCourseCodesProvider.future);
  final semesters = await ref.watch(enrichedTranscriptProvider.future);
  final transferredCredits = await ref.watch(transferredCreditsProvider.future);

  final namesByCode = <String, String>{};
  for (final course in transferredCredits) {
    namesByCode[course.code] = course.name;
  }
  for (final semester in semesters) {
    for (final course in semester.courses) {
      namesByCode[course.code] = course.name;
    }
  }

  return [for (final code in completedCodes) if (namesByCode[code] != null) namesByCode[code]!];
});

/// Nexus's verdict for the drafted resume, built from the real student
/// record (major, in particular — this used to hardcode "Computer Science"
/// regardless of the signed-in student's actual major, contradicting
/// `Student.major`). Not in the design reference — a new screen that must
/// still read as a sibling of Nexus's other structured answers
/// (SPECS.nexus pin #1: verdict first, reasoning second, evidence chips
/// third, never a wall of prose).
final resumeVerdictProvider = FutureProvider<AiAssistantMessage>((ref) async {
  final student = await ref.watch(currentStudentProvider.future);
  final c = AppColors.dark;
  return AiAssistantMessage(
    verdict: 'Your resume draft is ready.',
    body:
        'I pulled this from your transcript and course history — ${student.major}, October 6 University. '
        'Nothing here is invented; every line traces back to a course or your student record.',
    chips: [
      AiChip(label: '3 sections', color: c.info),
      AiChip(label: '${student.major}-focused', color: c.accent),
      AiChip(label: 'Draft · v1', color: c.warning),
    ],
    ctaLabel: 'Regenerate',
  );
});
