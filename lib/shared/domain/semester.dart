import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/transcript/domain/transcript_course.dart';

part 'semester.freezed.dart';

/// One term on the official transcript: its GPA, hours, quality points, and
/// the graded courses within it. Backed by `assets/data/transcript.json`.
@freezed
abstract class Semester with _$Semester {
  const factory Semester({
    required String label,
    required double gpa,
    required int creditHours,
    required double points,
    required List<TranscriptCourse> courses,
  }) = _Semester;
}
