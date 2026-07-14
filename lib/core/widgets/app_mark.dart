import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// The O6U Nexus brand mark — a stylized "N" stroke in the purple→blue
/// gradient, on a dark rounded-square field. Ports the reference's `Mark`
/// SVG exactly (viewBox 0 0 100 100).
class AppMark extends StatelessWidget {
  const AppMark({super.key, this.size = 76});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _MarkPainter(colors: context.colors)),
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter({required this.colors});
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 100;
    Offset p(double x, double y) => Offset(x * s, y * s);

    final field = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 * s, 2 * s, 96 * s, 96 * s),
      Radius.circular(26 * s),
    );
    canvas.drawRRect(field, Paint()..color = const Color(0xFF0B0E17));
    canvas.drawRRect(
      field,
      Paint()
        ..color = colors.textPrimary.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final path = Path()
      ..moveTo(p(30, 72).dx, p(30, 72).dy)
      ..lineTo(p(30, 28).dx, p(30, 28).dy)
      ..lineTo(p(70, 72).dx, p(70, 72).dy)
      ..lineTo(p(70, 28).dx, p(70, 28).dy);

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = LinearGradient(
        colors: [colors.accent, colors.info],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, strokePaint);
    canvas.drawCircle(p(30, 28), 5.5 * s, Paint()..color = colors.accent);
    canvas.drawCircle(p(70, 72), 5.5 * s, Paint()..color = colors.info);
  }

  @override
  bool shouldRepaint(covariant _MarkPainter oldDelegate) => oldDelegate.colors != colors;
}
