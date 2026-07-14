import 'package:flutter/animation.dart';

/// Central source of truth for animation durations/curves. No screen should
/// declare its own `Duration(milliseconds: ...)` — see PROJECT_RULES.md §8.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration entrance = Duration(milliseconds: 340);
  static const Duration sheet = Duration(milliseconds: 340);
  static const Duration push = Duration(milliseconds: 360);
  static const Duration splash = Duration(milliseconds: 1700);
  static const Duration faceIdScan = Duration(milliseconds: 1700);
  static const Duration faceIdSettle = Duration(milliseconds: 1000);

  static const Curve standardCurve = Cubic(0.2, 0.8, 0.2, 1);
  static const Curve sheetCurve = Cubic(0.2, 0.9, 0.2, 1);
  static const Curve popCurve = Cubic(0.2, 1.4, 0.4, 1);
}
