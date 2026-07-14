import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// A colored pill of text — grade chips, AI evidence chips, notification
/// category filters, verification badges. One shape, tinted by [color].
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.filled = false,
    this.selected = true,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final bool filled;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    final effective = selected ? color : context.colors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? effective : AppColors.tint(effective, 0.12),
        borderRadius: AppRadius.smRadius,
        border: filled ? null : Border.all(color: AppColors.tint(effective, 0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: filled ? context.colors.onAccent : effective),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: text.caption1.copyWith(
              color: filled ? context.colors.onAccent : effective,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
