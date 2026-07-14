import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../domain/app_notification.dart';

/// Dummy fixtures reference [AppColors.dark] directly rather than a
/// theme-resolved [BuildContext] color: the reference prototype (and this
/// app's default experience) is dark-first with a single fixed palette for
/// seed content — see the note on `Course`/`ScheduleItem`/`CampusListing`
/// carrying `Color` fields the same way.
class NotificationRepository {
  const NotificationRepository();

  static final AppColors colors = AppColors.dark;

  List<AppNotification> getNotifications() => [
        AppNotification(
          id: 'n1',
          day: 'Today',
          icon: CupertinoIcons.map_pin_ellipse,
          accent: colors.warning,
          category: NotificationCategory.academic,
          title: 'Room changed · CS402',
          body: 'Moved from Hall B2 to Hall A1. Your map is already updated.',
          time: '2m',
          unread: true,
          actionLabel: 'Open the map',
        ),
        AppNotification(
          id: 'n2',
          day: 'Today',
          icon: CupertinoIcons.doc_text,
          accent: colors.due,
          category: NotificationCategory.deadline,
          title: 'Assignment 5 is due Sunday',
          body: 'CS402 · not submitted. This is the last piece of coursework before the quiz.',
          time: '1h',
          unread: true,
          actionLabel: 'Open assignment',
        ),
        AppNotification(
          id: 'n3',
          day: 'Today',
          icon: CupertinoIcons.sparkles,
          accent: colors.accent,
          category: NotificationCategory.nexus,
          title: 'Three study blocks placed',
          body: 'I used your free hours on Tuesday and Thursday. Nothing clashes.',
          time: '3h',
          unread: true,
          actionLabel: 'See the week',
        ),
        AppNotification(
          id: 'n4',
          day: 'Yesterday',
          icon: CupertinoIcons.exclamationmark_triangle,
          accent: colors.warning,
          category: NotificationCategory.academic,
          title: 'MA201 attendance fell to 68%',
          body: 'That is below the 75% threshold. Four lectures brings it back.',
          time: '1d',
          unread: false,
          actionLabel: 'Ask Nexus to fix this',
        ),
        AppNotification(
          id: 'n5',
          day: 'Yesterday',
          icon: CupertinoIcons.tag,
          accent: colors.success,
          category: NotificationCategory.campus,
          title: 'Your listing sold',
          body: 'Calculus textbook · 120 EGP. Mariam will collect it at Gate 3.',
          time: '1d',
          unread: false,
        ),
        AppNotification(
          id: 'n6',
          day: 'Yesterday',
          icon: CupertinoIcons.book,
          accent: colors.info,
          category: NotificationCategory.academic,
          title: 'Grade posted · CS310',
          body: 'Databases · A. Your cumulative GPA moved to 3.12.',
          time: '1d',
          unread: false,
        ),
      ];
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) => const NotificationRepository());

final notificationsProvider = Provider<List<AppNotification>>((ref) {
  return ref.watch(notificationRepositoryProvider).getNotifications();
});

/// Count of unread notifications — drives the Home bell badge, the AI tab's
/// alert dot (when there's something worth surfacing), and Profile's
/// "Alerts" row subtitle.
final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).where((n) => n.unread).length;
});
