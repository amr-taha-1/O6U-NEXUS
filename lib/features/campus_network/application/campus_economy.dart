import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One entry in the student's Campus Coins ledger.
class CampusCoinTransaction {
  const CampusCoinTransaction({required this.id, required this.amount, required this.reason, required this.timestamp});
  final String id;
  final int amount;
  final String reason;
  final DateTime timestamp;
}

/// The Campus Coins economy — session-scoped (same convention as
/// `carpool_favorites.dart`). Coins are earned via [earn] (challenge
/// completion, helping students, volunteering…) and are meant to
/// "later be redeemed by university partners" per the feature spec — that
/// redemption side needs a real partner-integration backend this build
/// doesn't have, so [balance] only ever grows here; spending/redemption is
/// intentionally not implemented (see the closing report's Skipped list).
class CampusCoinsNotifier extends Notifier<List<CampusCoinTransaction>> {
  int _nextId = 1;

  @override
  List<CampusCoinTransaction> build() => [];

  void earn(int amount, String reason) {
    state = [
      ...state,
      CampusCoinTransaction(id: 'txn-${_nextId++}', amount: amount, reason: reason, timestamp: DateTime.now()),
    ];
  }
}

final campusCoinsProvider = NotifierProvider<CampusCoinsNotifier, List<CampusCoinTransaction>>(CampusCoinsNotifier.new);

final campusCoinsBalanceProvider = Provider<int>((ref) {
  var total = 0;
  for (final txn in ref.watch(campusCoinsProvider)) {
    total += txn.amount;
  }
  return total;
});

/// Session XP, separate from the seed [CampusMember.xp] shown on other
/// students' cards — the signed-in student's *own* XP starts at 0 (see
/// `current_student_campus_member.dart`) and only grows from real actions
/// taken in this session (completing a challenge).
class CampusXpNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void add(int amount) => state = state + amount;
}

final campusXpProvider = NotifierProvider<CampusXpNotifier, int>(CampusXpNotifier.new);

/// A simple daily-open streak counter. Since this build has no persistence
/// across app restarts (`shared_preferences` isn't wired up for this yet),
/// the streak always starts at 1 for "today" rather than fabricating a
/// multi-day history — see the closing report's Assumptions list.
final campusStreakProvider = Provider<int>((ref) => 1);
