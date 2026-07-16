import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/course_repository.dart';
import '../../../shared/domain/course.dart' as dummy;
import '../../curriculum/application/curriculum_engine.dart';
import '../../curriculum/data/curriculum_repository.dart';
import '../../curriculum/domain/catalog_course.dart';
import '../../transcript/application/transcript_enrichment.dart';
import '../../transcript/data/transcript_repository.dart';

/// One real (or currently-registered) attempt at a course, in chronological
/// order. Transferred credits (BSM116/BSM126) surface here too, labelled
/// distinctly rather than folded into a fake "semester."
class CourseAttempt {
  const CourseAttempt({
    required this.semesterLabel,
    required this.grade,
    this.creditHours,
    this.points,
    this.isTransferCredit = false,
  });

  final String semesterLabel;
  final String grade;
  final int? creditHours;
  final double? points;
  final bool isTransferCredit;
}

/// A course's basis for appearing at all — which real source vouches for it.
/// A course can be in the bylaw, in the transcript, in both, or (for the
/// still-fictional current-semester screens) only in [dummy.Course].
class CourseDetails {
  const CourseDetails({
    required this.code,
    required this.name,
    this.catalogCourse,
    this.eligibility,
    required this.attempts,
    required this.nextCourses,
    this.registeredCourse,
  });

  final String code;
  final String name;
  final CatalogCourse? catalogCourse;
  final CourseEligibility? eligibility;

  /// Every attempt across the transcript, oldest first.
  final List<CourseAttempt> attempts;

  /// Other bylaw courses that list this one as a prerequisite.
  final List<CatalogCourse> nextCourses;

  /// Present only when this course is one of the fictional current-semester
  /// courses (`CourseRepository`) — supplies instructor/room/attendance for
  /// screens that still use that placeholder data.
  final dummy.Course? registeredCourse;

  bool get isInBylaw => catalogCourse != null;
  bool get hasBeenTaken => attempts.isNotEmpty;
  bool get isRepeated => attempts.length > 1;
  String get latestGrade => attempts.isEmpty ? '—' : attempts.last.grade;

  double get totalPointsEarned {
    var sum = 0.0;
    for (final a in attempts) {
      sum += a.points ?? 0;
    }
    return sum;
  }

  /// A transparent, deterministic proxy for "how much this course usually
  /// asks of a student" — built only from real bylaw facts (credit hours,
  /// how many prerequisites gate it, year level). There is no cohort-wide
  /// pass-rate data anywhere in this app to compute a genuine difficulty
  /// score from, so this is explicitly labelled "Estimated Workload" in the
  /// UI rather than presented as an official statistic. 1 (lightest) – 5
  /// (heaviest).
  int? get estimatedWorkload {
    final course = catalogCourse;
    if (course == null) return null;
    final score = (course.creditHours * 0.6) + (course.prerequisiteCourseCodes.length * 0.9) + (course.yearLevel * 0.3);
    return score.clamp(1, 5).round();
  }
}

String _categoryLabel(CourseCategory category) => switch (category) {
  CourseCategory.generalEducation => 'General Education',
  CourseCategory.basicScience => 'Basic Science',
  CourseCategory.majorMandatory => 'Major Mandatory',
  CourseCategory.generalMajor => 'General Major',
  CourseCategory.mutual => 'Mutual Course',
  CourseCategory.elective => 'Elective',
};

/// Every course reference in the app becomes clickable, landing here — one
/// aggregator that pulls the real bylaw entry, every real transcript
/// attempt (chronological, including transferred credits), and eligibility,
/// keyed by course code alone. Returns `null` only when the code matches no
/// real source at all (an honest "not found," never a guess).
final courseDetailsProvider = FutureProvider.family<CourseDetails?, String>((ref, rawCode) async {
  final code = rawCode.trim().toUpperCase();

  final catalog = await ref.watch(curriculumProvider.future);
  final semesters = await ref.watch(enrichedTranscriptProvider.future);
  final transferred = await ref.watch(transferredCreditsProvider.future);
  final eligibilities = await ref.watch(courseEligibilityProvider.future);
  final registeredCourses = ref.watch(coursesProvider);

  CatalogCourse? catalogCourse;
  for (final c in catalog) {
    if (c.code == code) catalogCourse = c;
  }

  final attempts = <CourseAttempt>[];
  String? name;

  for (final t in transferred) {
    if (t.code == code) {
      name ??= t.name;
      attempts.add(CourseAttempt(
        semesterLabel: 'Transferred Credit',
        grade: t.grade,
        creditHours: t.creditHours,
        points: t.points,
        isTransferCredit: true,
      ));
    }
  }
  for (final semester in semesters) {
    for (final course in semester.courses) {
      if (course.code == code) {
        name ??= course.name;
        attempts.add(CourseAttempt(
          semesterLabel: semester.label,
          grade: course.grade,
          creditHours: course.creditHours,
          points: course.points,
        ));
      }
    }
  }

  CourseEligibility? eligibility;
  for (final e in eligibilities) {
    if (e.course.code == code) eligibility = e;
  }

  dummy.Course? registeredCourse;
  for (final c in registeredCourses) {
    if (c.code == code) registeredCourse = c;
  }

  name ??= catalogCourse?.name ?? registeredCourse?.name;
  if (name == null) return null; // No real source knows this code.

  final nextCourses = [
    for (final c in catalog)
      if (c.prerequisiteCourseCodes.contains(code)) c,
  ];

  return CourseDetails(
    code: code,
    name: name,
    catalogCourse: catalogCourse,
    eligibility: eligibility,
    attempts: attempts,
    nextCourses: nextCourses,
    registeredCourse: registeredCourse,
  );
});

/// Department can only be stated confidently for courses the bylaw marks as
/// belonging to the Information Systems major/department track itself
/// (`majorMandatory`/`generalMajor`); general-education, basic-science,
/// mutual, and elective courses are shared across other faculties/majors
/// the bylaw doesn't name, so this returns `null` (rendered as "—") rather
/// than guessing a department.
String? departmentFor(CatalogCourse course) => switch (course.category) {
  CourseCategory.majorMandatory || CourseCategory.generalMajor => 'Information Systems',
  _ => null,
};

String categoryLabel(CourseCategory category) => _categoryLabel(category);
