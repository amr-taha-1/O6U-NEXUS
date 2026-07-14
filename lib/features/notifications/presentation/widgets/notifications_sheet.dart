import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/application/notifications_controller.dart';
import '../../../../shared/domain/app_notification.dart';

/// Carries the app's notification channels into one ranked, honest list.
/// Filters, not folders â€” a student scans by kind and never files anything.
/// See docs/reference/o6u-nexus-ios.tsx SPECS.notifs.
Future<void> showNotificationsSheet(BuildContext context) {
  return showAppBottomSheet(context, builder: (_) => const NotificationsSheet());
}

class NotificationsSheet extends ConsumerWidget {
  const NotificationsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final all = ref.watch(notificationsControllerProvider);
    final filter = ref.watch(notificationCategoryFilterProvider);
    final unread = all.where((n) => n.unread).length;

    final filtered = filter == null ? all : all.where((n) => n.category == filter).toList();
    final days = <String>{for (final n in filtered) n.day}.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notifications', style: text.title1),
                  const SizedBox(height: 2),
                  Text(
                    unread > 0 ? '$unread unread Â· all from your own record' : "You're all caught up",
                    style: text.subhead,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: colors.textPrimary.withValues(alpha: 0.08), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(CupertinoIcons.xmark, size: 15, color: colors.textMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _FilterChip(label: 'All', selected: filter == null, onTap: () => ref.read(notificationCategoryFilterProvider.notifier).set(null)),
              for (final c in NotificationCategory.values)
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: _FilterChip(
                    label: c.label,
                    selected: filter == c,
                    onTap: () => ref.read(notificationCategoryFilterProvider.notifier).set(c),
                  ),
                ),
            ],
          ),
        ),
        for (final day in days) ...[
          SectionHeader(day, topPadding: 20),
          Column(
            children: [
              for (final n in filtered.where((n) => n.day == day))
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: _NotificationTile(notification: n),
                ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        AppButton(
          label: unread > 0 ? 'Mark all as read' : 'Nothing left to read',
          icon: CupertinoIcons.envelope_open,
          variant: AppButtonVariant.secondary,
          expand: true,
          onPressed: unread > 0 ? () => ref.read(notificationsControllerProvider.notifier).markAllRead() : null,
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.tint(colors.accent, 0.16) : colors.surface,
          borderRadius: AppRadius.pillRadius,
          border: Border.all(color: selected ? AppColors.tint(colors.accent, 0.4) : colors.hairline, width: 0.5),
        ),
        child: Text(
          label,
          style: context.textStyles.subhead.copyWith(color: selected ? colors.accent : colors.textMuted, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final unread = notification.unread;
    return AppCard(
      tier: unread ? AppCardTier.raised : AppCardTier.base,
      borderRadius: AppRadius.cardRadius,
      padding: const EdgeInsets.all(13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.tint(notification.accent, unread ? 0.18 : 0.1),
              borderRadius: AppRadius.smRadius,
            ),
            alignment: Alignment.center,
            child: Icon(notification.icon, size: 15, color: notification.accent),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: text.bodyEmphasized.copyWith(color: unread ? colors.textPrimary : colors.textMuted, fontSize: 14.5),
                      ),
                    ),
                    Text(notification.time, style: text.monoMicro.copyWith(fontSize: 11)),
                    if (unread) ...[
                      const SizedBox(width: 6),
                      Container(width: 7, height: 7, decoration: BoxDecoration(color: notification.accent, shape: BoxShape.circle)),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  notification.body,
                  style: text.footnote.copyWith(color: unread ? colors.textMuted : colors.textDim, fontSize: 13),
                ),
                if (notification.actionLabel != null) ...[
                  const SizedBox(height: 9),
                  Container(
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.smRadius,
                      border: Border.all(color: AppColors.tint(notification.accent, 0.35), width: 0.5),
                    ),
                    child: Text(
                      notification.actionLabel!,
                      style: text.subhead.copyWith(color: notification.accent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppMotion.fast);
  }
}
