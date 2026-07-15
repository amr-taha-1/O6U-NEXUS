# Changelog

All notable changes to O6U Nexus are recorded here. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added — GPA Calculator service
- `assets/data/grade_scale.json` — the official O6U grading scale (marks-percent bands → letter →
  4.0-scale points), read through a new `GradeBand` model and `GradeScaleRepository`
  (`gradeScaleProvider`). Every GPA calculation in the app must go through this now, never a
  hardcoded letter→points map — see docs/Architecture.md "Real data".
- Removed `Course.gradeScale`/`gradePoints` (a hardcoded, incomplete, and in one case *wrong* map —
  `C+` was 2.5, the official scale is 2.3). The GPA Simulator now gates on `gradeScaleProvider`
  alongside `currentStudentProvider` and computes projected GPA from the real scale.
- The GPA Simulator's grade picker now offers the real scale's full 11 bands (was 6, hardcoded) —
  switched from a single `Row` of `Expanded` buttons to a `Wrap`, since 11 no longer fit one row.
- Removed the fictional "3-hour gap after CS402 / book the room" Nexus thread banner from Home —
  no real-data equivalent, and it was the last leftover fictional insight on a dashboard that's now
  otherwise real.

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

### Added — Real data
- The signed-in student's academic record is now real O6U data (student 23017930), read from
  `assets/data/{student,transcript,degree_progress,dashboard}.json` via `JsonAssetLoader` and
  exposed as `FutureProvider`s (`currentStudentProvider`, `transcriptProvider`,
  `degreeProgressProvider`, `dashboardDataProvider`) — see `docs/Architecture.md` "Real data" for
  the full swap-to-API plan. A temporary local data source until October 6 University provides an
  official API; every screen already behaves as if wired to one.
- New models: `TranscriptCourse`, `DegreeProgress`/`DegreeRequirementCategory`, `DashboardData`/
  `QuickAction`; `Student` extended with `faculty`, `academicAdvisor`, `nationality`, a nullable
  `expectedGraduation`; `Semester` extended with `courses`/`points`.
- `TranscriptScreen` rebuilt on real data: per-semester cards, color-coded grade chips
  (`features/transcript/presentation/grade_colors.dart`) matching the official A/B/C/D/F/W/PASS/
  NOD legend. Per-course hours/points render as `—` where the source transcript doesn't have that
  granularity (only Fall 2023/2024 does) — never guessed.
- `GraduationScreen` rebuilt as "Degree Progress": real requirement-category breakdown
  (University/College/Department Mandatory/Department Electives) instead of the old fictional
  audit. `GraduationPlannerScreen` (AI) stays independently fictional by design.
- New `AcademicAnalyticsScreen` (`/academics/analytics`): CGPA, semester GPA trend
  (`GpaSparkline`), hours completed/remaining, animated grade-distribution bars, and repeated
  courses — all derived from the real transcript (`features/analytics/application/
  analytics_providers.dart`).
- `HomeScreen`'s new `DashboardSection`: real greeting, faculty/major/level/advisor, a degree-
  completion `ProgressRing`, and data-backed quick actions.
- Every other screen touching student data (`GradesScreen`'s cumulative GPA, `ProfileScreen`,
  `StudentIdScreen`, `FaceIdScreen`'s greeting, `ResumeBuilderScreen`, `GpaSimulatorScreen`,
  `GraduationPlannerScreen`, `glance_grid.dart`'s credits-left tile) now gates on
  `currentStudentProvider`'s `AsyncValue` instead of reading synchronously.
- Current-semester screens with no real-data equivalent (Schedule, Attendance, Assignments, Exam
  Schedule, the GPA Simulator's course picker) intentionally keep their existing fictional data.

### Fixed
- `AppProgressBar` (`core/widgets/app_progress_bar.dart`) rendered every fill as invisible: its
  inner `FractionallySizedBox` only set `widthFactor`, leaving `heightFactor` null, so the
  `DecoratedBox` fill collapsed to zero height regardless of the `value` passed in. Pre-existing —
  surfaced by visually verifying the new Degree Progress and Academic Analytics screens, whose
  category/graduation bars all looked empty even at 100%. Fixed by setting `heightFactor: 1`; this
  also fixes the (until-now invisible) bars on Attendance's per-course rows and the Academics hub
  hero.
- `DashboardSection`'s `_StatRow` (CGPA/Registered hours/Remaining/Academic status tiles on Home)
  overflowed its `GridView.count` cells by ~2px in debug builds (`childAspectRatio: 1.9` was too
  tight for three lines of text). Loosened to `1.65`.
- Six files (`academics_providers.dart`, `assignment.dart`, `assignments_screen.dart`,
  `attendance_screen.dart`, `exam_schedule_screen.dart`, `grades_screen.dart`) had U+FFFD
  replacement-character corruption in comments/strings, a different corruption class from the
  double-encoding fixed previously — replaced with the correct em dash.
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
per the notes above), plus the new Academic Analytics screen. Verified end-to-end on-device
(Android emulator): Home, Transcript, Degree Progress, and Academic Analytics all render the real
data correctly. `flutter analyze`: 0 issues. `flutter test`: 17/17 passing.
