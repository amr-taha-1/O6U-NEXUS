import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';

/// The Home dashboard's own config — currently just the greeting name.
/// Everything else the dashboard shows (CGPA, hours, faculty, advisor) is
/// composed from [Student] directly rather than duplicated into this model.
/// Backed by `assets/data/dashboard.json`.
@freezed
abstract class DashboardData with _$DashboardData {
  const factory DashboardData({
    required String greetingName,
  }) = _DashboardData;
}
