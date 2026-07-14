import 'package:flutter/material.dart';

/// Semantic color tokens for O6U Nexus, ported from the design reference at
/// docs/reference/o6u-nexus-ios.tsx (`const T = {...}`). Every screen reads
/// color through this extension — never a raw hex value — so a single accent
/// keeps a single meaning app-wide (e.g. [warning] always means "below
/// threshold / at risk").
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.ink,
    required this.surface,
    required this.surfaceRaised,
    required this.hairline,
    required this.textPrimary,
    required this.textMuted,
    required this.textDim,
    required this.accent,
    required this.accentDeep,
    required this.info,
    required this.infoDeep,
    required this.success,
    required this.warning,
    required this.danger,
    required this.due,
    required this.onAccent,
  });

  /// The base app background ("ink" in the reference).
  final Color ink;

  /// First-level raised surface (cards).
  final Color surface;

  /// Second-level raised surface (nested cards, sheets, input fields).
  final Color surfaceRaised;

  /// 0.5pt hairline borders/dividers.
  final Color hairline;

  final Color textPrimary;
  final Color textMuted;
  final Color textDim;

  /// Nexus purple — the AI identity color.
  final Color accent;
  final Color accentDeep;

  /// Informational blue — used for links, info chips, "in progress."
  final Color info;
  final Color infoDeep;

  /// Green — the only color that means "on track / above threshold."
  final Color success;

  /// Amber — the only color that means "below threshold / at risk."
  final Color warning;

  /// Red — destructive / critical only.
  final Color danger;

  /// Pink — deadlines/dues only.
  final Color due;

  /// Text/icon color to place on top of a solid [accent] fill.
  final Color onAccent;

  static const dark = AppColors(
    ink: Color(0xFF090B12),
    surface: Color(0x0BFFFFFF), // rgba(255,255,255,0.045)
    surfaceRaised: Color(0x13FFFFFF), // rgba(255,255,255,0.075)
    hairline: Color(0x17FFFFFF), // rgba(255,255,255,0.09)
    textPrimary: Color(0xFFF2F4FA),
    textMuted: Color(0xFF8B93AD),
    textDim: Color(0xFF5C6480),
    accent: Color(0xFFA78BFA),
    accentDeep: Color(0xFF7C3AED),
    info: Color(0xFF60A5FA),
    infoDeep: Color(0xFF2563EB),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    danger: Color(0xFFF87171),
    due: Color(0xFFF472B6),
    onAccent: Color(0xFFFFFFFF),
  );

  static const light = AppColors(
    ink: Color(0xFFF6F7FB),
    surface: Color(0x08000000),
    surfaceRaised: Color(0x0F000000),
    hairline: Color(0x14000000),
    textPrimary: Color(0xFF0B0D14),
    textMuted: Color(0xFF5B6178),
    textDim: Color(0xFF9AA0B4),
    accent: Color(0xFF7C3AED),
    accentDeep: Color(0xFF6D28D9),
    info: Color(0xFF2563EB),
    infoDeep: Color(0xFF1D4ED8),
    success: Color(0xFF0F9D6D),
    warning: Color(0xFFB45309),
    danger: Color(0xFFDC2626),
    due: Color(0xFFDB2777),
    onAccent: Color(0xFFFFFFFF),
  );

  /// Tints [color] to [alpha] opacity — the Flutter equivalent of the
  /// reference's `tint(hex, a)` helper.
  static Color tint(Color color, double alpha) => color.withValues(alpha: alpha);

  /// [surfaceRaised] composited onto [ink] as an opaque color — for
  /// surfaces (sheets, snackbars, popovers) that must sit *above* other
  /// content and can't rely on transparency compositing correctly.
  Color get solidRaised => Color.alphaBlend(surfaceRaised, ink);

  @override
  AppColors copyWith({
    Color? ink,
    Color? surface,
    Color? surfaceRaised,
    Color? hairline,
    Color? textPrimary,
    Color? textMuted,
    Color? textDim,
    Color? accent,
    Color? accentDeep,
    Color? info,
    Color? infoDeep,
    Color? success,
    Color? warning,
    Color? danger,
    Color? due,
    Color? onAccent,
  }) {
    return AppColors(
      ink: ink ?? this.ink,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      hairline: hairline ?? this.hairline,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textDim: textDim ?? this.textDim,
      accent: accent ?? this.accent,
      accentDeep: accentDeep ?? this.accentDeep,
      info: info ?? this.info,
      infoDeep: infoDeep ?? this.infoDeep,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      due: due ?? this.due,
      onAccent: onAccent ?? this.onAccent,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      ink: Color.lerp(ink, other.ink, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentDeep: Color.lerp(accentDeep, other.accentDeep, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoDeep: Color.lerp(infoDeep, other.infoDeep, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      due: Color.lerp(due, other.due, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
