import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_challenge.dart';
import 'campus_economy.dart';

/// Per-student progress toward each [CampusChallenge] — session-scoped
/// (same convention as the rest of Campus Network's interactive state).
/// Advancing a challenge to its target awards XP/coins exactly once via
/// [campusXpProvider]/[campusCoinsProvider].
class CampusChallengeProgressNotifier extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => {};

  bool isCompleted(CampusChallenge challenge) => (state[challenge.id] ?? 0) >= challenge.targetCount;

  void advance(CampusChallenge challenge) {
    final current = state[challenge.id] ?? 0;
    if (current >= challenge.targetCount) return;
    final next = current + 1;
    state = {...state, challenge.id: next};
    if (next >= challenge.targetCount) {
      ref.read(campusXpProvider.notifier).add(challenge.rewardXp);
      ref.read(campusCoinsProvider.notifier).earn(challenge.rewardCoins, challenge.title);
    }
  }
}

final campusChallengeProgressProvider = NotifierProvider<CampusChallengeProgressNotifier, Map<String, int>>(
  CampusChallengeProgressNotifier.new,
);
