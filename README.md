# O6U Nexus

The AI-powered smart campus platform for October 6 University — a Flutter frontend covering
academics, campus life, and an AI assistant ("Nexus") over a student's own record. This sprint is
**frontend only**: no backend, no real auth, no live network calls. Every screen runs on realistic
in-memory dummy data.

See `docs/` for the full picture:

- [`docs/PROJECT_RULES.md`](docs/PROJECT_RULES.md) — folder structure, coding/naming/widget rules.
- [`docs/MASTER_PLAN.md`](docs/MASTER_PLAN.md) — phased build plan and the full screen inventory.
- [`docs/Architecture.md`](docs/Architecture.md) — Clean Architecture layering, navigation, state.
- [`docs/CHANGELOG.md`](docs/CHANGELOG.md) — what's landed, batch by batch.
- [`docs/reference/o6u-nexus-ios.tsx`](docs/reference/o6u-nexus-ios.tsx) — the authoritative
  high-fidelity design reference this app ports into Flutter.

## Getting started

```bash
flutter pub get
flutter run              # pick an iOS simulator, Android emulator, or Chrome
```

Run quality gates before committing:

```bash
flutter analyze
flutter test
```

## Tech stack

Flutter (stable) · Riverpod (plain, no codegen) · go_router · Freezed · google_fonts ·
responsive_framework · flutter_animate · intl · flutter_svg · shared_preferences.
