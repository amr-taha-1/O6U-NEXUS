import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_challenge.dart';

/// Seed mission definitions — fictional, feature-demonstration content
/// (same convention as the rest of Campus Network). Per-student progress
/// lives in `campus_challenge_progress.dart`, not here.
class CampusChallengeRepository {
  const CampusChallengeRepository();

  List<CampusChallenge> getChallenges() => const [
        CampusChallenge(
          id: 'ch-daily-answer',
          title: 'Answer 5 Questions',
          description: 'Help classmates by answering 5 questions in Campus Community.',
          cadence: ChallengeCadence.daily,
          targetCount: 5,
          rewardXp: 50,
          rewardCoins: 20,
        ),
        CampusChallenge(
          id: 'ch-daily-help',
          title: 'Help 3 Students',
          description: 'Mark 3 of your comments as accepted answers.',
          cadence: ChallengeCadence.daily,
          targetCount: 3,
          rewardXp: 40,
          rewardCoins: 15,
        ),
        CampusChallenge(
          id: 'ch-weekly-summary',
          title: 'Upload a Study Summary',
          description: 'Share one study note or summary with the community.',
          cadence: ChallengeCadence.weekly,
          targetCount: 1,
          rewardXp: 100,
          rewardCoins: 40,
        ),
        CampusChallenge(
          id: 'ch-weekly-event',
          title: 'Attend an Event',
          description: 'Check in to one club or campus event.',
          cadence: ChallengeCadence.weekly,
          targetCount: 1,
          rewardXp: 80,
          rewardCoins: 30,
        ),
        CampusChallenge(
          id: 'ch-semester-quiz',
          title: 'Complete 10 Quizzes',
          description: 'Finish 10 practice quizzes across any course this semester.',
          cadence: ChallengeCadence.semester,
          targetCount: 10,
          rewardXp: 500,
          rewardCoins: 200,
        ),
      ];
}

final campusChallengeRepositoryProvider = Provider<CampusChallengeRepository>((ref) => const CampusChallengeRepository());

final campusChallengesProvider = Provider<List<CampusChallenge>>(
  (ref) => ref.watch(campusChallengeRepositoryProvider).getChallenges(),
);
