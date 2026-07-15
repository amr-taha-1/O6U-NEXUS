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
}
