import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// The one card shape every screen uses — a hairline-bordered, faintly
/// raised surface. Two tiers only: [AppCardTier.base] for content sitting
/// directly on the screen background, [AppCardTier.raised] for content
/// nested inside another card or a sheet. Ports the reference's `card(t)`
/// helper.
enum AppCardTier { base, raised }

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.tier = AppCardTier.base,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.borderRadius,
    this.gradient,
    this.dashed = false,
    this.onTap,
  });

  final Widget child;
  final AppCardTier tier;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final bool dashed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = borderRadius ?? AppRadius.cardRadius;
    final fill = tier == AppCardTier.raised ? colors.surfaceRaised : colors.surface;

    Widget content = DecoratedBox(
      decoration: BoxDecoration(
        color: gradient == null ? fill : null,
        gradient: gradient,
        borderRadius: radius,
        border: Border.all(color: colors.hairline, width: 0.5),
      ),
      child: Padding(padding: padding, child: child),
    );

    if (dashed) {
      content = _DashedBorder(radius: radius, color: colors.hairline, child: content);
    }

    if (onTap != null) {
      return _Tappable(onTap: onTap!, borderRadius: radius, child: content);
    }
    return ClipRRect(borderRadius: radius, child: content);
  }
}

class _Tappable extends StatelessWidget {
  const _Tappable({required this.child, required this.onTap, required this.borderRadius});

  final Widget child;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: child,
        ),
      ),
    );
  }
}

/// A dashed hairline outline (the reference's `borderStyle: "dashed"`), used
/// to mark AI-suggested / auto-placed content.
class _DashedBorder extends StatelessWidget {
  const _DashedBorder({required this.child, required this.radius, required this.color});

  final Widget child;
  final BorderRadius radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedRRectPainter(radius: radius, color: color),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({required this.radius, required this.color});
  final BorderRadius radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = radius.toRRect(Offset.zero & size);
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dashWidth = 5.0, dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
