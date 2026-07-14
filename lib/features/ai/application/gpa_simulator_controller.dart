import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/course_repository.dart';
import '../../../shared/data/student_repository.dart';
import '../../../shared/domain/course.dart';

/// The GPA Simulator's hypothetical grade picks, keyed by course code —
/// defaults to each course's actual current grade. Ports the reference's
/// `GpaSim` local `picks` state (SPECS.gpasim). Grades are segmented picks,
/// not a slider, because a grade is discrete.
class GpaSimulatorController extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    final courses = ref.watch(coursesProvider);
    return {for (final course in courses) course.code: course.grade};
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

final gpaSimulationProvider = Provider<GpaSimulation>((ref) {
  final courses = ref.watch(coursesProvider);
  final student = ref.watch(currentStudentProvider);
  final picks = ref.watch(gpaSimulatorControllerProvider);

  final creditHours = courses.fold<int>(0, (sum, c) => sum + c.creditHours);
  final points = courses.fold<double>(0, (sum, c) {
    final grade = picks[c.code] ?? c.grade;
    return sum + (Course.gradeScale[grade] ?? c.gradePoints) * c.creditHours;
  });
  final projected =
      (student.cumulativeGpa * student.creditHoursCompleted + points) / (student.creditHoursCompleted + creditHours);
  return GpaSimulation(projected: projected, delta: projected - student.cumulativeGpa);
});
