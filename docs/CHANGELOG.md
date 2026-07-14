# Changelog

All notable changes to O6U Nexus are recorded here. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added
- Project scaffold: Flutter app `o6u_nexus`, iOS/Android/Web targets.
- Dependencies: `flutter_riverpod`, `go_router`, `freezed`, `google_fonts`,
  `responsive_framework`, `flutter_animate`, `intl`, `flutter_svg`, `shared_preferences`.
- `docs/`: `PROJECT_RULES.md`, `MASTER_PLAN.md`, `Architecture.md`, this changelog, and the
  authoritative design reference at `docs/reference/o6u-nexus-ios.tsx`.
- Campus batch D sub-screens: `BookExchangeScreen`, `InternshipsScreen`, `FreelanceScreen`,
  pushed from the Campus hub's "More on campus" row and wired into `app_router.dart` under
  `/campus/book-exchange`, `/campus/internships`, `/campus/freelance`. All three reuse the
  existing `ListingCard`/`AppPushScaffold`/`AppSearchBar` design-system widgets and read from
  `campusListingsProvider`.
- Dummy `CampusListing` fixtures for the `bookExchange`, `internship`, and `freelance`
  categories in `shared/data/campus_repository.dart` (textbook lending/trading, verified
  company internship postings, student-posted paid gigs).
- Smoke tests for the three new Campus screens in
  `test/features/campus/presentation/campus_sub_screens_test.dart`.
- AI batch E sub-screens, pushed from the AI hub's tools row: `GpaSimulatorScreen`
  (`/ai/gpa-simulator`) ports the reference's `GpaSim` — a live-recomputed projected cumulative
  GPA hero with no Calculate button, segmented per-course grade pickers backed by a new
  `GpaSimulatorController` (`Notifier<Map<String,String>>`), and a dashed insight card naming
  MA201 as the highest-leverage grade move. `StudyPlannerScreen` (`/ai/study-planner`) ports the
  reference's `StudyPlanner` — a static 7×3 week grid of lecture/AI-placed/exam blocks with a
  legend and "14 study hours placed · 0 conflicts" header, plus three insight cards.
  `GraduationPlannerScreen` (`/ai/graduation-planner`) ports the reference's `GradPlanner` in
  Nexus's own voice ("Nexus built this plan") — a 96%-on-time hero, a six-step timeline, and a
  CS412 bottleneck warning; deliberately independent of Academics' similar-sounding "Graduation
  Progress" screen, with its own provider and fixture data. `ResumeBuilderScreen`
  (`/ai/resume-builder`) and `LectureSummaryScreen` (`/ai/lecture-summary`) are new (not in the
  design reference) but reuse the existing `AiMessageBubble` verdict/body/chips/CTA card so they
  read as siblings of Nexus's other structured answers; Resume Builder pulls Education/Skills from
  `currentStudentProvider`/`coursesProvider` with a simulated "Export as PDF" action, and Lecture
  Summary ties back to the "balanced trees" CS402 quiz-prep thread referenced on Home and in the
  AI chat's "What should I revise tonight?" reply.
- All 5 AI sub-routes wired as nested `GoRoute`s under the AI tab's `StatefulShellBranch` in
  `core/router/app_router.dart`.
- Smoke tests for all 5 new AI screens in
  `test/features/ai/presentation/ai_sub_screens_test.dart`.

### Fixed
- `AppSearchBar`'s `TextField` asserts a `Material` ancestor at build time; nothing in the
  Cupertino-styled scaffold chain (`AppShell` → `LargeTitleScaffold`/`AppPushScaffold`) provided
  one, so any screen rendering the widget — including the already-shipped `CampusScreen` hub —
  crashed immediately. Wrapped it in a transparent `Material` locally (no fill/elevation/ink, so
  the iOS HIG look is unaffected).

<!-- Subsequent entries are appended above this line as each batch lands. -->
