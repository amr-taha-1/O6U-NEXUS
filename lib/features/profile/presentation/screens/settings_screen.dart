import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/services/theme_mode_controller.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../notifications/application/class_reminder_settings.dart';
import '../../application/profile_preferences.dart';

/// Appearance, notifications, language, and the way in to Privacy/Security —
/// the reference's `me` job statement extended into a real settings list.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final themeMode = ref.watch(themeModeControllerProvider);
    final isDark = themeMode == ThemeMode.dark;
    final quietHours = ref.watch(quietHoursEnabledProvider);
    final remindersEnabled = ref.watch(classRemindersEnabledProvider);
    final oneHourBefore = ref.watch(reminderOneHourBeforeProvider);
    final thirtyMinBefore = ref.watch(reminderThirtyMinBeforeProvider);
    final tenMinBefore = ref.watch(reminderTenMinBeforeProvider);

    return AppPushScaffold(
      title: 'Settings',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Appearance'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: NavRowCard(
                isFirst: true,
                icon: CupertinoIcons.moon_stars_fill,
                iconColor: colors.accent,
                title: 'Dark mode',
                subtitle: isDark ? 'On · the app\'s default look' : 'Off · light appearance',
                showChevron: false,
                trailing: CupertinoSwitch(
                  value: isDark,
                  onChanged: (on) => ref.read(themeModeControllerProvider.notifier).set(on ? ThemeMode.dark : ThemeMode.light),
                ),
              ),
            ),
          ),
          const SectionHeader('Notifications'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: NavRowCard(
                isFirst: true,
                icon: CupertinoIcons.moon_zzz,
                iconColor: colors.info,
                title: 'Quiet hours',
                subtitle: quietHours ? '23:00–07:00 · notifications held until morning' : 'Off · notifications arrive any time',
                showChevron: false,
                trailing: CupertinoSwitch(
                  value: quietHours,
                  onChanged: (on) => ref.read(quietHoursEnabledProvider.notifier).state = on,
                ),
              ),
            ),
          ),
          const SectionHeader('Class reminders'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.bell_fill,
                    iconColor: colors.accent,
                    title: 'Class reminders',
                    subtitle: remindersEnabled ? 'On · alerts before lectures and labs' : 'Off',
                    showChevron: false,
                    trailing: CupertinoSwitch(
                      value: remindersEnabled,
                      onChanged: (on) => ref.read(classRemindersEnabledProvider.notifier).state = on,
                    ),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.time,
                    iconColor: colors.info,
                    title: '1 hour before',
                    subtitle: 'Every lecture and lab',
                    showChevron: false,
                    trailing: CupertinoSwitch(
                      value: oneHourBefore,
                      onChanged: remindersEnabled
                          ? (on) => ref.read(reminderOneHourBeforeProvider.notifier).state = on
                          : null,
                    ),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.time,
                    iconColor: colors.info,
                    title: '30 minutes before',
                    subtitle: 'Every lecture and lab',
                    showChevron: false,
                    trailing: CupertinoSwitch(
                      value: thirtyMinBefore,
                      onChanged: remindersEnabled
                          ? (on) => ref.read(reminderThirtyMinBeforeProvider.notifier).state = on
                          : null,
                    ),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.time,
                    iconColor: colors.info,
                    title: '10 minutes before',
                    subtitle: 'Every lecture and lab',
                    showChevron: false,
                    trailing: CupertinoSwitch(
                      value: tenMinBefore,
                      onChanged: remindersEnabled
                          ? (on) => ref.read(reminderTenMinBeforeProvider.notifier).state = on
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('General'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: NavRowCard(
                isFirst: true,
                icon: CupertinoIcons.globe,
                iconColor: colors.textMuted,
                title: 'Language',
                subtitle: 'English',
                showChevron: false,
              ),
            ),
          ),
          const SectionHeader('Privacy & security'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.shield,
                    iconColor: colors.success,
                    title: 'Privacy',
                    subtitle: 'What O6U can access',
                    onTap: () => context.push(AppRoutes.profilePrivacy),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.lock,
                    iconColor: colors.warning,
                    title: 'Security',
                    subtitle: 'Face ID, password, sessions',
                    onTap: () => context.push(AppRoutes.profileSecurity),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
