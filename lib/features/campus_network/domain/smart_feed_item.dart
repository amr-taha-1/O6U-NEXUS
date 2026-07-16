enum SmartFeedItemKind { upcomingClass, recommendedStudyGroup, nearbyCarpool, trendingPost, upcomingClubEvent, degreeProgressNudge, recommendedCourse }

/// One row of the Campus Intelligence smart feed — every item's [route]
/// points at a route the app already serves; nothing here is a dead end.
/// See `campus_intelligence_feed_provider.dart` for how each [kind] is
/// sourced from real app data (schedule, eligibility, carpool, degree
/// progress) or clearly-labelled seed content (trending post, club event).
class SmartFeedItem {
  const SmartFeedItem({required this.kind, required this.title, required this.subtitle, required this.route});
  final SmartFeedItemKind kind;
  final String title;
  final String subtitle;
  final String route;
}
