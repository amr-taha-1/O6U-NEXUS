# O6U Nexus — Architecture

## Overview

O6U Nexus is a Flutter client built with a feature-first Clean Architecture. There is no backend
in this sprint: every "data source" is an in-memory repository seeded with realistic dummy data,
sitting behind the same interface a real HTTP/GraphQL repository would implement later. Swapping
dummy data for a live API is a `data/` layer change only — nothing in `presentation/` or
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
