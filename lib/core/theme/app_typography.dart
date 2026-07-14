import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The reference prototype's font stack is
/// `-apple-system, "SF Pro Display", "SF Pro Text", system-ui, ...` — i.e.
/// "use the real platform font." Flutter's reserved `.SF Pro Text` family
/// name resolves to genuine San Francisco on iOS/macOS and gracefully falls
/// back to the platform default (Roboto, etc.) everywhere else, so we don't
/// bundle a UI font. Numbers a student re-checks (GPA, attendance %, IDs,
/// countdowns) use a monospace face everywhere via google_fonts, matching
/// the reference's `SF Mono` usage.
const String _uiFontFamily = '.SF Pro Text';

TextStyle _mono({
  required double fontSize,
  required FontWeight fontWeight,
  double? letterSpacing,
  Color? color,
  double? height,
}) {
  return GoogleFonts.robotoMono(
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    color: color,
    height: height,
  );
}

TextStyle _ui({
  required double fontSize,
  required FontWeight fontWeight,
  double? letterSpacing,
  Color? color,
  double? height,
}) {
  return TextStyle(
    fontFamily: _uiFontFamily,
    fontFamilyFallback: const ['Roboto', 'Segoe UI', 'sans-serif'],
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    color: color,
    height: height,
  );
}

/// UI + monospace type scale, ported from the reference prototype's ad hoc
/// `fontSize`/`fontWeight` pairs. Access via `Theme.of(context).appText`.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.largeTitle,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.headline,
    required this.bodyEmphasized,
    required this.body,
    required this.callout,
    required this.subhead,
    required this.footnote,
    required this.caption1,
    required this.caption2,
    required this.monoDisplay,
    required this.monoTitle,
    required this.monoLarge,
    required this.monoBody,
    required this.monoSmall,
    required this.monoMicro,
  });

  /// 34/700, ls -0.8 — collapsing large nav title.
  final TextStyle largeTitle;

  /// 26/700, ls -0.6 — sheet headline (e.g. Notifications sheet title).
  final TextStyle title1;

  /// 24/700, ls -0.4 — course-sheet / profile-header name.
  final TextStyle title2;

  /// 19/700 — sub-section hero numbers (e.g. "96% on-time").
  final TextStyle title3;

  /// 17/600 — inline nav title, list-row emphasis.
  final TextStyle headline;

  /// 15.5/600 — card titles, chat bubble emphasis.
  final TextStyle bodyEmphasized;

  /// 15.5/400 — default body copy.
  final TextStyle body;

  /// 14.5/500 — secondary body copy (card subtitles).
  final TextStyle callout;

  /// 13.5/500 — meta lines (dates, room numbers).
  final TextStyle subhead;

  /// 12.5/500 — smallest readable label.
  final TextStyle footnote;

  /// 11.5/600 — chip / badge text.
  final TextStyle caption1;

  /// 10/700, ls 0.6, uppercase — section headers.
  final TextStyle caption2;

  /// 52/700, ls -2 — GPA simulator hero number.
  final TextStyle monoDisplay;

  /// 40/700, ls -1.4 — cumulative GPA hero number.
  final TextStyle monoTitle;

  /// 22/700 — next-up class time.
  final TextStyle monoLarge;

  /// 14/700 — grade chips, GPA figures inline.
  final TextStyle monoBody;

  /// 12/600 — ring center labels, stat values.
  final TextStyle monoSmall;

  /// 10/600 — timeline timestamps.
  final TextStyle monoMicro;

  static AppTypography of(Color primary, Color muted, Color dim) {
    return AppTypography(
      largeTitle: _ui(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -0.8, color: primary),
      title1: _ui(fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: primary),
      title2: _ui(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: primary),
      title3: _ui(fontSize: 19, fontWeight: FontWeight.w700, color: primary),
      headline: _ui(fontSize: 17, fontWeight: FontWeight.w600, color: primary),
      bodyEmphasized: _ui(fontSize: 15.5, fontWeight: FontWeight.w600, color: primary),
      body: _ui(fontSize: 15.5, fontWeight: FontWeight.w400, color: primary, height: 1.4),
      callout: _ui(fontSize: 14.5, fontWeight: FontWeight.w500, color: muted, height: 1.4),
      subhead: _ui(fontSize: 13.5, fontWeight: FontWeight.w500, color: muted),
      footnote: _ui(fontSize: 12.5, fontWeight: FontWeight.w500, color: muted),
      caption1: _ui(fontSize: 11.5, fontWeight: FontWeight.w600, color: muted),
      caption2: _ui(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: dim),
      monoDisplay: _mono(fontSize: 52, fontWeight: FontWeight.w700, letterSpacing: -2, color: primary),
      monoTitle: _mono(fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -1.4, color: primary),
      monoLarge: _mono(fontSize: 22, fontWeight: FontWeight.w700, color: primary),
      monoBody: _mono(fontSize: 14, fontWeight: FontWeight.w700, color: primary),
      monoSmall: _mono(fontSize: 12, fontWeight: FontWeight.w600, color: primary),
      monoMicro: _mono(fontSize: 10, fontWeight: FontWeight.w600, color: dim),
    );
  }

  @override
  AppTypography copyWith({
    TextStyle? largeTitle,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? headline,
    TextStyle? bodyEmphasized,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? subhead,
    TextStyle? footnote,
    TextStyle? caption1,
    TextStyle? caption2,
    TextStyle? monoDisplay,
    TextStyle? monoTitle,
    TextStyle? monoLarge,
    TextStyle? monoBody,
    TextStyle? monoSmall,
    TextStyle? monoMicro,
  }) {
    return AppTypography(
      largeTitle: largeTitle ?? this.largeTitle,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      headline: headline ?? this.headline,
      bodyEmphasized: bodyEmphasized ?? this.bodyEmphasized,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subhead: subhead ?? this.subhead,
      footnote: footnote ?? this.footnote,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
      monoDisplay: monoDisplay ?? this.monoDisplay,
      monoTitle: monoTitle ?? this.monoTitle,
      monoLarge: monoLarge ?? this.monoLarge,
      monoBody: monoBody ?? this.monoBody,
      monoSmall: monoSmall ?? this.monoSmall,
      monoMicro: monoMicro ?? this.monoMicro,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    TextStyle l(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return AppTypography(
      largeTitle: l(largeTitle, other.largeTitle),
      title1: l(title1, other.title1),
      title2: l(title2, other.title2),
      title3: l(title3, other.title3),
      headline: l(headline, other.headline),
      bodyEmphasized: l(bodyEmphasized, other.bodyEmphasized),
      body: l(body, other.body),
      callout: l(callout, other.callout),
      subhead: l(subhead, other.subhead),
      footnote: l(footnote, other.footnote),
      caption1: l(caption1, other.caption1),
      caption2: l(caption2, other.caption2),
      monoDisplay: l(monoDisplay, other.monoDisplay),
      monoTitle: l(monoTitle, other.monoTitle),
      monoLarge: l(monoLarge, other.monoLarge),
      monoBody: l(monoBody, other.monoBody),
      monoSmall: l(monoSmall, other.monoSmall),
      monoMicro: l(monoMicro, other.monoMicro),
    );
  }
}

extension AppTypographyContext on BuildContext {
  AppTypography get textStyles => Theme.of(this).extension<AppTypography>()!;
}
