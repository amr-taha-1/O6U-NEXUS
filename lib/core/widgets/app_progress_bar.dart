import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Linear progress bar with an optional threshold tick (the vertical mark at
/// 75% on the Attendance screen's per-course bars — "you are always
/// measured against their line, not ours").
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.color,
    this.thresholdPercent,
    this.height = 6,
  });

  /// 0..1
  final double value;
  final Color? color;
  final double? thresholdPercent;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fill = color ?? colors.accent;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(height),
              child: Container(
                height: height,
                color: colors.textPrimary.withValues(alpha: 0.07),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value.clamp(0, 1),
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(height)),
                  ),
                ),
              ),
            ),
            if (thresholdPercent != null)
              Positioned(
                left: constraints.maxWidth * (thresholdPercent! / 100) - 0.5,
                top: -2,
                child: Container(width: 1, height: height + 4, color: colors.textPrimary.withValues(alpha: 0.45)),
              ),
          ],
        );
      },
    );
  }
}
