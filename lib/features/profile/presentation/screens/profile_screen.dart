import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/application/notifications_controller.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../notifications/presentation/widgets/notifications_sheet.dart';
import '../widgets/check_in_sheet.dart';
import '../widgets/profile_id_card.dart';

/// Identity, access, and a plain-language promise about data. The Profile
/// tab root.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final student = ref.watch(currentStudentProvider);
    final unread = ref.watch(unreadCountProvider);

    return LargeTitleScaffold(
      title: 'Profile',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: ProfileIdCard(student: student),
          ),
          const SectionHeader('Campus'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.qrcode_viewfinder,
                    iconColor: colors.success,
                    title: 'Check in to a lecture',
                    subtitle: 'Geo-fenced Â· Hall B2 in range',
                    onTap: () => showCheckInSheet(context),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.creditcard,
                    iconColor: colors.info,
                    title: 'Campus wallet',
                    subtitle: '${student.walletBalanceEgp.toStringAsFixed(0)} EGP Â· top up at any gate',
                    showChevron: false,
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.bookmark,
                    iconColor: colors.accent,
                    title: 'Saved listings',
                    subtitle: '3 items Â· 1 price drop',
                    showChevron: false,
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Identity & settings'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.person_crop_square,
                    iconColor: colors.accent,
                    title: 'Student ID',
                    subtitle: 'Full-screen digital ID, works offline',
                    onTap: () => context.push(AppRoutes.profileStudentId),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.gear,
                    iconColor: colors.textMuted,
                    title: 'Settings',
                    subtitle: 'App preferences, quiet hours',
                    onTap: () => context.push(AppRoutes.profileSettings),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.rosette,
                    iconColor: colors.warning,
                    title: 'Achievements',
                    subtitle: 'Badges earned this degree',
                    onTap: () => context.push(AppRoutes.profileAchievements),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.info_circle,
                    iconColor: colors.info,
                    title: 'About',
                    subtitle: 'Version, licenses, O6U links',
                    onTap: () => context.push(AppRoutes.profileAbout),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Alerts'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: NavRowCard(
              isFirst: true,
              icon: CupertinoIcons.bell,
              iconColor: colors.warning,
              title: 'Notifications',
              subtitle: unread > 0 ? '$unread unread Â· quiet hours 23:00â€“07:00' : 'Quiet hours 23:00â€“07:00',
              onTap: () => showNotificationsSheet(context),
            ),
          ),
          const SectionHeader('Privacy'),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 8),
            child: AppCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(top: 1), child: Icon(CupertinoIcons.shield, size: 18, color: colors.success)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No lecturer or administrator can read your Nexus conversations.', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                        const SizedBox(height: 5),
                        Text(
                          'The university only ever sees anonymised, aggregated numbers. Your password is never stored â€” the portal is reached with a short-lived token.',
                          style: text.footnote.copyWith(fontSize: 13.5, height: 1.45),
                        ),
                        const SizedBox(height: 11),
                        AppButton(
                          label: 'See what O6U can access',
                          variant: AppButtonVariant.secondary,
                          onPressed: () => context.push(AppRoutes.profilePrivacy),
                        ),
                      ],
                    ),
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
