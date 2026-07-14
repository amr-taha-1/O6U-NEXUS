import 'package:flutter/cupertino.dart';

import '../theme/theme.dart';

/// A tappable icon + title + subtitle row with a trailing chevron, grouped
/// inside a card. Used for Portal's "Records" list, Me's "Campus"/"Alerts"
/// rows, and any settings-style list â€” see PROJECT_RULES.md Â§1 ("promote a
/// repeated widget instead of copying it").
class NavRowCard extends StatelessWidget {
  const NavRowCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
    this.showChevron = true,
    this.isFirst = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showChevron;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: AppColors.tint(iconColor, 0.16), borderRadius: AppRadius.smRadius),
              alignment: Alignment.center,
              child: Icon(icon, size: 15, color: iconColor),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: text.bodyEmphasized.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 1),
                  Text(subtitle, style: text.footnote, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            ?trailing,
            if (showChevron) ...[
              const SizedBox(width: 4),
              Icon(CupertinoIcons.chevron_forward, size: 17, color: colors.textDim),
            ],
          ],
        ),
      ),
    );
  }
}
