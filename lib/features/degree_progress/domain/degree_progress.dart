import 'package:freezed_annotation/freezed_annotation.dart';

part 'degree_progress.freezed.dart';

/// One requirement bucket toward the degree (University Requirements,
/// College Requirements, Department Mandatory, Department Electives).
@freezed
abstract class DegreeRequirementCategory with _$DegreeRequirementCategory {
  const factory DegreeRequirementCategory({
    required String name,
    required int requiredHours,
    required int completedHours,
  }) = _DegreeRequirementCategory;

  const DegreeRequirementCategory._();

  int get remainingHours => requiredHours - completedHours;
  double get progress => requiredHours == 0 ? 1 : completedHours / requiredHours;
}

/// The official degree-audit breakdown. Backed by
/// `assets/data/degree_progress.json`.
@freezed
abstract class DegreeProgress with _$DegreeProgress {
  const factory DegreeProgress({
    required List<DegreeRequirementCategory> categories,
    required int graduationHoursRequired,
    required int graduationHoursCompleted,
    required double cgpa,
  }) = _DegreeProgress;

  const DegreeProgress._();

  int get graduationHoursRemaining => graduationHoursRequired - graduationHoursCompleted;
  double get overallProgress => graduationHoursCompleted / graduationHoursRequired;
}
