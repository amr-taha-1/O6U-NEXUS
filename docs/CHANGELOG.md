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

### Fixed
- `AppSearchBar`'s `TextField` asserts a `Material` ancestor at build time; nothing in the
  Cupertino-styled scaffold chain (`AppShell` → `LargeTitleScaffold`/`AppPushScaffold`) provided
  one, so any screen rendering the widget — including the already-shipped `CampusScreen` hub —
  crashed immediately. Wrapped it in a transparent `Material` locally (no fill/elevation/ink, so
  the iOS HIG look is unaffected).

<!-- Subsequent entries are appended above this line as each batch lands. -->
