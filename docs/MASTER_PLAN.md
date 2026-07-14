# O6U Nexus — Master Plan

This sprint builds the complete frontend only: no backend, no real auth, no network calls.
Everything is realistic dummy data served from in-memory repositories in `features/*/data/`.
Backend integration is a future sprint and is out of scope here.

## Source of design truth

`docs/reference/o6u-nexus-ios.tsx` (the original high-fidelity web prototype supplied for this
project) is the authoritative design reference: color tokens, type scale, spacing, screen copy,
dummy data shape, and the redline rationale for every screen. Where this plan or the Flutter
implementation is ambiguous, that file wins. Flutter screens port its structure faithfully rather
than reinterpreting the design.

## Phases

### Phase 0 — Environment & scaffold
- Flutter project created (`o6u_nexus`), iOS/Android/Web targets.
- Dependencies: `flutter_riverpod`, `go_router`, `freezed`, `google_fonts`, `responsive_framework`,
  `flutter_animate`, `intl`, `flutter_svg`, `shared_preferences`.
- `docs/` written (this file and its siblings).

### Phase 1 — Foundation
- `core/theme`: color tokens, dark + light `ThemeData`, type scale, spacing scale, radius scale,
  elevation scale, motion tokens.
- `core/widgets`: the full reusable component set (see Design System section below).
- `core/router`: GoRouter shell with the 5-tab bottom navigation + push routes for every
  sub-screen + modal routes for every bottom sheet.
- `shared/domain`: Freezed models — `Student`, `Course` (carries its own grade + attendance
  fields, rather than splitting into separate `GradeEntry`/`AttendanceRecord` models — one course
  record per screen that needs one), `Semester`, `ScheduleItem`, `AppNotification`,
  `CampusListing` (one unified shape for Market/Book Exchange/Lost & Found/Study Groups/
  Events/Internships/Freelance, distinguished by a `CampusListingCategory` enum, rather than a
  separate model per category), `AiMessage`/`AiChip` (a Freezed union for user vs. structured
  assistant turns), `GraduationStep`.
- `shared/data`: in-memory dummy repositories seeded with realistic O6U data.
- `shared/application`: cross-feature Riverpod state, e.g. `NotificationsController` (read/unread).

### Phase 2 — Feature screens (built in batches, each batch is independently reviewable)

**Batch A — Auth flow**
Splash → Onboarding (3 pages) → Login → Forgot Password → Face ID → Home.

**Batch B — Home**
Home Dashboard (Today), Notifications, Announcements.

**Batch C — Academics**
Academics hub (Portal), Schedule, Exam Schedule, Grades, GPA, Attendance, Transcript, Course
Details, Assignments, Graduation Progress (Graduation Planner).

**Batch D — Campus**
Marketplace, Book Exchange, Lost & Found, Study Groups, Events, Internships, Freelance.

**Batch E — AI (Nexus)**
AI Assistant (chat), AI Study Planner, AI GPA Simulator, AI Graduation Planner, AI Resume Builder,
AI Lecture Summary.

**Batch F — Profile**
Profile (Me), Student ID, Settings, Privacy, Security, Achievements, About.

### Phase 3 — Polish & verification
- Wire every navigation path; no dead-end screens, no unreachable routes.
- `flutter analyze` clean.
- `flutter test` covering providers, utils, and screen smoke tests.
- `docs/CHANGELOG.md` updated per batch.

## Screen inventory & status

Status legend: ⬜ not started · 🟨 in progress · ✅ done · 🔀 consolidated into another screen (see note)

| # | Screen | Batch | Status |
|---|---|---|---|
| 1 | Splash | A | ✅ |
| 2 | Onboarding | A | ✅ |
| 3 | Login | A | ✅ |
| 4 | Forgot Password | A | ✅ |
| 5 | Face ID | A | ✅ |
| 6 | Home Dashboard | B | ✅ |
| 7 | Announcements | B | 🔀 folded into Notifications (#8) — its academic/deadline/campus/Nexus categories already cover announcement-style content; a separate near-duplicate screen wasn't built |
| 8 | Notifications | B | ✅ |
| 9 | Academics hub (Portal) | C | ✅ |
| 10 | Schedule | C | ✅ |
| 11 | Exam Schedule | C | ✅ |
| 12 | Attendance | C | ✅ |
| 13 | Grades | C | ✅ |
| 14 | GPA | C | 🔀 folded into Grades (#13) — GPA is that screen's headline number, not a separate view |
| 15 | Transcript | C | ✅ |
| 16 | Course Details | C | ✅ (bottom sheet, opened from the Academics hub's course list) |
| 17 | Assignments | C | ✅ |
| 18 | Graduation Progress | C | ✅ (static record view; see #29 for the AI-framed sibling) |
| 19 | Marketplace | D | ✅ (Campus hub, "Market" segment) |
| 20 | Book Exchange | D | ✅ |
| 21 | Lost & Found | D | ✅ (Campus hub, "Lost & Found" segment) |
| 22 | Study Groups | D | ✅ (Campus hub, "Groups" segment) |
| 23 | Events | D | ✅ (Campus hub, "Events" segment) |
| 24 | Internships | D | ✅ |
| 25 | Freelance | D | ✅ |
| 26 | AI Assistant (Nexus chat) | E | ✅ (AI hub) |
| 27 | AI Study Planner | E | ✅ |
| 28 | AI GPA Simulator | E | ✅ |
| 29 | AI Graduation Planner | E | ✅ (independent of #18 by design — same shape of content, Nexus-framed, deliberately not sharing code so the two features stayed parallel-buildable) |
| 30 | AI Resume Builder | E | ✅ |
| 31 | AI Lecture Summary | E | ✅ |
| 32 | Profile | F | ✅ |
| 33 | Student ID | F | ✅ |
| 34 | Settings | F | ✅ (includes a working dark/light theme toggle) |
| 35 | Privacy | F | ✅ |
| 36 | Security | F | ✅ |
| 37 | Achievements | F | ✅ |
| 38 | About | F | ✅ |

All batches complete. This table is the final state for this sprint; see `docs/CHANGELOG.md` for the narrative history of how each batch landed.

## Design system inventory

**`core/widgets/`** (cross-feature, in `widgets.dart`'s barrel export): `AppCard` (base/raised
tiers, dashed/gradient variants), `AppButton` (primary/secondary/tertiary/destructive), `AppTextField`,
`AppSearchBar`, `AppSegmentedControl`, `TagChip`, `NavRowCard`, `ProgressRing` (attendance ring),
`AppProgressBar` (linear, with threshold tick), `GpaSparkline`, `SectionHeader`, `StatusPlaceholder`
(empty/error/success states in one widget), `SkeletonBox`/`SkeletonListTile`, `GlowBadge`, `AppMark`
(brand mark), `showAppBottomSheet(...)`, `AppSnackbar`, and in `large_title_scaffold.dart`:
`LargeTitleScaffold` (collapsing large-title tab roots) and `AppPushScaffold` (back-button pushed
screens).

**`core/theme/`**: color tokens (dark — primary — and light, as one `AppColors`
`ThemeExtension`), a UI + monospace type scale (`AppTypography`), a 4pt spacing scale
(`AppSpacing`), a corner-radius scale (`AppRadius`), and motion durations/curves (`AppMotion`). No
separate elevation scale — the design language is intentionally flat (hairline borders, no
Material shadows), per PROJECT_RULES.md §7.

**Feature-local widgets** (reused within one feature, not promoted to core since only that
feature needs them): `ListingCard` (campus), `AiMessageBubble`/`AiTypingIndicator` (ai),
`ProfileIdCard`/`IdPattern` (profile), `CourseDetailsSheet`/`CheckInSheet`/`NotificationsSheet`
(their respective features).

Every reusable shape above is built once and imported everywhere it's needed — no screen
hand-rolls its own card, button, or ring.
