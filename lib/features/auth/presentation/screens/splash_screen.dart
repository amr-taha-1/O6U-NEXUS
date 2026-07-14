import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Not a loading screen — the mark holding still while a (simulated) session
/// token is validated. See docs/reference/o6u-nexus-ios.tsx SPECS.auth pin
/// #1.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(AppMotion.splash, () {
      if (mounted) context.go(AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return ColoredBox(
      color: colors.ink,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.tint(colors.accentDeep, 0.3), AppColors.tint(colors.accentDeep, 0)],
                ),
              ),
            ).animate().fadeIn(duration: 900.ms, curve: AppMotion.standardCurve),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppMark(size: 84),
                const SizedBox(height: 18),
                Text('O6U Nexus', style: text.title1),
                const SizedBox(height: 4),
                Text('October 6 University', style: text.footnote.copyWith(color: colors.textDim)),
              ],
            ).animate().scale(begin: const Offset(0.6, 0.6), curve: AppMotion.popCurve, duration: 400.ms).fadeIn(duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
