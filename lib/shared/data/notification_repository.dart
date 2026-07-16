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
          title: 'Room reminder · ISM413',
          body: 'Database Management Systems 2 — lecture in Room 6210, lab in Room 6020, Wednesday.',
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
          title: 'Study reminder · ISM424',
          body: 'Knowledge Management lab is this week — Tuesday, Room 6117.',
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
          icon: CupertinoIcons.calendar,
          accent: colors.warning,
          category: NotificationCategory.academic,
          title: 'Upcoming lab · ISE326A',
          body: 'Geographic Information System lab — Sunday, Room 6301.',
          time: '1d',
          unread: false,
          actionLabel: 'Open schedule',
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
          title: 'Grade posted · ISM312',
          body: 'Operations Research I · A-. Recorded on your official transcript.',
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
