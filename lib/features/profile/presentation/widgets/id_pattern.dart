import 'package:flutter/widgets.dart';

/// A stylized fake QR pattern on the digital-ID card — decorative only
/// (ports the reference's fixed 5×5 cell pattern). Not a real scannable
/// code; that arrives with the backend.
class IdPattern extends StatelessWidget {
  const IdPattern({super.key, this.size = 62});

  final double size;

  static const _filled = {0, 1, 2, 5, 7, 10, 12, 14, 17, 18, 20, 22, 24, 3, 9, 15};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(size * 0.13),
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var i = 0; i < 25; i++)
            DecoratedBox(
              decoration: BoxDecoration(
                color: _filled.contains(i) ? const Color(0xFF090B12) : const Color(0x00000000),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }
}
