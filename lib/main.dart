import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'core/utils/responsive.dart';

void main() {
  runApp(const ProviderScope(child: O6uNexusApp()));
}

class O6uNexusApp extends ConsumerWidget {
  const O6uNexusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'O6U Nexus',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child ?? const SizedBox.shrink(),
        breakpoints: const [
          Breakpoint(start: 0, end: AppBreakpoints.mediumWidth - 1, name: AppBreakpoints.compact),
          Breakpoint(start: AppBreakpoints.mediumWidth, end: AppBreakpoints.expandedWidth - 1, name: AppBreakpoints.medium),
          Breakpoint(start: AppBreakpoints.expandedWidth, end: double.infinity, name: AppBreakpoints.expanded),
        ],
      ),
    );
  }
}
