import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';

/// The university's attendance threshold. A [Course.attendancePercent] below
/// this is "at risk" everywhere in the app — see PROJECT_RULES.md §7.
const double kAttendanceThreshold = 75;

@freezed
abstract class Course with _$Course {
  const factory Course({
    required String code,
    required String name,
    required String instructor,
    required int attendancePercent,
    required String grade,
    required int creditHours,
    required String nextSession,
    required String room,
  }) = _Course;

  const Course._();

  bool get isAttendanceAtRisk => attendancePercent < kAttendanceThreshold;

  /// Grade points on the 4.0 scale used by [gradePoints] and the GPA
  /// simulator's segmented picker.
  static const gradeScale = <String, double>{
    'A': 4.0,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'C+': 2.5,
    'C': 2.0,
  };

  double get gradePoints => gradeScale[grade] ?? 0;
}
