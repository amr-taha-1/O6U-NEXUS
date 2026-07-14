import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/profile_preferences.dart';

class _Session {
  const _Session(this.icon, this.device, this.location, this.isThisDevice);
  final IconData icon;
  final String device;
  final String location;
  final bool isThisDevice;
}

const _sessions = [
  _Session(CupertinoIcons.device_phone_portrait, 'iPhone 15 Pro', 'Cairo, Egypt · Active now', true),
  _Session(CupertinoIcons.desktopcomputer, 'MacBook Air', '6th of October City · 2 days ago', false),
];

/// Face ID, password, active sessions, and sign-out — all simulated, no
/// backend behind any of it this sprint.
class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final faceId = ref.watch(faceIdEnabledProvider);

    return AppPushScaffold(
      title: 'Security',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Sign-in'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.viewfinder,
                    iconColor: colors.success,
                    title: 'Face ID',
                    subtitle: faceId ? 'On · used to reach Portal and Nexus' : 'Off · password only',
                    showChevron: false,
                    trailing: CupertinoSwitch(
                      value: faceId,
                      onChanged: (on) => ref.read(faceIdEnabledProvider.notifier).state = on,
                    ),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.lock_rotation,
                    iconColor: colors.info,
                    title: 'Change password',
                    subtitle: 'Never stored on this device',
                    onTap: () => AppSnackbar.show(context, message: 'Simulated — no backend yet'),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Active sessions'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < _sessions.length; i++)
                    NavRowCard(
                      isFirst: i == 0,
                      icon: _sessions[i].icon,
                      iconColor: _sessions[i].isThisDevice ? colors.success : colors.textMuted,
                      title: _sessions[i].device,
                      subtitle: _sessions[i].location,
                      showChevron: false,
                      trailing: _sessions[i].isThisDevice ? TagChip(label: 'THIS DEVICE', color: colors.success) : null,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.xxl, AppSpacing.screenMargin, 0),
            child: AppButton(
              label: 'Sign out',
              variant: AppButtonVariant.destructive,
              expand: true,
              onPressed: () => _confirmSignOut(context),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Sign out?'),
        content: const Text("You'll need Face ID or your password to sign back in."),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              AppSnackbar.show(context, message: 'Simulated — no backend yet', kind: AppSnackbarKind.warning);
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
