import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';

/// One shortcut on the Home dashboard's "Quick actions" row.
@freezed
abstract class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String label,
    required String iconName,
    required String route,
  }) = _QuickAction;
}

/// The Home dashboard's own config — greeting name and quick-action
/// shortcuts. Everything else the dashboard shows (CGPA, hours, faculty,
/// advisor, recent semester) is composed from [Student]/[Semester] directly
/// rather than duplicated into this model. Backed by
/// `assets/data/dashboard.json`.
@freezed
abstract class DashboardData with _$DashboardData {
  const factory DashboardData({
    required String greetingName,
    required List<QuickAction> quickActions,
  }) = _DashboardData;
}
