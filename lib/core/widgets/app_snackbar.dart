import 'package:flutter/material.dart';

import '../theme/theme.dart';

enum AppSnackbarKind { info, success, warning, error }

/// One snackbar style app-wide, tinted by [kind]. Wraps
/// `ScaffoldMessenger` so callers don't hand-build `SnackBar` widgets.
abstract final class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarKind kind = AppSnackbarKind.info,
  }) {
    final colors = context.colors;
    final accent = switch (kind) {
      AppSnackbarKind.info => colors.accent,
      AppSnackbarKind.success => colors.success,
      AppSnackbarKind.warning => colors.warning,
      AppSnackbarKind.error => colors.danger,
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.solidRaised,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.lgRadius,
            side: BorderSide(color: AppColors.tint(accent, 0.35), width: 0.5),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          content: Row(
            children: [
              Container(width: 4, height: 18, decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Expanded(
                child: Text(message, style: context.textStyles.callout.copyWith(color: colors.textPrimary)),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
