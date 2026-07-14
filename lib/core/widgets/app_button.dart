import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

enum AppButtonVariant { primary, secondary, tertiary, destructive }

/// The one button every screen uses. No `ElevatedButton`/`TextButton` —
/// Material's ripple/elevation doesn't belong in this design language (see
/// PROJECT_RULES.md §7). Always ≥44pt tall.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool expand;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final disabled = widget.onPressed == null;

    final Color background;
    final Color foreground;
    final Border? border;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        background = colors.accentDeep;
        foreground = colors.onAccent;
        border = null;
      case AppButtonVariant.secondary:
        background = colors.surfaceRaised;
        foreground = colors.textPrimary;
        border = Border.all(color: colors.hairline, width: 0.5);
      case AppButtonVariant.tertiary:
        background = const Color(0x00000000);
        foreground = colors.textMuted;
        border = null;
      case AppButtonVariant.destructive:
        background = AppColors.tint(colors.danger, 0.14);
        foreground = colors.danger;
        border = Border.all(color: AppColors.tint(colors.danger, 0.3), width: 0.5);
    }

    Widget content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 17, color: disabled ? foreground.withValues(alpha: 0.4) : foreground),
          const SizedBox(width: 7),
        ],
        Flexible(
          child: Text(
            widget.label,
            style: text.bodyEmphasized.copyWith(
              color: disabled ? foreground.withValues(alpha: 0.4) : foreground,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
      onTapCancel: disabled ? null : () => setState(() => _pressed = false),
      onTapUp: disabled ? null : (_) => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        opacity: _pressed ? 0.7 : 1,
        duration: AppMotion.fast,
        child: Container(
          width: widget.expand ? double.infinity : null,
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: background,
            borderRadius: AppRadius.lgRadius,
            border: border,
          ),
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );
  }
}
