/// 4pt-base spacing scale. Use these instead of raw numbers in `EdgeInsets`,
/// `SizedBox`, and `Gap`-style widgets so spacing stays consistent app-wide.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;

  /// Standard horizontal screen margin (matches the reference's `margin: "0 20px"`).
  static const double screenMargin = 20;
}
