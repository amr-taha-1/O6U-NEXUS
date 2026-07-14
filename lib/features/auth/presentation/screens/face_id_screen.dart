import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/data/student_repository.dart';

class FaceIdScreen extends ConsumerStatefulWidget {
  const FaceIdScreen({super.key});

  @override
  ConsumerState<FaceIdScreen> createState() => _FaceIdScreenState();
}

class _FaceIdScreenState extends ConsumerState<FaceIdScreen> {
  bool _done = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(AppMotion.faceIdScan, () {
      if (mounted) setState(() => _done = true);
    });
    Future.delayed(AppMotion.faceIdScan + AppMotion.faceIdSettle, () {
      if (mounted) context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final firstName = ref.watch(currentStudentProvider).name.split(' ').first;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: ColoredBox(
          color: colors.ink.withValues(alpha: 0.86),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 116,
                    height: 116,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!_done) ...[
                          _ScanRing(color: colors.accent, inset: 0)
                              .animate(onPlay: (c) => c.repeat())
                              .scaleXY(begin: 0.9, end: 1, duration: 1700.ms, curve: Curves.easeInOut)
                              .fadeIn(duration: 850.ms),
                          _ScanRing(color: colors.info, inset: 12)
                              .animate(onPlay: (c) => c.repeat())
                              .scaleXY(begin: 0.9, end: 1, duration: 1700.ms, delay: 250.ms, curve: Curves.easeInOut),
                        ],
                        if (_done)
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(color: AppColors.tint(colors.success, 0.16), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Icon(CupertinoIcons.check_mark, size: 46, color: colors.success),
                          ).animate().scale(begin: const Offset(0.6, 0.6), curve: AppMotion.popCurve)
                        else
                          Icon(CupertinoIcons.viewfinder, size: 64, color: colors.accent),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(_done ? 'Face ID Â· $firstName' : 'Look at iPhone', style: text.title3),
                  const SizedBox(height: 6),
                  Text(
                    _done ? 'Unlocking your recordâ€¦' : 'Authenticating with the Secure Enclave',
                    style: text.callout,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanRing extends StatelessWidget {
  const _ScanRing({required this.color, required this.inset});
  final Color color;
  final double inset;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: inset,
      top: inset,
      right: inset,
      bottom: inset,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32 - inset),
          border: Border.all(color: AppColors.tint(color, 0.45), width: 2),
        ),
      ),
    );
  }
}
