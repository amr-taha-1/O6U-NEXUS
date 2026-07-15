import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/router/app_router.dart';
import 'core/services/class_notification_scheduler.dart';
import 'core/services/theme_mode_controller.dart';
import 'core/theme/theme.dart';
import 'core/utils/responsive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ClassNotificationScheduler.initialize();
  runApp(const ProviderScope(child: O6uNexusApp()));
}

class O6uNexusApp extends ConsumerWidget {
  const O6uNexusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);

    return MaterialApp.router(
      title: 'O6U Nexus',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        // The UI language throughout is Cupertino/HIG (LargeTitleScaffold and
        // AppPushScaffold are built on CustomScrollView/CupertinoPageScaffold,
        // not Scaffold), so no screen provides a `Material` ancestor on its
        // own. A handful of design-system widgets still use real Material
        // widgets internally where there's no good Cupertino equivalent
        // (TextField inside AppTextField/AppSearchBar, the AI chat input) —
        // those assert a `Material` ancestor at build time. Providing one
        // transparent `Material` here, once, at the root, is the actual fix:
        // every screen and every modal/sheet pushed through this app's
        // Navigator inherits it for free, instead of each widget needing its
        // own local patch. `type: transparency` adds no fill, elevation, or
        // ink — it does not change how anything looks.
        child: Material(
          type: MaterialType.transparency,
          child: child ?? const SizedBox.shrink(),
        ),
        breakpoints: const [
          Breakpoint(start: 0, end: AppBreakpoints.mediumWidth - 1, name: AppBreakpoints.compact),
          Breakpoint(start: AppBreakpoints.mediumWidth, end: AppBreakpoints.expandedWidth - 1, name: AppBreakpoints.medium),
          Breakpoint(start: AppBreakpoints.expandedWidth, end: double.infinity, name: AppBreakpoints.expanded),
        ],
      ),
    );
  }
}
