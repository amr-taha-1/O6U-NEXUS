import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

/// Builds the app's dark and light [ThemeData]. The UI language throughout
/// is Apple HIG / iOS 26, not Material: no elevation shadows, no ripple, no
/// Material app bar. `MaterialApp.router` is used purely as app-shell
/// plumbing (routing, text direction, overlay/sheet infrastructure) — every
/// visible widget comes from `core/widgets/` and is styled off [AppColors].
abstract final class AppTheme {
  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);
  static ThemeData light() => _build(AppColors.light, Brightness.light);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final typography = AppTypography.of(colors.textPrimary, colors.textMuted, colors.textDim);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: colors.accent,
      brightness: brightness,
      surface: colors.ink,
      primary: colors.accent,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.ink,
      canvasColor: colors.ink,
      colorScheme: colorScheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      dividerColor: colors.hairline,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionColor: AppColors.tint(colors.accent, 0.3),
        selectionHandleColor: colors.accent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: colors.textPrimary,
        titleTextStyle: typography.headline,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.solidRaised,
        modalBackgroundColor: colors.solidRaised,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
        elevation: 0,
        showDragHandle: false,
      ),
      textTheme: TextTheme(
        displayLarge: typography.largeTitle,
        headlineLarge: typography.title1,
        headlineMedium: typography.title2,
        headlineSmall: typography.title3,
        titleMedium: typography.headline,
        bodyLarge: typography.body,
        bodyMedium: typography.callout,
        bodySmall: typography.footnote,
        labelLarge: typography.bodyEmphasized,
        labelMedium: typography.caption1,
        labelSmall: typography.caption2,
      ),
      extensions: [colors, typography],
    );
  }
}
