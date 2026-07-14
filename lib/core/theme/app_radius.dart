import 'package:flutter/widgets.dart';

/// Corner-radius scale. The reference prototype's default card radius is 18;
/// everything else is derived relative to it.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 10;
  static const double lg = 14;
  static const double card = 18;
  static const double xl = 22;
  static const double pill = 999;

  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get pillRadius => BorderRadius.circular(pill);

  /// Bottom-sheet top corners (22pt, per the reference `Sheet` component).
  static const BorderRadius sheetTop = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
}
