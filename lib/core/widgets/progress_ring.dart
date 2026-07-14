import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// The attendance ring: green at/above [threshold], amber below it. Ports
/// the reference's `Ring` component — used on Portal, Attendance, and the
/// course details sheet.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.percent,
    this.size = 38,
    this.threshold = 75,
    this.strokeWidth = 3.5,
    this.showLabel = true,
  });

  final int percent;
  final double size;
  final double threshold;
  final double strokeWidth;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ringColor = percent < threshold ? colors.warning : colors.success;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              percent: percent / 100,
              trackColor: colors.textPrimary.withValues(alpha: 0.1),
              progressColor: ringColor,
              strokeWidth: strokeWidth,
            ),
          ),
          if (showLabel)
            Text(
              '$percent',
              style: context.textStyles.monoSmall.copyWith(color: ringColor, fontSize: size < 50 ? 10 : 14),
            ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percent,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double percent;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final progress = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent.clamp(0, 1),
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.percent != percent || oldDelegate.progressColor != progressColor;
}
