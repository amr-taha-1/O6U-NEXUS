import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/transcript/data/transcript_repository.dart';
import '../../../shared/data/student_repository.dart';
import '../../../shared/domain/student.dart';
import '../data/curriculum_repository.dart';
import '../domain/catalog_course.dart';

/// Grades that do NOT count as having passed a course — everything else
/// (including a bare `D`) does. Mirrors the same "did this attempt count"
/// question the transcript's grade-color legend answers, but for
/// eligibility rather than GPA.
const _nonPassingGrades = {'F', 'WF', 'W'};

/// The set of course codes the student has ever passed, derived live from
/// the real transcript — a course retaken after a fail/withdraw counts once
/// it's passed on any attempt. Nothing here is a hardcoded list; see
/// docs/Architecture.md "Real data".
final completedCourseCodesProvider = FutureProvider<Set<String>>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  final completed = <String>{};
  for (final semester in semesters) {
    for (final course in semester.courses) {
      if (!_nonPassingGrades.contains(course.grade.trim().toUpperCase())) {
        completed.add(course.code);
      }
    }
  }
  return completed;
});

enum EligibilityStatus { completed, eligible, locked }

class CourseEligibility {
  const CourseEligibility({required this.course, required this.status, this.missingPrerequisites = const []});
  final CatalogCourse course;
  final EligibilityStatus status;
  /// Populated only when [status] is [EligibilityStatus.locked].
  final List<CatalogCourse> missingPrerequisites;
}

/// Every bylaw course, resolved against the real transcript: completed,
/// eligible to register next, or locked (with exactly which prerequisites
/// are still missing). `FRM416` (Graduation Project 1) is a special case —
/// its prerequisite is Article 40 of the bylaw (a credit-hour threshold),
/// not another course.
final courseEligibilityProvider = FutureProvider<List<CourseEligibility>>((ref) async {
  final catalog = await ref.watch(curriculumProvider.future);
  final completed = await ref.watch(completedCourseCodesProvider.future);
  final student = await ref.watch(currentStudentProvider.future);
  final minHoursForProject = await ref.watch(minCreditHoursForGraduationProjectProvider.future);

  final byCode = {for (final c in catalog) c.code: c};

  return [
    for (final course in catalog)
      if (completed.contains(course.code))
        CourseEligibility(course: course, status: EligibilityStatus.completed)
      else if (course.requiresArticle40)
        if (student.creditHoursCompleted >= minHoursForProject)
          CourseEligibility(course: course, status: EligibilityStatus.eligible)
        else
          CourseEligibility(course: course, status: EligibilityStatus.locked)
      else ...[
        () {
          final missing = [
            for (final code in course.prerequisiteCourseCodes)
              if (!completed.contains(code)) byCode[code]!,
          ];
          return missing.isEmpty
              ? CourseEligibility(course: course, status: EligibilityStatus.eligible)
              : CourseEligibility(course: course, status: EligibilityStatus.locked, missingPrerequisites: missing);
        }(),
      ],
  ];
});

final eligibleNextCoursesProvider = FutureProvider<List<CatalogCourse>>((ref) async {
  final all = await ref.watch(courseEligibilityProvider.future);
  return [for (final e in all) if (e.status == EligibilityStatus.eligible) e.course];
});

final lockedCoursesProvider = FutureProvider<List<CourseEligibility>>((ref) async {
  final all = await ref.watch(courseEligibilityProvider.future);
  return [for (final e in all) if (e.status == EligibilityStatus.locked) e];
});

/// A rough estimate, not a promise: remaining hours divided by the
/// student's own historical average completed hours per semester (from the
/// real transcript), rounded up to whole semesters. Clearly labelled as an
/// estimate everywhere it's shown — see docs/Architecture.md "Real data".
final estimatedRemainingSemestersProvider = FutureProvider<int>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  final student = await ref.watch(currentStudentProvider.future);
  if (semesters.isEmpty || student.creditHoursRemaining <= 0) return 0;

  final avgHoursPerSemester = student.creditHoursCompleted / semesters.length;
  if (avgHoursPerSemester <= 0) return 0;
  return (student.creditHoursRemaining / avgHoursPerSemester).ceil();
});
