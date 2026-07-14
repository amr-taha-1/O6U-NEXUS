import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/academics/presentation/screens/academics_screen.dart';
import '../../features/ai/presentation/screens/ai_screen.dart';
import '../../features/auth/presentation/screens/face_id_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/campus/presentation/screens/campus_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/about_screen.dart';
import '../../features/profile/presentation/screens/achievements_screen.dart';
import '../../features/profile/presentation/screens/privacy_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/security_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/student_id_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';

/// The app's single [GoRouter]. Auth screens sit outside the tab shell;
/// everything from [AppRoutes.home] onward is a branch of the five-tab
/// [StatefulShellRoute]. See docs/Architecture.md "Navigation" for why.
///
/// Each feature batch appends its own sub-routes as children of its tab
/// root's [GoRoute] (relative path segments — go_router resolves them
/// against the full [AppRoutes] constants automatically).
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingScreen()),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(path: 'forgot-password', builder: (context, state) => const ForgotPasswordScreen()),
        ],
      ),
      GoRoute(path: AppRoutes.faceId, builder: (context, state) => const FaceIdScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.academics,
                builder: (context, state) => const AcademicsScreen(),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ai,
                builder: (context, state) => const AiScreen(),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.campus,
                builder: (context, state) => const CampusScreen(),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(path: 'student-id', builder: (context, state) => const StudentIdScreen()),
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                    routes: [
                      GoRoute(path: 'privacy', builder: (context, state) => const PrivacyScreen()),
                      GoRoute(path: 'security', builder: (context, state) => const SecurityScreen()),
                    ],
                  ),
                  GoRoute(path: 'achievements', builder: (context, state) => const AchievementsScreen()),
                  GoRoute(path: 'about', builder: (context, state) => const AboutScreen()),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
