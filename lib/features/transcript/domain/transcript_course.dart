import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript_course.freezed.dart';

/// One graded course on the official transcript. `creditHours`/`points` are
/// nullable: the source data only gives them per-course for some semesters
/// (Fall 2023/2024) — everywhere else, only the semester-level totals are
/// known. Rather than guess a plausible-looking number, the UI shows "—"
/// wherever these are null. See PROJECT_RULES.md §5.
@freezed
abstract class TranscriptCourse with _$TranscriptCourse {
  const factory TranscriptCourse({
    required String code,
    required String name,
    required String grade,
    int? creditHours,
    double? points,
  }) = _TranscriptCourse;
}
