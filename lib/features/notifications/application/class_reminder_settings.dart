import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Class-reminder toggles for Settings. In-memory only, matching the
/// existing Quiet Hours / Face ID toggles in
/// `features/profile/application/profile_preferences.dart` — nothing
/// persists across a cold app restart in this sprint.
final classRemindersEnabledProvider = StateProvider<bool>((ref) => true);
final reminderOneHourBeforeProvider = StateProvider<bool>((ref) => true);
final reminderThirtyMinBeforeProvider = StateProvider<bool>((ref) => true);
final reminderTenMinBeforeProvider = StateProvider<bool>((ref) => false);
