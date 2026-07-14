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
- `shared/domain`: Freezed models — `Student`, `Course`, `GradeEntry`, `AttendanceRecord`,
  `ScheduleItem`, `Notification`, `MarketplaceListing`, `CampusEvent`, `StudyGroup`, `AiMessage`.
- `shared/data`: in-memory dummy repositories seeded with realistic O6U data.

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

Status legend: ⬜ not started · 🟨 in progress · ✅ done

| # | Screen | Batch | Status |
|---|---|---|---|
| 1 | Splash | A | ⬜ |
| 2 | Onboarding | A | ⬜ |
| 3 | Login | A | ⬜ |
| 4 | Forgot Password | A | ⬜ |
| 5 | Face ID | A | ⬜ |
| 6 | Home Dashboard | B | ⬜ |
| 7 | Announcements | B | ⬜ |
| 8 | Notifications | B | ⬜ |
| 9 | Academics hub (Portal) | C | ⬜ |
| 10 | Schedule | C | ⬜ |
| 11 | Exam Schedule | C | ⬜ |
| 12 | Attendance | C | ⬜ |
| 13 | Grades | C | ⬜ |
| 14 | GPA | C | ⬜ |
| 15 | Transcript | C | ⬜ |
| 16 | Course Details | C | ⬜ |
| 17 | Assignments | C | ⬜ |
| 18 | Graduation Progress | C | ⬜ |
| 19 | Marketplace | D | ⬜ |
| 20 | Book Exchange | D | ⬜ |
| 21 | Lost & Found | D | ⬜ |
| 22 | Study Groups | D | ⬜ |
| 23 | Events | D | ⬜ |
| 24 | Internships | D | ⬜ |
| 25 | Freelance | D | ⬜ |
| 26 | AI Assistant (Nexus chat) | E | ⬜ |
| 27 | AI Study Planner | E | ⬜ |
| 28 | AI GPA Simulator | E | ⬜ |
| 29 | AI Graduation Planner | E | ⬜ |
| 30 | AI Resume Builder | E | ⬜ |
| 31 | AI Lecture Summary | E | ⬜ |
| 32 | Profile | F | ⬜ |
| 33 | Student ID | F | ⬜ |
| 34 | Settings | F | ⬜ |
| 35 | Privacy | F | ⬜ |
| 36 | Security | F | ⬜ |
| 37 | Achievements | F | ⬜ |
| 38 | About | F | ⬜ |

This table is updated as each batch lands; see `docs/CHANGELOG.md` for the narrative history.

## Design system inventory

Color system · Dark theme (primary) · Light theme · Typography scale · Spacing scale (4pt base) ·
Grid/breakpoints · Elevation scale · Corner-radius scale · Buttons (primary/secondary/tertiary/
destructive) · Cards (glass/solid/outlined) · Text fields · Search bars · Segmented control ·
Bottom navigation · Large-title nav bar · Bottom sheets · Dialogs/alerts · Snackbars/toasts ·
Progress rings (attendance) · Line charts (GPA trend) · Stat tiles · Course cards · AI message
cards · Announcement cards · Marketplace listing cards · Profile header card · Skeleton loaders ·
Empty states · Error states · Success states.

Every one of these is a widget in `core/widgets/`, built once, reused everywhere — no screen
hand-rolls its own card, button, or ring.
