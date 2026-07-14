# Changelog

All notable changes to O6U Nexus are recorded here. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added — Foundation
- Project scaffold: Flutter app `o6u_nexus`, iOS/Android/Web targets.
- Dependencies: `flutter_riverpod`, `go_router`, `freezed`, `google_fonts`,
  `responsive_framework`, `flutter_animate`, `intl`, `flutter_svg`, `shared_preferences`.
- `docs/`: `PROJECT_RULES.md`, `MASTER_PLAN.md`, `Architecture.md`, this changelog, and the
  authoritative design reference at `docs/reference/o6u-nexus-ios.tsx`.
- `core/theme`: `AppColors`/`AppTypography` theme extensions (dark + light), `AppSpacing`,
  `AppRadius`, `AppMotion` tokens, and `AppTheme.dark()`/`AppTheme.light()`.
- `core/widgets`: the reusable component library — `AppCard`, `AppButton`, `AppTextField`,
  `AppSearchBar`, `AppSegmentedControl`, `TagChip`, `NavRowCard`, `ProgressRing`,
  `AppProgressBar`, `GpaSparkline`, `SectionHeader`, `StatusPlaceholder`, `SkeletonBox`/
  `SkeletonListTile`, `GlowBadge`, `AppMark`, `showAppBottomSheet`, `AppSnackbar`,
  `LargeTitleScaffold`, `AppPushScaffold`.
- `core/router`: `go_router` `StatefulShellRoute` five-tab shell (`AppShell`, `AppTabBar`) with
  auth screens (splash/onboarding/login/face-id) outside the shell.
- `shared/domain` + `shared/data`: Freezed models and in-memory dummy repositories for `Student`,
  `Course`, `Semester`, `ScheduleItem`, `AppNotification`, `CampusListing`, `AiMessage`,
  `GraduationStep`.

### Added — Batch A (Auth) & Batch B (Home)
- `SplashScreen`, `OnboardingScreen` (3 pages), `LoginScreen`, `ForgotPasswordScreen`,
  `FaceIdScreen` — the full auth flow, `/splash → /onboarding → /login → /face-id → /home`.
- `HomeScreen` (Today) — Nexus thread banner, next-up hero with a live countdown, day timeline,
  "at a glance" stat grid.
- `NotificationsSheet` (shared, reachable from Home's bell and Profile's Alerts row) with
  category filters and a `NotificationsController` for read/unread state.
- Academics/Campus/AI/Profile tab-root ("hub") screens, matching the design reference's
  Portal/Campus/Nexus/Me components, including their first-layer interactive sheets
  (`CourseDetailsSheet`, `CheckInSheet`).

### Added — Batch C (Academics)
- `ScheduleScreen`, `ExamScheduleScreen`, `GradesScreen`, `AttendanceScreen`,
  `TranscriptScreen`, `AssignmentsScreen`, `GraduationScreen` — all 7 pushed from the Academics
  hub's "Records" list and wired into `app_router.dart` under `/academics/*`.
- New feature-local models `Assignment`, `Exam` (`features/academics/domain/`) and
  `academics_providers.dart` for schedule/exam/assignment dummy data.
- Smoke tests in `test/features/academics/presentation/academics_screens_test.dart`.

### Added — Batch D (Campus)
- `BookExchangeScreen`, `InternshipsScreen`, `FreelanceScreen`, pushed from the Campus hub's
  "More on campus" row and wired into `app_router.dart` under `/campus/book-exchange`,
  `/campus/internships`, `/campus/freelance`. All three reuse `ListingCard`/`AppPushScaffold`/
  `AppSearchBar` and read from `campusListingsProvider`.
- Dummy `CampusListing` fixtures for the `bookExchange`, `internship`, and `freelance`
  categories in `shared/data/campus_repository.dart` (textbook lending/trading, verified
  company internship postings, student-posted paid gigs).
- Smoke tests in `test/features/campus/presentation/campus_sub_screens_test.dart`.

### Added — Batch E (AI / Nexus)
- `GpaSimulatorScreen` (`/ai/gpa-simulator`) — ports the reference's `GpaSim`: a live-recomputed
  projected cumulative GPA hero with no Calculate button, segmented per-course grade pickers
  backed by a new `GpaSimulatorController`, and a dashed insight card naming MA201 as the
  highest-leverage grade move.
- `StudyPlannerScreen` (`/ai/study-planner`) — ports the reference's `StudyPlanner`: a static
  7×3 week grid of lecture/AI-placed/exam blocks with a legend and "14 study hours placed · 0
  conflicts" header, plus three insight cards.
- `GraduationPlannerScreen` (`/ai/graduation-planner`) — ports the reference's `GradPlanner` in
  Nexus's own voice ("Nexus built this plan"): a 96%-on-time hero, a six-step timeline, and a
  CS412 bottleneck warning. Deliberately independent of Academics' `GraduationScreen` (own
  provider, own fixture data, no shared code) so the two batches stayed parallel-buildable.
- `ResumeBuilderScreen` (`/ai/resume-builder`) and `LectureSummaryScreen`
  (`/ai/lecture-summary`) — new screens (not in the design reference) that reuse the existing
  `AiMessageBubble` verdict/body/chips/CTA card so they read as siblings of Nexus's other
  structured answers. Resume Builder pulls Education/Skills from `currentStudentProvider`/
  `coursesProvider` with a simulated "Export as PDF" action; Lecture Summary ties back to the
  "balanced trees" CS402 quiz-prep thread referenced on Home and in the AI chat.
- Smoke tests in `test/features/ai/presentation/ai_sub_screens_test.dart`.

### Added — Batch F (Profile)
- `StudentIdScreen`, `SettingsScreen`, `PrivacyScreen`, `SecurityScreen`,
  `AchievementsScreen`, `AboutScreen`, pushed from the Profile hub and wired into
  `app_router.dart` under `/profile/*` (`settings/privacy` and `settings/security` nested under
  `settings`, matching the university's settings → sub-section pattern).
- A real dark/light theme toggle: `core/services/theme_mode_controller.dart` (a plain
  `Notifier<ThemeMode>`) wired into `MaterialApp.router`'s `themeMode`, surfaced as a switch on
  the Settings screen.

### Fixed
- `AppSearchBar`'s `TextField` asserts a `Material` ancestor at build time; nothing in the
  Cupertino-styled scaffold chain (`AppShell` → `LargeTitleScaffold`/`AppPushScaffold`) provided
  one, so any screen rendering the widget — including the already-shipped `CampusScreen` hub —
  crashed immediately. Wrapped it in a transparent `Material` locally (no fill/elevation/ink, so
  the iOS HIG look is unaffected).

### Scope notes
- "Announcements" (originally listed as a screen separate from Notifications) was folded into
  the Notifications sheet — its academic/deadline/campus/Nexus categories already cover
  announcement-style content, so a near-duplicate screen wasn't built.
- "GPA" (originally listed as a screen separate from Grades) was folded into the Grades screen —
  GPA is that screen's headline number, not a distinct view.
- Marketplace, Lost & Found, Study Groups, and Events are served by the Campus hub's segmented
  control (matching the design reference exactly) rather than as separate pushed screens; Book
  Exchange, Internships, and Freelance — not in the reference — are dedicated pushed screens.

All 38 screens from the original brief are accounted for (35 as dedicated screens, 3 consolidated
per the notes above). `flutter analyze`: 0 issues. `flutter test`: 16/16 passing.
