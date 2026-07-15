import 'package:freezed_annotation/freezed_annotation.dart';

part 'grade_band.freezed.dart';

/// One row of the official O6U grading scale (`assets/data/grade_scale.json`)
/// — a marks-percent range, its letter grade, and its 4.0-scale points.
/// [maxPercent] is exclusive; null means "and above" (the top band, A).
@freezed
abstract class GradeBand with _$GradeBand {
  const factory GradeBand({
    required String letter,
    required double minPercent,
    double? maxPercent,
    required double points,
  }) = _GradeBand;

  const GradeBand._();

  bool covers(double percent) {
    final max = maxPercent;
    return percent >= minPercent && (max == null || percent < max);
  }
}
