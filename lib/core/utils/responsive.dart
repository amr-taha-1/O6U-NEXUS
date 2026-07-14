import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Breakpoint names used by [ResponsiveBreakpoints] in `main.dart`. Screens
/// should branch on these via the [ResponsiveContext] extension below, not
/// on raw `MediaQuery` width — see PROJECT_RULES.md §6.
abstract final class AppBreakpoints {
  static const compact = 'COMPACT';
  static const medium = 'MEDIUM';
  static const expanded = 'EXPANDED';

  static const mediumWidth = 600.0;
  static const expandedWidth = 840.0;
}

extension ResponsiveContext on BuildContext {
  bool get isCompact => ResponsiveBreakpoints.of(this).smallerOrEqualTo(AppBreakpoints.compact);
  bool get isMedium => ResponsiveBreakpoints.of(this).equals(AppBreakpoints.medium);
  bool get isExpanded => ResponsiveBreakpoints.of(this).largerOrEqualTo(AppBreakpoints.expanded);

  /// Caps a sheet/dialog's width on tablet/web so it doesn't stretch
  /// edge-to-edge — see PROJECT_RULES.md §6.
  double get maxSheetWidth => isCompact ? double.infinity : 480;
}
