# O6U Nexus — Architecture

## Overview

O6U Nexus is a Flutter client built with a feature-first Clean Architecture. There is no backend
in this sprint: every "data source" is a repository sitting behind the same interface a real
HTTP/GraphQL repository would implement later. Most repositories return in-memory dummy data;
the student's academic record (see "Real data" below) reads from real O6U data instead. Swapping
either kind for a live API is a `data/` layer change only — nothing in `presentation/` or
`application/` should need to move.

## Layers

```
presentation  →  application  →  domain
      ↓               ↓
   (widgets)      (providers)        domain ← data
```

- **domain** — Freezed value objects and enums. No Flutter imports. No behavior beyond simple
  derived getters (e.g. `Course.isAtRisk => attendance < 75`).
- **data** — Repository interfaces + their in-memory dummy implementations. This is the only layer
  that "knows" the data is fake.
- **application** — Riverpod providers. Reads from a repository, exposes immutable state, exposes
  intents (methods) that presentation calls. This is where a chat send, a grade-pick, or a
  mark-as-read lives.
- **presentation** — Screens and feature-local widgets. Consumes providers, renders design-system
  widgets from `core/widgets/`. No direct repository access.

## Why Clean Architecture here, specifically

The brief is explicit that a backend, real auth, and an LLM integration all arrive in a later
sprint. The repository-interface boundary is what makes that painless: `NexusRepository` today
returns canned `AiMessage`s from a map lookup; later it calls the real model. No screen changes.

## Navigation

`go_router` with a `StatefulShellRoute` for the five persistent tabs (Home, Academics, AI, Campus,
Profile), matching the bottom tab bar in the reference prototype. Each tab keeps its own
navigation stack (so switching tabs doesn't lose a pushed sub-screen), mirroring the prototype's
`stack` behavior where a pushed screen (Schedule, Grades, GPA Simulator, …) resets when you switch
tabs but not when you background/foreground the app.

Modal flows (Notifications, Course details, Check-in) are presented as bottom sheets via
`showModalBottomSheet`, matching the prototype's `Sheet` component — not pushed routes — because
they're dismissible overlays, not navigation destinations.

Auth (`Splash → Onboarding → Login → Face ID → Home`) is a separate top-level route branch outside
the shell; there is no bottom tab bar until the student is "signed in."

## State management

Plain Riverpod (no code generation). Each feature's `application/` folder holds:
- A `Provider`/`FutureProvider` exposing the repository's dummy data as domain models.
- A `NotifierProvider` (or `StateProvider` for trivial cases) for any UI-driven state — the Nexus
  chat transcript, the GPA simulator's grade picks, notification read/unread, the active
  marketplace segment.

`shared/application/student_provider.dart` exposes the signed-in student's profile — the one piece
of state nearly every screen reads (name, level, GPA headline, ID number).

## Theming

`core/theme/` builds two `ThemeData` objects (dark — the default and primary experience per the
reference prototype — and light) off one set of semantic color tokens, so a screen never reaches
for a raw hex value. Text styles are exposed via a `ThemeExtension` (`AppTypography`) so both the
UI type scale (system font, i.e. real San Francisco on iOS) and the monospace numeric scale are
available from `Theme.of(context).extension<AppTypography>()`.

## Responsiveness

`responsive_framework` wraps the app `MaterialApp.router.builder` with breakpoints at 600 and 840
logical pixels. `core/utils/responsive.dart` exposes `context.isCompact / isMedium / isExpanded`
helpers used to switch list layouts (single column → grid) and to cap sheet/dialog widths on
larger surfaces, without every screen re-deriving breakpoint math.

## Real data

The signed-in student's academic record — profile, transcript, degree-requirement audit, and
dashboard summary — is real O6U data (student 23017930), not fictional. It's a temporary local
data source until October 6 University provides an official API, but it's wired exactly as that
API integration will be: JSON files under `assets/data/` (`student.json`, `transcript.json`,
`degree_progress.json`, `dashboard.json`) are read through `JsonAssetLoader`
(`core/services/json_asset_loader.dart`) by repositories exposing `FutureProvider`s
(`currentStudentProvider`, `transcriptProvider`, `degreeProgressProvider`, `dashboardDataProvider`),
consumed by screens via `AsyncValue.when(data:, loading:, error:)` — the same shape a real HTTP call
would take. When the official API exists, only these repositories' fetch calls change (JSON read →
HTTP call); no provider, screen, or model changes.

Missing per-course hours/points (only Fall 2023/2024 has that granularity in the source transcript)
render as `—` rather than being guessed. `Student.expectedGraduation` is nullable for the same
reason — no graduation date was given, so none is fabricated.

The official grading scale (`assets/data/grade_scale.json`, read via `GradeScaleRepository` /
`gradeScaleProvider`) is the single source of truth for every letter-grade ↔ points ↔ marks-percent
conversion in the app — nothing hardcodes a grade→points map. The GPA Simulator gates on it the
same way it gates on `currentStudentProvider`.

The Information Systems curriculum (`assets/data/bylaw_information_systems.json`, transcribed from
the department's official Bylaw-2 prerequisites document) drives the Course Catalog / eligibility
engine (`features/curriculum/`): `completedCourseCodesProvider` derives "has this course been
passed" live from the real transcript (any grade except F/WF/W), and `courseEligibilityProvider`
cross-references that against each course's real prerequisite chain to compute completed / eligible
/ locked — no hardcoded eligibility rules. `FRM416` (Graduation Project 1) is a special case: its
prerequisite is Article 40 of the bylaw (a 103-completed-credit-hour threshold), not another course.
`estimatedRemainingSemestersProvider` is explicitly labelled an estimate (remaining hours ÷ the
student's own historical average hours/semester) — never presented as a promise.

Everything else (current-semester Schedule, Attendance, Assignments, Exam Schedule, the GPA
Simulator's course picker, Campus marketplace/social features) is still fictional dummy data — see
"Overview" above. `features/academics/.../transcript_course.dart` is deliberately named
`TranscriptCourse`, not `Course`, to avoid colliding with the existing (dummy, current-semester)
`shared/domain/course.dart` — the two are unrelated models for unrelated data.

## Testing

- `test/core/` — theme/util unit tests.
- `test/features/*/application/` — provider/notifier state-transition tests.
- `test/features/*/presentation/` — one smoke test per screen (pumps the widget inside a
  `ProviderScope` + `MaterialApp.router`, asserts key content renders, no exceptions).

**`flutter_animate` + widget tests**: every `.animate()` call kicks off with a zero-duration
`Timer` on `initState`. If a test's final action is asserting content and then ending, that timer
(from whatever's on screen at that moment) is often still "pending" and `flutter_test` fails the
test with `A Timer is still pending even after the widget tree was disposed`, even though nothing
is actually wrong. Fix: after your last assertion, pump once more with a small non-zero duration
(e.g. `await tester.pump(const Duration(milliseconds: 50));`) so the timer fires, then unmount the
tree (`await tester.pumpWidget(const SizedBox.shrink());`) so any animation controllers dispose
before the test ends. See `test/widget_test.dart` for a worked example. Never reach for
`pumpAndSettle()` on a screen with a repeating (`onPlay: (c) => c.repeat()`) animation — it will
hang forever waiting for a frame that never stops being scheduled.

**Real-data `FutureProvider`s + widget tests**: screens reading through `assets/data/*.json` (see
"Real data" below) resolve via a genuine `rootBundle.loadString` platform-channel round trip, not a
fake-clock `Timer` — so pumping frames to "wait it out" is unreliable (the number of pumps needed
isn't fixed, and racing it against other tests in the same file is flaky). Worse, `flutter_test`'s
asset-bundle channel only tolerates **one** real disk-backed asset load per test *isolate* — a
second independent `rootBundle.loadString` call anywhere else in the same test file hangs forever,
regardless of which screen triggers it. The fix used throughout `test/features/*/presentation/`:
create a single `ProviderContainer`, `await container.read(xProvider.future)` for every real-data
provider the file's screens touch (once, in `setUpAll` if the file has more than one such test),
then hand that same container to each widget via `UncontrolledProviderScope` instead of a fresh
`ProviderScope`. The data is available synchronously on the first build, and only one real read
ever happens per file. See `test/features/academics/presentation/academics_real_data_screens_test.dart`
and `test/features/ai/presentation/ai_sub_screens_test.dart` for worked examples.
