import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/application/notifications_controller.dart';
import '../theme/theme.dart';
import 'app_tab_bar.dart';

/// Wraps the five persistent tabs in [AppTabBar]. Each tab keeps its own
/// navigation stack — switching tabs doesn't lose a pushed sub-screen — via
/// go_router's [StatefulShellRoute.indexedStack]. See
/// docs/Architecture.md "Navigation".
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider);
    return DecoratedBox(
      decoration: BoxDecoration(color: context.colors.ink),
      child: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppTabBar(
              currentIndex: navigationShell.currentIndex,
              aiHasAlert: unread > 0,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
