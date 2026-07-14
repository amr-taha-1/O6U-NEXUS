import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class _OnboardingPage {
  const _OnboardingPage({required this.icon, required this.color, required this.title, required this.body});
  final IconData icon;
  final Color Function(AppColors) color;
  final String title;
  final String body;
}

final _pages = [
  _OnboardingPage(
    icon: CupertinoIcons.compass,
    color: (c) => c.info,
    title: 'Everything campus,\nin one app.',
    body:
        'Grades, attendance, timetable, marketplace and the people around you â€” one login, one place, no seven tabs.',
  ),
  _OnboardingPage(
    icon: CupertinoIcons.sparkles,
    color: (c) => c.accent,
    title: 'Nexus reads\nyour record.',
    body:
        "Not the web. Your transcript, your attendance, your deadlines â€” so the advice is about you, and it arrives before you ask.",
  ),
  _OnboardingPage(
    icon: CupertinoIcons.shield,
    color: (c) => c.success,
    title: 'Your data\nstays yours.',
    body:
        'No lecturer or administrator ever sees a Nexus conversation. The university only gets anonymised, aggregated numbers.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;

  void _next() {
    if (_index < _pages.length - 1) {
      setState(() => _index++);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final page = _pages[_index];
    final accent = page.color(colors);

    return ColoredBox(
      color: colors.ink,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  label: 'Skip',
                  variant: AppButtonVariant.tertiary,
                  onPressed: () => context.go(AppRoutes.login),
                ),
              ),
              Expanded(
                child: Column(
                  key: ValueKey(_index),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.xlRadius,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.tint(accent, 0.9), AppColors.tint(accent, 0.4)],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(page.icon, size: 28, color: colors.onAccent),
                    ),
                    const SizedBox(height: 26),
                    Text(page.title, style: text.largeTitle),
                    const SizedBox(height: 14),
                    Text(page.body, style: text.body.copyWith(color: colors.textMuted, fontSize: 16.5)),
                  ],
                ).animate(key: ValueKey(_index)).fadeIn(duration: AppMotion.entrance).slideY(begin: 0.04, end: 0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    AnimatedContainer(
                      duration: AppMotion.standard,
                      margin: const EdgeInsets.symmetric(horizontal: 3.5),
                      width: i == _index ? 20 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: i == _index ? colors.accent : colors.textPrimary.withValues(alpha: 0.18),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: _next,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.lgRadius,
                    gradient: LinearGradient(colors: [colors.accentDeep, colors.infoDeep]),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _index < _pages.length - 1 ? 'Continue' : 'Get started',
                        style: text.headline.copyWith(color: colors.onAccent, fontSize: 17),
                      ),
                      const SizedBox(width: 7),
                      Icon(CupertinoIcons.arrow_right, size: 17, color: colors.onAccent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
