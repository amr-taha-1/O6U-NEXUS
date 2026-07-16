import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/campus/data/carpool_repository.dart';
import 'package:o6u_nexus/features/campus_network/application/campus_dna_provider.dart';
import 'package:o6u_nexus/features/campus_network/application/campus_intelligence_feed_provider.dart';
import 'package:o6u_nexus/features/campus_network/application/current_student_campus_member.dart';
import 'package:o6u_nexus/features/campus_network/data/campus_challenge_repository.dart';
import 'package:o6u_nexus/features/campus_network/data/campus_member_repository.dart';
import 'package:o6u_nexus/features/campus_network/data/campus_post_repository.dart';
import 'package:o6u_nexus/features/campus_network/data/campus_video_repository.dart';
import 'package:o6u_nexus/features/campus_network/data/club_repository.dart';
import 'package:o6u_nexus/features/campus_network/data/study_group_repository.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/campus_dna_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/campus_network_home_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/campus_videos_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/challenges_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/club_details_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/clubs_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/community_feed_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/leaderboards_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/member_profile_screen.dart';
import 'package:o6u_nexus/features/campus_network/presentation/screens/study_groups_screen.dart';
import 'package:o6u_nexus/features/curriculum/application/curriculum_engine.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/schedule/application/schedule_providers.dart';
import 'package:o6u_nexus/features/schedule/data/schedule_repository.dart';
import 'package:o6u_nexus/features/transcript/application/transcript_enrichment.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
import 'package:o6u_nexus/shared/data/grade_scale_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';
import 'package:o6u_nexus/shared/domain/student.dart';

/// Campus Network (Phase 3) — see docs/Architecture.md "Testing" for why
/// every real-data test in a file shares one [ProviderContainer] resolved
/// once in [setUpAll], and why nothing here re-awaits an already-resolved
/// container future inside a `testWidgets` body (a `FakeAsync` deadlock —
/// see the fix in `test/features/campus/carpool_test.dart`'s doc comment).
late ProviderContainer _container;
late Student _student;

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    _student = await _container.read(currentStudentProvider.future);
    await _container.read(currentStudentAsCampusMemberProvider.future);
    await _container.read(enrichedTranscriptProvider.future);
    await _container.read(transferredCreditsProvider.future);
    await _container.read(curriculumProvider.future);
    await _container.read(minCreditHoursForGraduationProjectProvider.future);
    await _container.read(courseEligibilityProvider.future);
    await _container.read(eligibleNextCoursesProvider.future);
    await _container.read(degreeProgressProvider.future);
    await _container.read(scheduleProvider.future);
    await _container.read(weeklyScheduleProvider.future);
    await _container.read(todaysSessionsProvider.future);
    await _container.read(nextSessionProvider.future);
    await _container.read(minutesUntilNextSessionProvider.future);
    await _container.read(gradeScaleProvider.future);
    await _container.read(semesterGpaTrendProvider.future);
    await _container.read(campusDnaProvider.future);
    await _container.read(campusIntelligenceFeedProvider.future);
  });

  tearDownAll(() {
    _container.dispose();
  });

  Future<void> pumpReady(WidgetTester tester, Widget screen) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: _container,
        child: MaterialApp(theme: AppTheme.dark(), home: screen),
      ),
    );
    await tester.pump();
  }

  test('seed repositories all produce non-empty content', () {
    expect(_container.read(campusMembersProvider), isNotEmpty);
    expect(_container.read(campusPostsProvider), isNotEmpty);
    expect(_container.read(studyGroupsProvider), isNotEmpty);
    expect(_container.read(clubsProvider), isNotEmpty);
    expect(_container.read(campusChallengesProvider), isNotEmpty);
    expect(_container.read(campusVideosProvider), isNotEmpty);
    expect(_container.read(carpoolRepositoryProvider).getRides(), isNotEmpty);
  });

  testWidgets('CampusNetworkHomeScreen renders the real greeting and a smart feed', (tester) async {
    await pumpReady(tester, const CampusNetworkHomeScreen());
    expect(find.textContaining(_student.firstName), findsOneWidget);
    expect(find.text('Campus Network'), findsWidgets);
  });

  testWidgets('CommunityFeedScreen renders posts and hashtag filters', (tester) async {
    await pumpReady(tester, const CommunityFeedScreen());
    expect(find.text('Campus Community'), findsWidgets);
    expect(find.text('#Database'), findsWidgets);
  });

  testWidgets("MemberProfileScreen('me') renders the real student's own portfolio card", (tester) async {
    await pumpReady(tester, const MemberProfileScreen(memberId: 'me'));
    expect(find.text(_student.name), findsOneWidget);
    expect(find.text('REPUTATION'), findsOneWidget); // SectionHeader uppercases
  });

  testWidgets('StudyGroupsScreen renders join-able study groups', (tester) async {
    await pumpReady(tester, const StudyGroupsScreen());
    expect(find.text('Study Groups'), findsWidgets);
    expect(find.textContaining('joined'), findsWidgets);
  });

  testWidgets('ClubsScreen renders every seed club', (tester) async {
    await pumpReady(tester, const ClubsScreen());
    expect(find.text('IEEE O6U Student Branch'), findsOneWidget);
    expect(find.text('Google Developer Group O6U'), findsOneWidget);
  });

  testWidgets('ClubDetailsScreen renders announcements and events for a real club', (tester) async {
    await pumpReady(tester, const ClubDetailsScreen(clubId: 'club-ieee'));
    expect(find.text('IEEE'), findsWidgets);
    expect(find.textContaining('Robotics workshop'), findsOneWidget);
  });

  testWidgets('ChallengesScreen renders daily/weekly/semester missions', (tester) async {
    await pumpReady(tester, const ChallengesScreen());
    expect(find.text('DAILY MISSIONS'), findsOneWidget); // SectionHeader uppercases
    expect(find.text('Answer 5 Questions'), findsOneWidget);
  });

  testWidgets('LeaderboardsScreen renders a ranked list', (tester) async {
    await pumpReady(tester, const LeaderboardsScreen());
    expect(find.text('Leaderboards'), findsWidgets);
    expect(find.text('Top Contributors'), findsOneWidget);
  });

  testWidgets('CampusVideosScreen renders the seed video feed', (tester) async {
    await pumpReady(tester, const CampusVideosScreen());
    expect(find.text('Riverpod in 60 seconds'), findsOneWidget);
  });

  testWidgets('CampusDnaScreen computes strongest/weakest category from the real transcript', (tester) async {
    await pumpReady(tester, const CampusDnaScreen());
    expect(find.text('Campus DNA'), findsWidgets);
    expect(find.textContaining('activity-tracking data'), findsOneWidget);
  });
}
