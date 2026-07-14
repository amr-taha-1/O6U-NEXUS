import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../theme/theme.dart';
import '../widgets/glow_badge.dart';

class AppTabItem {
  const AppTabItem({required this.icon, required this.label, this.isAi = false});
  final IconData icon;
  final String label;
  final bool isAi;
}

const List<AppTabItem> kAppTabs = [
  AppTabItem(icon: CupertinoIcons.calendar, label: 'Home'),
  AppTabItem(icon: CupertinoIcons.book, label: 'Academics'),
  AppTabItem(icon: CupertinoIcons.sparkles, label: 'AI', isAi: true),
  AppTabItem(icon: CupertinoIcons.person_2, label: 'Campus'),
  AppTabItem(icon: CupertinoIcons.person_crop_circle, label: 'Profile'),
];

/// The five-tab glass bottom bar â€” ports the reference's `TabBar` component,
/// including the AI tab's purple glow when active and alert dot when it has
/// something to say and isn't the active tab.
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.aiHasAlert = false,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool aiHasAlert;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.only(bottom: 22),
          decoration: BoxDecoration(
            color: colors.ink.withValues(alpha: 0.72),
            border: Border(top: BorderSide(color: colors.hairline, width: 0.5)),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  for (var i = 0; i < kAppTabs.length; i++)
                    Expanded(
                      child: _TabButton(
                        item: kAppTabs[i],
                        active: i == currentIndex,
                        showAlertDot: kAppTabs[i].isAi && aiHasAlert && i != currentIndex,
                        onTap: () => onTap(i),
                        colors: colors,
                        text: text,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.active,
    required this.showAlertDot,
    required this.onTap,
    required this.colors,
    required this.text,
  });

  final AppTabItem item;
  final bool active;
  final bool showAlertDot;
  final VoidCallback onTap;
  final AppColors colors;
  final AppTypography text;

  @override
  Widget build(BuildContext context) {
    final iconColor = active ? (item.isAi ? colors.accent : colors.textPrimary) : colors.textDim;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              height: 26,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  if (item.isAi && active)
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [AppColors.tint(colors.accent, 0.45), AppColors.tint(colors.accent, 0)]),
                      ),
                    ),
                  Icon(item.icon, size: 23, color: iconColor),
                  if (showAlertDot)
                    Positioned(
                      top: 0,
                      right: 2,
                      child: GlowBadge(color: colors.accent, ringColor: colors.ink),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: text.caption2.copyWith(
                color: active ? (item.isAi ? colors.accent : colors.textPrimary) : colors.textDim,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
