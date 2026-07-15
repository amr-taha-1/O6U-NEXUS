import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/class_notification_scheduler.dart';
import '../../schedule/data/schedule_repository.dart';
import 'class_reminder_settings.dart';

/// Keeps scheduled local notifications in sync with the real timetable and
/// the Settings toggles — watched once, from [AppShell], so any change to
/// either re-schedules automatically. The value itself is never read; this
/// provider exists for its side effect (see docs/Architecture.md "Real data").
final classReminderSyncProvider = FutureProvider<void>((ref) async {
  final sessions = await ref.watch(scheduleProvider.future);
  final enabled = ref.watch(classRemindersEnabledProvider);
  final oneHour = ref.watch(reminderOneHourBeforeProvider);
  final thirtyMin = ref.watch(reminderThirtyMinBeforeProvider);
  final tenMin = ref.watch(reminderTenMinBeforeProvider);

  await ClassNotificationScheduler.rescheduleAll(
    sessions: sessions,
    enabled: enabled,
    oneHourBefore: oneHour,
    thirtyMinBefore: thirtyMin,
    tenMinBefore: tenMin,
  );
});
