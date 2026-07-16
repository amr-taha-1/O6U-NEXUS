import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_challenge.freezed.dart';

enum ChallengeCadence { daily, weekly, semester }

extension ChallengeCadenceX on ChallengeCadence {
  String get label => switch (this) {
        ChallengeCadence.daily => 'Daily',
        ChallengeCadence.weekly => 'Weekly',
        ChallengeCadence.semester => 'Semester',
      };
}

/// A mission definition — reward XP/coins on completion. Per-student
/// *progress* toward [targetCount] is tracked separately
/// (`campus_challenge_progress.dart`), since the same challenge definition
/// is shared by every student.
@freezed
abstract class CampusChallenge with _$CampusChallenge {
  const factory CampusChallenge({
    required String id,
    required String title,
    required String description,
    required ChallengeCadence cadence,
    required int targetCount,
    required int rewardXp,
    required int rewardCoins,
  }) = _CampusChallenge;
}
