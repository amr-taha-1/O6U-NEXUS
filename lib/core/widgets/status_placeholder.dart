import 'package:flutter/cupertino.dart';

import '../theme/theme.dart';
import 'app_button.dart';

enum StatusPlaceholderKind { empty, error, success }

/// Full-bleed placeholder for "nothing here yet," "something went wrong,"
/// and "done" states â€” the reference prototype's zero-message Nexus screen
/// and check-in success screen generalized into one reusable widget.
class StatusPlaceholder extends StatelessWidget {
  const StatusPlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.kind = StatusPlaceholderKind.empty,
    this.actionLabel,
    this.onAction,
  });

  const StatusPlaceholder.empty({
    super.key,
    this.icon = CupertinoIcons.tray,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : kind = StatusPlaceholderKind.empty;

  const StatusPlaceholder.error({
    super.key,
    this.icon = CupertinoIcons.exclamationmark_triangle,
    this.title = 'Something went wrong',
    required this.message,
    this.actionLabel = 'Try again',
    this.onAction,
  }) : kind = StatusPlaceholderKind.error;

  const StatusPlaceholder.success({
    super.key,
    this.icon = CupertinoIcons.check_mark_circled_solid,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : kind = StatusPlaceholderKind.success;

  final IconData icon;
  final String title;
  final String message;
  final StatusPlaceholderKind kind;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final accent = switch (kind) {
      StatusPlaceholderKind.empty => colors.textDim,
      StatusPlaceholderKind.error => colors.danger,
      StatusPlaceholderKind.success => colors.success,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: AppColors.tint(accent, 0.14), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: 26, color: accent),
          ),
          const SizedBox(height: 16),
          Text(title, style: text.headline, textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(message, style: text.callout, textAlign: TextAlign.center),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 18),
            AppButton(label: actionLabel!, onPressed: onAction, variant: AppButtonVariant.secondary),
          ],
        ],
      ),
    );
  }
}
