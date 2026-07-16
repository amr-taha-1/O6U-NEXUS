import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/semester.dart';
import '../../../shared/data/grade_scale_repository.dart';
import '../../curriculum/data/curriculum_repository.dart';
import '../data/transcript_repository.dart';

/// Fills in the per-course credit hours and earned points the raw
/// transcript doesn't carry directly, using only real, cross-checkable
/// sources — never a guess:
///
/// - Credit hours: looked up by course code in the official department
///   bylaw (`assets/data/bylaw_information_systems.json`) — a course's
///   credit-hour weight is fixed by the curriculum, not by which attempt or
///   semester it was taken in.
/// - Earned points: `creditHours × gradeScale.pointsForLetter(grade)`, using
///   the real official grading scale (`assets/data/grade_scale.json`).
///
/// A handful of courses (the "URE"-prefixed general-education electives —
/// e.g. Modern Egyptian History, Sociology of Work — aren't part of the
/// major-specific bylaw catalog at all, so there's no official source for
/// their credit hours here; those stay `null` ("—" in the UI) rather than
/// being invented. Already-populated values (Fall 2023/2024, transferred
/// credits) are left untouched. See docs/Architecture.md "Real data".
final enrichedTranscriptProvider = FutureProvider<List<Semester>>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  final catalog = await ref.watch(curriculumProvider.future);
  final gradeScale = await ref.watch(gradeScaleProvider.future);
  final hoursByCode = {for (final course in catalog) course.code: course.creditHours};

  return [
    for (final semester in semesters)
      semester.copyWith(
        courses: [
          for (final course in semester.courses)
            if (course.creditHours != null && course.points != null)
              course
            else
              () {
                final hours = course.creditHours ?? hoursByCode[course.code];
                final points = course.points ?? (hours == null ? null : hours * gradeScale.pointsForLetter(course.grade));
                return course.copyWith(creditHours: hours, points: points);
              }(),
        ],
      ),
  ];
});
