import 'package:flutter/widgets.dart';

/// The small GPA-trend line + dot on the Portal hero card and Transcript.
/// Values are plotted against [min]/[max] so the chart isn't specific to
/// GPA's 0–4 scale (reused for other 6-point trend fixtures if needed).
class GpaSparkline extends StatelessWidget {
  const GpaSparkline({
    super.key,
    required this.values,
    required this.color,
    this.min = 2.5,
    this.max = 4.0,
    this.width = 120,
    this.height = 62,
  });

  final List<double> values;
  final Color color;
  final double min;
  final double max;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _SparklinePainter(values: values, color: color, min: min, max: max),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.color, required this.min, required this.max});

  final List<double> values;
  final Color color;
  final double min, max;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final dx = values.length > 1 ? size.width / (values.length - 1) : 0.0;
    double yFor(double v) => size.height - ((v - min) / (max - min)).clamp(0, 1) * size.height;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final point = Offset(dx * i, yFor(values[i]));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, linePaint);

    final last = Offset(dx * (values.length - 1), yFor(values.last));
    canvas.drawCircle(last, 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}
