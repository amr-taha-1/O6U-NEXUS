import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_routes.dart';
import '../../campus/data/carpool_repository.dart';
import '../../campus/domain/ride.dart';
import '../../curriculum/application/curriculum_engine.dart';
import '../../degree_progress/data/degree_progress_repository.dart';
import '../../schedule/application/schedule_providers.dart';
import '../../schedule/domain/schedule_session.dart';
import '../data/campus_post_repository.dart';
import '../data/club_repository.dart';
import '../domain/smart_feed_item.dart';

/// "Instead of a normal feed, show personalized information." Every item
/// is sourced from a real provider already in the app — the aggregation is
/// new, the underlying facts aren't: next class from the real schedule, a
/// recommended course from the real eligibility engine, the closest
/// to-campus carpool by seed distance, degree-progress hours remaining,
/// and (clearly seed, not fabricated-as-real) a trending Campus Community
/// post and the soonest club event.
final campusIntelligenceFeedProvider = FutureProvider<List<SmartFeedItem>>((ref) async {
  final items = <SmartFeedItem>[];

  final nextSession = await ref.watch(nextSessionProvider.future);
  if (nextSession != null) {
    items.add(SmartFeedItem(
      kind: SmartFeedItemKind.upcomingClass,
      title: 'Next class: ${nextSession.courseName}',
      subtitle: '${nextSession.day.label} · ${nextSession.timeRangeLabel} · Room ${nextSession.room}',
      route: AppRoutes.academicsSchedule,
    ));
  }

  final eligible = await ref.watch(eligibleNextCoursesProvider.future);
  if (eligible.isNotEmpty) {
    final course = eligible.first;
    items.add(SmartFeedItem(
      kind: SmartFeedItemKind.recommendedCourse,
      title: 'You can register: ${course.name}',
      subtitle: '${course.code} · ${course.creditHours} credit hours · prerequisites met',
      route: AppRoutes.courseDetailsPath(course.code),
    ));
  }

  final toCampusRides = ref.watch(carpoolRidesProvider(RideDirection.toCampus));
  if (toCampusRides.isNotEmpty) {
    final nearest = [...toCampusRides]..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    final ride = nearest.first;
    items.add(SmartFeedItem(
      kind: SmartFeedItemKind.nearbyCarpool,
      title: 'Carpool nearby: ${ride.driver.fullName}',
      subtitle: '${ride.originLabel} → ${ride.destinationLabel} · ${ride.departureTimeLabel}',
      route: AppRoutes.carpoolRidePath(ride.id),
    ));
  }

  final degreeProgress = await ref.watch(degreeProgressProvider.future);
  items.add(SmartFeedItem(
    kind: SmartFeedItemKind.degreeProgressNudge,
    title: '${degreeProgress.graduationHoursRemaining} hours left to graduate',
    subtitle: '${degreeProgress.graduationHoursCompleted} of ${degreeProgress.graduationHoursRequired} completed',
    route: AppRoutes.academicsGraduation,
  ));

  final posts = ref.watch(campusPostsProvider);
  if (posts.isNotEmpty) {
    final trending = [...posts]..sort((a, b) => b.likeCount.compareTo(a.likeCount));
    final post = trending.first;
    items.add(SmartFeedItem(
      kind: SmartFeedItemKind.trendingPost,
      title: 'Trending: ${post.author.fullName}\'s post',
      subtitle: '${post.likeCount} likes · ${post.commentCount} comments',
      route: AppRoutes.campusNetworkPostPath(post.id),
    ));
  }

  final clubs = ref.watch(clubsProvider);
  final upcomingEvents = [
    for (final club in clubs)
      for (final event in club.events) (club: club, event: event),
  ]..sort((a, b) => a.event.dateTime.compareTo(b.event.dateTime));
  if (upcomingEvents.isNotEmpty) {
    final next = upcomingEvents.first;
    items.add(SmartFeedItem(
      kind: SmartFeedItemKind.upcomingClubEvent,
      title: next.event.title,
      subtitle: '${next.club.shortName} · ${next.event.location}',
      route: AppRoutes.campusNetworkClubPath(next.club.id),
    ));
  }

  return items;
});
