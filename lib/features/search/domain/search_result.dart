/// Every place inside the app a global search hit can point to. Kept
/// distinct from [CourseCategory]/[CampusListingCategory] etc. — this is a
/// UI-facing grouping over the *union* of everything searchable, not a new
/// source of truth.
enum SearchCategory {
  profile,
  transcript,
  currentCourses,
  schedule,
  degreeProgress,
  gpaAnalytics,
  catalog,
  notifications,
}

extension SearchCategoryX on SearchCategory {
  String get label => switch (this) {
        SearchCategory.profile => 'Student Profile',
        SearchCategory.transcript => 'Transcript',
        SearchCategory.currentCourses => 'Current Courses',
        SearchCategory.schedule => 'Schedule',
        SearchCategory.degreeProgress => 'Degree Progress',
        SearchCategory.gpaAnalytics => 'GPA & Analytics',
        SearchCategory.catalog => 'Course Catalog & Bylaw',
        SearchCategory.notifications => 'Notifications',
      };
}

/// One searchable, tappable fact. [route] is always a real, already-wired
/// app route — search never invents a destination. Deliberately a plain
/// immutable class (not `@freezed`) rather than a domain model: it's a
/// computed index entry over other providers, the same pattern
/// `CourseEligibility` uses in the curriculum engine.
class SearchResult {
  const SearchResult({
    required this.id,
    required this.category,
    required this.title,
    required this.route,
    this.subtitle,
  });

  final String id;
  final SearchCategory category;
  final String title;
  final String? subtitle;
  final String route;
}
