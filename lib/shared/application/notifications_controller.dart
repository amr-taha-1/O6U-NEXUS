import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_repository.dart';
import '../domain/app_notification.dart';

/// Read/unread state layered on top of the static notification fixtures —
/// shared because both Home (bell badge) and Profile (Alerts row) read the
/// unread count, and the Notifications sheet is reachable from either.
class NotificationsController extends Notifier<List<AppNotification>> {
  @override
  List<AppNotification> build() {
    return ref.watch(notificationsProvider);
  }

  void markAllRead() {
    state = [for (final n in state) n.copyWith(unread: false)];
  }
}

final notificationsControllerProvider = NotifierProvider<NotificationsController, List<AppNotification>>(
  NotificationsController.new,
);

final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsControllerProvider).where((n) => n.unread).length;
});

final notificationCategoryFilterProvider = NotifierProvider<_CategoryFilterNotifier, NotificationCategory?>(
  _CategoryFilterNotifier.new,
);

class _CategoryFilterNotifier extends Notifier<NotificationCategory?> {
  @override
  NotificationCategory? build() => null;

  void set(NotificationCategory? category) => state = category;
}
