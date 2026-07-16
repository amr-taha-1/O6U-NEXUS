# Changelog

All notable changes to O6U Nexus are recorded here. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Fixed — Full data-integrity audit against the official source documents
- **Elective 2 ↔ Geographic Information System.** The bylaw listed Elective 2 as a generic
  placeholder (`ISE326`, "Elective 2"); the real timetable uses `ISE326A`, "Geographic Information
  System." Different codes meant the curriculum engine treated them as two different courses —
  fixed by correcting the bylaw entry to `ISE326A`, "Geographic Information System (Elective 2)",
  so every prerequisite tree, catalog entry, search result, and course-details page now treats them
  as the one real course they are.
- **Student level was wrong.** `student.json` said Level 2 while the real transcript shows
  completed/in-progress courses through bylaw Year 4 (ISM413, ISM424, ISE326A — all `yearLevel: 4`)
  — internally inconsistent with 91 of 144 real completed hours. Corrected to Level 4.
- **Currently-registered courses appeared under "Eligible to register next."** The eligibility
  engine only knew `completed` vs `eligible` vs `locked`; a course the student is already sitting in
  this term (not yet graded, so not "completed") fell through to `eligible`, wrongly telling the
  student to register for something they're already taking. Added a real `registered` status
  (`currentlyRegisteredCourseCodesProvider`, sourced from the real timetable) and a "Currently
  Registered This Term" section in Course Catalog, ahead of "Eligible to register next" — see
  `curriculum_engine.dart`.
- **Hardcoded fake data throughout Academics, Home, Profile, and every AI screen**, all
  contradicting or unrelated to the real record — course codes (CS402/MA201/CS310/PH101/EN102/CS412)
  that don't exist anywhere in the real bylaw or transcript, a hardcoded "Semester GPA 3.24" that
  never matched the real semester GPAs, a hardcoded "92%" attendance figure, a notification claiming
  "cumulative GPA moved to 3.12" against a real CGPA of 2.67, an AI Resume Builder verdict claiming
  the student's major is "Computer Science" against the real "Information Systems," a Graduation
  Planner independently inventing "Level 1–4 done / Aug 2027 / 96%" instead of reading the real
  `DegreeProgress`, and a fabricated "CS412 bottleneck" course. Every one of these is now either
  computed from real data (Grades subtitle, Home's NextUpCard/DayTimeline, GPA Simulator's course
  picker, the AI chat's 4 canned replies, Graduation Planner, Resume Builder, notifications, Profile
  check-in/achievements) or, where no real data source exists at all (attendance %, exam schedule,
  assignment due dates, lecture-recording summaries), replaced with an honest "no official data yet"
  state instead of a fabricated number — never both a fake claim and a real one in the same app. See
  the closing audit report for the full file-by-file list.

### Added — Campus Network (Community, Reputation, Portfolio, Study Groups, Clubs, Economy, Challenges, Leaderboards, Shorts, DNA, Intelligence Feed, Campus OS)
- A new `features/campus_network/` module, reachable from the Campus tab's "More on campus" list —
  the app's biggest single feature addition, covering all 14 requested subsystems at once:
  - **Campus Community**: posts (text/image/document/question/poll/note/project update/achievement),
    like/comment/bookmark/share, hashtags, replies. `CampusFeedController` layers live like/bookmark
    state on top of seed posts.
  - **Campus Reputation**: Academic/Community/Leadership/Innovation reputation, Campus Level, XP,
    badges, and Global/Department/Faculty/Community rank — all computed live
    (`campus_reputation.dart`), never a stored score, the same discipline as Carpool's Trust Score.
  - **Student Profile 2.0 / "LinkedIn for Students"**: skills, languages, certificates, portfolio
    projects, GitHub/LinkedIn/portfolio links, volunteer hours, followers — `MemberProfileScreen`
    doubles as the signed-in student's own (real-data) profile and any seed member's.
  - **Study Groups**, **Clubs** (IEEE/GDG/ICPC/Rotaract/Student Union, each with posts/events/
    announcements), **Campus Coins** economy + ledger, **Challenges** (daily/weekly/semester
    missions with real XP/Coin rewards), **Leaderboards** (9 categories, each a live sort — see
    `leaderboard_providers.dart` for exactly what each ranks by), **Campus Shorts** (short-video
    feed metadata; no real playback — see below), **Campus DNA** (real strongest/weakest bylaw
    category + real GPA trend from the transcript; "best study time"/"learning style"/"productivity
    trends" are deliberately not modeled — no activity-tracking data source exists to compute them
    from honestly), **Campus Intelligence** smart feed (aggregates next class, an eligible course to
    register, the nearest carpool, degree-progress hours remaining, a trending post, and the next
    club event — all from real providers already in the app), and a **Campus OS** home screen
    (`CampusNetworkHomeScreen`) tying it together with a real greeting, real today's classes, and
    real next-lecture countdown.
- Every member besides the signed-in student, and every post/study-group/club-event/video, is seed
  content (`campus_member_repository.dart` and friends) — there is no real O6U social-network backend
  or real classmate data source for a brand-new social feature, the same convention Carpool already
  established. The signed-in student's own card is always built from the real `Student` record.
- Skipped, by design, for reasons documented in each file: real image/video upload or playback (no
  `image_picker`/`video_player` — this sandbox cannot resolve new native Gradle dependencies), real
  Campus Coins redemption by university partners (no partner-integration backend), weather on the
  Campus OS screen (no weather API key), and persisted streak/XP history across app restarts (no
  `shared_preferences` wiring for this yet — everything is session-scoped, same as Carpool's
  favorites).

### Added — Global Smart Search, Course Details, and University Verified Carpool
- **Global Smart Search** (`features/search/`): one instant, categorized, ranked search over Student
  Profile, Transcript, Current Courses, Schedule, Degree Progress, GPA & Analytics, Course Catalog/
  Bylaw/Prerequisites, and Notifications — searchable by course code or name, partial text, with
  recent searches, suggestions, and highlighted matches. Reachable from a new search icon on Home's
  app bar and from Campus's search bar. Every result routes to a real, already-wired screen.
- **Course Details** (`features/course_details/`): every course reference anywhere in the app
  (Transcript, Academics hub, Course Catalog, Schedule) is now tappable, landing on one aggregator
  page (`courseDetailsProvider`) merging the real bylaw entry (prerequisites, next courses, credit
  hours), every real transcript attempt chronologically (including transferred credits), and live
  eligibility. "Estimated workload" is a transparent, documented proxy from credit hours and
  prerequisite depth — labelled as an estimate, never presented as a real difficulty statistic (no
  cohort data exists to compute one).
- **University Verified Carpool** (`features/campus/…carpool*`): O6U-exclusive rides, masked student
  ID (`Student ID ending with: ****1234`), a computed Trust Score (0–100 + badges: 🟢 Trusted Driver,
  ⭐ Top Rated, 🚘 Frequent Driver, 🎓 Verified Student, 🏆 Campus Ambassador), safety preferences
  (rider gender preference; driver-configurable seats/pickup instructions/arrival tolerance/music/
  smoking/AC), a documented smart-matching percentage combining trust, rating, departure-time
  proximity, seed distance, and favorite-driver status, and Campus Only routing (one end of every
  trip is always October 6 University — `Ride.originLabel`/`destinationLabel`). Ride/driver content
  is seed data, the same convention as the existing Book Exchange/Internships/Freelance listings;
  the signed-in student's own card uses the real `Student` record.

### Fixed — a `flutter_test`/`FakeAsync` deadlock, not a Carpool bug
- `CarpoolScreen`'s widget test hung indefinitely (10-minute timeout) even though the exact same
  widget rendered instantly in an isolated diagnostic pump. Root cause: the test body did
  `await container.read(xProvider.future)` a *second* time inside a `testWidgets` callback, after
  that same Future had already been completed once for real inside `setUpAll` (which runs outside
  `flutter_test`'s `FakeAsync` zone). Re-awaiting a Future that completed in real time from inside
  fake time deadlocks the pump machinery instead of resolving immediately. Fix: read every needed
  value once in `setUpAll` and store it in a plain variable; never re-await an already-resolved
  container future inside a `testWidgets` body. Documented in `docs/Architecture.md` "Testing"
  alongside the existing single-real-asset-load gotcha.

### Fixed — `intl.DateFormat` never exercised under `flutter_test`
- While debugging the above, `Ride.departureTimeLabel`/`departureDayLabel` and their Study
  Group/Club Event equivalents were switched from `intl.DateFormat` to hand-rolled formatters
  (mirroring `ScheduleSession.timeRangeLabel`, which already avoided `intl` for the same reason).
  Not the actual root cause of the hang above, but a real latent risk this build's own `HomeScreen`
  already carried unnoticed (no test had ever rendered a screen using `DateFormat` before); removing
  it from the new Carpool/Campus Network screens closes that risk for all newly-added code.

### Fixed — Transcript accuracy and completeness
- Academics hub's "This semester" section was hardcoded to fictional current-semester courses; it
  now reads the transcript's actual latest entry (`enrichedTranscriptProvider`'s last semester) and
  labels the section with that semester's real name — never a fixed semester, always whichever one
  is chronologically last.
- Added a **Transferred Credits** section above the semester list (`assets/data/transcript.json`'s
  new `transferredCredits` key): Mathematics I and Mathematics II, both grade `P`, pass/fail and
  excluded from GPA. They now also count as completed prerequisites in the curriculum engine
  (`completedCourseCodesProvider`).
- New `enrichedTranscriptProvider` (`features/transcript/application/transcript_enrichment.dart`)
  backfills per-course credit hours and earned points wherever the raw transcript doesn't carry
  them, using only real, cross-checkable sources: credit hours looked up by course code in the
  official bylaw catalog, earned points computed as `hours × gradeScale.pointsForLetter(grade)`
  from the real official grading scale. A handful of general-education elective courses aren't in
  the major-specific bylaw catalog at all (Modern Egyptian History, Sociology of Work, Introduction
  to Environmental Biology) — those stay `—`, since there's no official source for their credit
  hours here, rather than being invented.
- Grade legend: added `P` (Pass) as a synonym for `PASS` — green, excluded from GPA — since the
  official transcript's transfer-credit rows use `P` specifically.

### Added — Schedule: instructor names and the third registered course
- Instructor names, transliterated from the official Arabic timetable, now appear on every
  schedule card (Geographic Information System, Knowledge Management, and the newly-added Database
  Management Systems 2).
- Database Management Systems 2 (`ISM413`) — previously missing entirely — is now in
  `assets/data/schedule.json`: Wednesday, lecture Room 6210 (Dr. Ayman Hassanein) and lab Room 6020
  (Eng. Ahmed Khaled). Brings total registered summer hours to 9 (3 courses × 3 hours), confirming
  the schedule was never hardcoded to two courses — it reads however many real sessions exist.

### Fixed — Graduation Project prerequisite: 100 credit hours, not 103
- The bylaw's Article 40 threshold was mistranscribed. Corrected in the single JSON source
  (`minCreditHoursForGraduationProject`); every consumer (eligibility engine, Course Catalog
  screen) already reads this value dynamically, so nothing else needed updating.

### Removed — Home quick actions and recent-semester card
- Removed the Transcript/Analytics/Degree Progress quick-action row and the "Most recent semester"
  card from Home's dashboard summary.
- `DashboardData` simplified to just `greetingName` — `QuickAction` and `assets/data/dashboard.json`'s
  `quickActions` array are gone with it, since nothing reads them anymore. Home no longer needs
  `transcriptProvider` at all (it only existed to find the most recent semester).

### Added — Class-reminder notifications
- `core/services/class_notification_scheduler.dart` (`flutter_local_notifications` + `timezone`):
  schedules a local notification for every real class session (`features/schedule/`) at each
  enabled offset (1h/30m/10m before), recurring weekly via `DateTimeComponents.dayOfWeekAndTime` —
  no per-day manual re-scheduling needed.
- `features/notifications/application/class_reminder_sync.dart`: watched once from `AppShell`,
  re-schedules automatically whenever the real timetable or the Settings toggles change.
- New "Class reminders" section in Settings: a master toggle plus independent 1h/30m/10m-before
  toggles, matching the existing Quiet Hours toggle's in-memory-only pattern (nothing persists
  across a cold restart in this sprint — see `profile_preferences.dart`).
- Android manifest: `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`/`USE_EXACT_ALARM`,
  `RECEIVE_BOOT_COMPLETED` permissions, plus the boot-rearm receiver
  `flutter_local_notifications` needs to survive a device reboot.
- Not verified end-to-end on-device this session: this sandbox's Gradle cannot fetch *any* new
  Maven artifact (a persistent SSL trust-chain failure resolving `dl.google.com`/
  `repo.maven.apache.org`, unrelated to this change), so the Android build couldn't be run here
  after adding `flutter_local_notifications`. `flutter analyze` is clean and the full test suite
  passes; the dependency and scheduling logic should be verified on a normal internet-connected
  machine before relying on it.

### Added — Real Schedule
- `assets/data/schedule.json` — the student's real Summer-term class meetings, filtered from the
  department-wide timetable (`V5-Summer Term ALL Levels- 2025-2026.pdf`) down to their own three
  registered courses and confirmed lecture/lab sections (the source PDF lists every section for
  every level; picking the right one required asking, since guessing would have fabricated the
  student's personal schedule).
- New `features/schedule/`: `ScheduleRepository`/`scheduleProvider` reads it;
  `weeklyScheduleProvider` groups by weekday, `nextSessionProvider` finds the next class
  chronologically (today if not yet started, otherwise the next day with one, wrapping the week),
  `minutesUntilNextSessionProvider` for a live countdown.
- `ScheduleScreen` rebuilt on real data: a "next class" hero card and the week grouped by day.
  Lecture vs. Lab gets a distinct icon and color everywhere (book/blue vs. flask/amber), per the
  department's own rule for reading an instructor's title on the timetable (Dr. = Lecture,
  Eng./Demonstrator = Lab).
- Database Management Systems 2 (`ISM413`) isn't in `schedule.json` yet — its two Wednesday
  sessions share a timetable block with six other Level-4 courses and the exact time split wasn't
  confirmable from the source PDF alone; needs the student to confirm before it's added.

### Added — Curriculum engine (Course Catalog)
- `assets/data/bylaw_information_systems.json` — the Information Systems track's full 50-course
  curriculum (code, name, credit hours, year level, category, prerequisites), transcribed from the
  department's official Bylaw-2 prerequisites document.
- New `features/curriculum/`: `CurriculumRepository`/`curriculumProvider` reads the bylaw;
  `completedCourseCodesProvider` derives "has this course been passed" live from the real
  transcript (any grade except F/WF/W — a retake counts once passed on any attempt);
  `courseEligibilityProvider` cross-references the two to compute, per course, completed /
  eligible-to-register-next / locked (with exactly which prerequisites are still missing) — no
  hardcoded eligibility rules. `FRM416` (Graduation Project 1) is a special case: its prerequisite
  is Article 40 of the bylaw (103 completed credit hours), not another course.
  `estimatedRemainingSemestersProvider` gives a clearly-labelled estimate (remaining hours ÷ the
  student's own historical average hours/semester).
- New `CourseCatalogScreen` (`/academics/catalog`, "Course Catalog" row in the Academics hub):
  completed/eligible/locked counts, an estimated-graduation note, the eligible-now list, and locked
  courses with their missing prerequisites as chips. Independently cross-validated against the
  student's actual registered summer courses — Knowledge Management (`ISM424`) and Database
  Management Systems 2 (`ISM413`) both compute as eligible from the transcript alone, matching
  reality.
- Only the Information Systems track (the signed-in student's major) was transcribed; the bylaw
  document also covers Computer Science, Network Technologies, and Artificial Intelligence, not yet
  built.

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
