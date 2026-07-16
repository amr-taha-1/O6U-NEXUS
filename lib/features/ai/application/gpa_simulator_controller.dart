import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/grade_scale_repository.dart';
import '../../../shared/data/student_repository.dart';
import '../../curriculum/application/curriculum_engine.dart';
import '../../curriculum/domain/catalog_course.dart';

/// A neutral, non-committal starting grade for a real in-progress course
/// that hasn't been graded yet — the picker lets the student change it
/// immediately; this is never presented as a real or predicted grade.
const _defaultSimulatedGrade = 'B';

/// The GPA Simulator's hypothetical grade picks, keyed by course code — the
/// real courses the student is currently registered for this term
/// (`currentlyRegisteredCoursesProvider`, from the real timetable), not the
/// fictional CS402/MA201/CS310/PH101/EN102 fixtures this used to read.
/// Ports the reference's `GpaSim` local `picks` state (SPECS.gpasim).
/// Grades are segmented picks, not a slider, because a grade is discrete.
class GpaSimulatorController extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    final courses = ref.watch(currentlyRegisteredCoursesProvider).valueOrNull ?? const <CatalogCourse>[];
    return {for (final course in courses) course.code: _defaultSimulatedGrade};
  }

  void pick(String courseCode, String grade) {
    state = {...state, courseCode: grade};
  }
}

final gpaSimulatorControllerProvider = NotifierProvider<GpaSimulatorController, Map<String, String>>(
  GpaSimulatorController.new,
);

/// The live-recomputed projected cumulative GPA and its delta from the
/// student's actual cumulative GPA — the hero number, recomputed on every
/// pick with no "Calculate" button, ever (SPECS.gpasim pin #1).
class GpaSimulation {
  const GpaSimulation({required this.projected, required this.delta});
  final double projected;
  final double delta;
}

/// Reads [currentStudentProvider]'s and [gradeScaleProvider]'s
/// already-resolved values: only ever watched from within
/// `GpaSimulatorScreen`, which gates its build on both being ready first
/// (see the screen's nested `AsyncValue.when`), so `.requireValue` is safe
/// here.
final gpaSimulationProvider = Provider<GpaSimulation>((ref) {
  final courses = ref.watch(currentlyRegisteredCoursesProvider).valueOrNull ?? const <CatalogCourse>[];
  final student = ref.watch(currentStudentProvider).requireValue;
  final gradeScale = ref.watch(gradeScaleProvider).requireValue;
  final picks = ref.watch(gpaSimulatorControllerProvider);

  final creditHours = courses.fold<int>(0, (sum, c) => sum + c.creditHours);
  final points = courses.fold<double>(0, (sum, c) {
    final grade = picks[c.code] ?? _defaultSimulatedGrade;
    return sum + gradeScale.pointsForLetter(grade) * c.creditHours;
  });
  final projected = creditHours == 0
      ? student.cumulativeGpa
      : (student.cumulativeGpa * student.creditHoursCompleted + points) / (student.creditHoursCompleted + creditHours);
  return GpaSimulation(projected: projected, delta: projected - student.cumulativeGpa);
});

/// The single highest-leverage move available: which registered course, if
/// raised from its current pick to an A, moves the projected cumulative GPA
/// the most — computed live from the real credit-hours-weighted formula
/// above, never a hand-picked example.
class BestGpaMove {
  const BestGpaMove({required this.courseCode, required this.courseName, required this.fromGrade, required this.delta});
  final String courseCode;
  final String courseName;
  final String fromGrade;
  final double delta;
}

final bestGpaMoveProvider = Provider<BestGpaMove?>((ref) {
  final courses = ref.watch(currentlyRegisteredCoursesProvider).valueOrNull ?? const <CatalogCourse>[];
  final student = ref.watch(currentStudentProvider).requireValue;
  final gradeScale = ref.watch(gradeScaleProvider).requireValue;
  final picks = ref.watch(gpaSimulatorControllerProvider);
  if (courses.isEmpty) return null;

  final baseline = ref.watch(gpaSimulationProvider).projected;
  final totalHoursBase = student.creditHoursCompleted + courses.fold<int>(0, (sum, c) => sum + c.creditHours);

  BestGpaMove? best;
  for (final course in courses) {
    final currentGrade = picks[course.code] ?? _defaultSimulatedGrade;
    if (currentGrade == 'A') continue;
    final currentPoints = gradeScale.pointsForLetter(currentGrade) * course.creditHours;
    final aPoints = gradeScale.pointsForLetter('A') * course.creditHours;
    final projectedWithA = baseline + (aPoints - currentPoints) / totalHoursBase;
    final delta = projectedWithA - baseline;
    if (best == null || delta > best.delta) {
      best = BestGpaMove(courseCode: course.code, courseName: course.name, fromGrade: currentGrade, delta: delta);
    }
  }
  return best;
});
