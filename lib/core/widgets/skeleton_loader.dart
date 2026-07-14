import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Shimmering placeholder block for content that's still "loading" (dummy
/// data resolves instantly today, but every screen that will eventually
/// read from a network `FutureProvider` gets a skeleton state now so the
/// swap-in later is free).
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({super.key, this.width, this.height = 16, this.borderRadius});

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.colors.textPrimary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: base.withValues(alpha: 0.05 + _controller.value * 0.05),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(6),
          ),
        );
      },
    );
  }
}

/// A skeleton mimicking [NavRowCard]'s layout, for list screens.
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key, this.isFirst = false});

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        border: isFirst ? null : Border(top: BorderSide(color: context.colors.hairline, width: 0.5)),
      ),
      child: Row(
        children: [
          SkeletonBox(width: 30, height: 30, borderRadius: AppRadius.smRadius),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SkeletonBox(width: 140, height: 14),
                SizedBox(height: 6),
                SkeletonBox(width: 90, height: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
