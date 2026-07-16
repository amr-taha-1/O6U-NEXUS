import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/academics/presentation/screens/academics_screen.dart';
import '../../features/academics/presentation/screens/assignments_screen.dart';
import '../../features/academics/presentation/screens/attendance_screen.dart';
import '../../features/academics/presentation/screens/exam_schedule_screen.dart';
import '../../features/academics/presentation/screens/grades_screen.dart';
import '../../features/academics/presentation/screens/graduation_screen.dart';
import '../../features/academics/presentation/screens/schedule_screen.dart';
import '../../features/academics/presentation/screens/transcript_screen.dart';
import '../../features/ai/presentation/screens/ai_screen.dart';
import '../../features/analytics/presentation/screens/academic_analytics_screen.dart';
import '../../features/ai/presentation/screens/gpa_simulator_screen.dart';
import '../../features/ai/presentation/screens/graduation_planner_screen.dart';
import '../../features/ai/presentation/screens/lecture_summary_screen.dart';
import '../../features/ai/presentation/screens/resume_builder_screen.dart';
import '../../features/ai/presentation/screens/study_planner_screen.dart';
import '../../features/auth/presentation/screens/face_id_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/campus/presentation/screens/book_exchange_screen.dart';
import '../../features/campus/presentation/screens/campus_screen.dart';
import '../../features/campus/presentation/screens/freelance_screen.dart';
import '../../features/campus/presentation/screens/internships_screen.dart';
import '../../features/curriculum/presentation/screens/course_catalog_screen.dart';
import '../../features/course_details/presentation/screens/course_details_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/about_screen.dart';
import '../../features/profile/presentation/screens/achievements_screen.dart';
import '../../features/profile/presentation/screens/privacy_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/security_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/campus/presentation/screens/carpool_screen.dart';
import '../../features/campus/presentation/screens/ride_details_screen.dart';
import '../../features/campus_network/presentation/screens/campus_dna_screen.dart';
import '../../features/campus_network/presentation/screens/campus_network_home_screen.dart';
import '../../features/campus_network/presentation/screens/campus_videos_screen.dart';
import '../../features/campus_network/presentation/screens/challenges_screen.dart';
import '../../features/campus_network/presentation/screens/club_details_screen.dart';
import '../../features/campus_network/presentation/screens/clubs_screen.dart';
import '../../features/campus_network/presentation/screens/community_feed_screen.dart';
import '../../features/campus_network/presentation/screens/create_post_screen.dart';
import '../../features/campus_network/presentation/screens/leaderboards_screen.dart';
import '../../features/campus_network/presentation/screens/member_profile_screen.dart';
import '../../features/campus_network/presentation/screens/post_details_screen.dart';
import '../../features/campus_network/presentation/screens/study_groups_screen.dart';
import '../../features/profile/presentation/screens/student_id_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
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
      GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchScreen()),
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
                routes: [
                  GoRoute(path: 'schedule', builder: (context, state) => const ScheduleScreen()),
                  GoRoute(path: 'exams', builder: (context, state) => const ExamScheduleScreen()),
                  GoRoute(path: 'attendance', builder: (context, state) => const AttendanceScreen()),
                  GoRoute(path: 'grades', builder: (context, state) => const GradesScreen()),
                  GoRoute(path: 'transcript', builder: (context, state) => const TranscriptScreen()),
                  GoRoute(path: 'assignments', builder: (context, state) => const AssignmentsScreen()),
                  GoRoute(path: 'graduation', builder: (context, state) => const GraduationScreen()),
                  GoRoute(path: 'analytics', builder: (context, state) => const AcademicAnalyticsScreen()),
                  GoRoute(path: 'catalog', builder: (context, state) => const CourseCatalogScreen()),
                  GoRoute(
                    path: 'course/:code',
                    builder: (context, state) => CourseDetailsScreen(code: state.pathParameters['code']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ai,
                builder: (context, state) => const AiScreen(),
                routes: [
                  GoRoute(path: 'gpa-simulator', builder: (context, state) => const GpaSimulatorScreen()),
                  GoRoute(path: 'study-planner', builder: (context, state) => const StudyPlannerScreen()),
                  GoRoute(path: 'graduation-planner', builder: (context, state) => const GraduationPlannerScreen()),
                  GoRoute(path: 'resume-builder', builder: (context, state) => const ResumeBuilderScreen()),
                  GoRoute(path: 'lecture-summary', builder: (context, state) => const LectureSummaryScreen()),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.campus,
                builder: (context, state) => const CampusScreen(),
                routes: [
                  GoRoute(path: 'book-exchange', builder: (context, state) => const BookExchangeScreen()),
                  GoRoute(path: 'internships', builder: (context, state) => const InternshipsScreen()),
                  GoRoute(path: 'freelance', builder: (context, state) => const FreelanceScreen()),
                  GoRoute(
                    path: 'carpool',
                    builder: (context, state) => const CarpoolScreen(),
                    routes: [
                      GoRoute(
                        path: 'ride/:id',
                        builder: (context, state) => RideDetailsScreen(rideId: state.pathParameters['id']!),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'network',
                    builder: (context, state) => const CampusNetworkHomeScreen(),
                    routes: [
                      GoRoute(
                        path: 'feed',
                        builder: (context, state) => const CommunityFeedScreen(),
                        routes: [
                          GoRoute(path: 'create', builder: (context, state) => const CreatePostScreen()),
                          GoRoute(path: ':id', builder: (context, state) => PostDetailsScreen(postId: state.pathParameters['id']!)),
                        ],
                      ),
                      GoRoute(
                        path: 'member/:id',
                        builder: (context, state) => MemberProfileScreen(memberId: state.pathParameters['id']!),
                      ),
                      GoRoute(
                        path: 'study-groups',
                        builder: (context, state) => const StudyGroupsScreen(),
                      ),
                      GoRoute(
                        path: 'clubs',
                        builder: (context, state) => const ClubsScreen(),
                        routes: [
                          GoRoute(path: ':id', builder: (context, state) => ClubDetailsScreen(clubId: state.pathParameters['id']!)),
                        ],
                      ),
                      GoRoute(path: 'challenges', builder: (context, state) => const ChallengesScreen()),
                      GoRoute(path: 'leaderboards', builder: (context, state) => const LeaderboardsScreen()),
                      GoRoute(path: 'videos', builder: (context, state) => const CampusVideosScreen()),
                      GoRoute(path: 'dna', builder: (context, state) => const CampusDnaScreen()),
                    ],
                  ),
                ],
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
