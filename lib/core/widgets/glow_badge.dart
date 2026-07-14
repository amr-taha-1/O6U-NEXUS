import 'package:flutter/widgets.dart';

/// The small solid dot used for "unread" markers and the AI tab's alert
/// indicator, with a hairline ring matching the background it sits on so it
/// reads as a notch, not a sticker.
class GlowBadge extends StatelessWidget {
  const GlowBadge({super.key, required this.color, required this.ringColor, this.size = 7});

  final Color color;
  final Color ringColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: ringColor, width: 1.5),
      ),
    );
  }
}
