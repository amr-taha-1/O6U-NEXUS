# O6U Nexus — Project Rules

These rules are binding for every contribution to this repository, human or AI. They exist so the
codebase reads as if one disciplined engineer wrote all of it. If a change can't follow a rule,
the rule gets discussed and updated here first — it doesn't get silently broken.

## 1. Folder structure

```
lib/
  core/                       # Nothing here imports from features/.
    config/                   # App-wide config: env, flavors, feature flags
    theme/                    # Design tokens, ThemeData, text styles, colors
    router/                   # GoRouter setup, route names, shell/tab routes
    constants/                # Static constants (durations, breakpoints, keys)
    services/                 # Cross-cutting services (dummy data source, prefs)
    utils/                    # Pure helper functions/extensions, no widgets
    widgets/                  # Design-system widgets shared by every feature
  features/
    <feature>/
      data/                   # Dummy repositories, fixtures
      domain/                 # Freezed models, enums, value objects
      application/            # Riverpod providers/state for this feature
      presentation/
        screens/              # Full-page widgets (route destinations)
        widgets/               # Feature-local widgets (not reused elsewhere)
  shared/                     # Cross-feature domain concepts (e.g. Student,
                               # Course) that more than one feature reads.
  main.dart
docs/                         # This file and its siblings
assets/
test/
```

A feature never imports another feature's `presentation/` or `application/` layer directly.
Cross-feature data lives in `shared/`. If two features need the same widget, promote it to
`core/widgets/`, don't copy it.

## 2. Coding standards

- Dart/Flutter stable, null-safety everywhere, no `dynamic` unless interfacing with something that
  is genuinely dynamic (there is nothing genuinely dynamic in this app).
- `flutter analyze` must report zero issues before a change is considered done.
- Public widgets and providers get a one-line doc comment only when the name doesn't already say
  what they do. No comment blocks that restate the code.
- Prefer composition over inheritance. No widget subclassing StatefulWidget just to share a method
  — extract a function or a mixin only if the sharing is real.
- Files are named `snake_case.dart`; the primary class in a file matches the filename in
  `PascalCase`.

## 3. Naming conventions

| Kind | Convention | Example |
|---|---|---|
| Widget class | `PascalCase`, noun | `CourseCard`, `AttendanceRing` |
| Screen widget | `PascalCase` + `Screen` | `ScheduleScreen` |
| Provider | `camelCase` + `Provider` | `studentProvider`, `coursesProvider` |
| Freezed model | `PascalCase`, no `Model` suffix unless needed for disambiguation | `Course`, `GradeEntry` |
| Route name (GoRouter) | `camelCase`, matches path intent | `courseDetails` |
| File | `snake_case.dart` | `course_card.dart` |
| Constants | `SCREAMING_SNAKE` only for compile-time env keys; otherwise `camelCase` `const` | `kDefaultRadius` |

## 4. Widget rules

- Every widget that can be `const` is `const`. Constructors take a `Key? key` / `super.key`.
- No widget exceeds ~200 lines. Past that, extract sub-widgets into private `_XyzSection` classes
  or a `presentation/widgets/` file.
- No business logic inside a `build()` method beyond simple derivations (formatting, mapping a
  model to a display string). Anything stateful or asynchronous belongs in a provider.
- Screens read from providers via `ConsumerWidget`/`ConsumerStatefulWidget`. They do not construct
  dummy data inline — they ask a provider for it.
- Every interactive control has a minimum 44×44 pt hit area, per Apple HIG.

## 5. State management rules (Riverpod)

- Plain (non-code-generated) Riverpod providers: `Provider`, `StateProvider`,
  `NotifierProvider`/`StateNotifierProvider`, `FutureProvider`. No `riverpod_generator` — it adds a
  build_runner dependency for no benefit at this app's size.
- One provider file per feature concept, in `features/<feature>/application/`.
- Providers expose immutable (Freezed) state. Mutation happens through methods on a `Notifier`,
  never by handing out a mutable reference.
- `ref.watch` in `build()`, `ref.read` in callbacks. Never `ref.watch` inside a callback.
- Dummy data lives behind a repository interface in `data/`, even though today it's backed by an
  in-memory fixture. Swapping in a real API later means replacing the repository implementation,
  not touching any widget.

## 6. Responsive rules

- Layout breakpoints (via `responsive_framework`): compact (phone, <600), medium (large
  phone/small tablet, 600–840), expanded (tablet/desktop/web, ≥840).
- No fixed pixel widths for content columns. Use `MediaQuery`/`LayoutBuilder` +
  `core/utils/responsive.dart` helpers.
- Every screen is scrollable and tested against the iPhone SE width (375) as the minimum and an
  iPad/web width (≥1024) as the maximum.
- Bottom sheets and dialogs cap their width on wide layouts (max 480 pt) and center themselves;
  they never stretch edge-to-edge on tablet/web.

## 7. Design rules

- One accent color per meaning, enforced by the semantic tokens in `core/theme/` — amber always
  means "below threshold / at risk," green always means "on track," never reused for anything
  else.
- Large collapsing titles (iOS 26 pattern) on every top-level tab; inline nav title appears once
  the user scrolls.
- Cards use the shared `GlassCard`/`AppCard` widgets — no screen defines its own card decoration.
- SF Symbols–style iconography via `CupertinoIcons`; no Material icons in user-facing UI.
- Numbers a student re-checks (GPA, attendance %, countdowns, IDs) render in the monospace type
  scale (`AppTypography.mono*`), everything else in the UI type scale.

## 8. Animation rules

- All animation durations and curves come from `core/theme/app_motion.dart` — no ad hoc
  `Duration(milliseconds: 240)` scattered through screens.
- Motion is functional: it shows where something came from (push transitions, hero handoff) or
  confirms an action (button press, check-in success), then it stops. No looping decoration that
  doesn't communicate state.
- Respect `MediaQuery.disableAnimations` / reduced-motion: every custom animation must have a
  reduced-motion-safe fallback (instant state change).
- Use `flutter_animate` for entrance/emphasis animation instead of hand-rolled
  `AnimationController`s unless the interaction needs frame-level control (e.g. a drag-driven
  sheet).

## 9. Code quality rules

- `flutter analyze` — zero warnings, zero errors, before merge.
- `flutter test` — every core utility and every provider's state transitions get a test; every
  screen gets at least one smoke test (pumps without throwing, finds its key content).
- No `print()` — use the app logger in `core/services/logger.dart`.
- No commented-out code committed. Delete it; git remembers it.
- Imports ordered: `dart:*`, then `package:flutter/*`, then third-party packages, then project
  imports (`package:o6u_nexus/...`), each group alphabetized, blank line between groups.
