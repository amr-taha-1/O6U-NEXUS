import '../domain/ride_participant.dart';

enum TrustBadge { trustedDriver, topRated, frequentDriver, verifiedStudent, campusAmbassador }

extension TrustBadgeX on TrustBadge {
  String get emoji => switch (this) {
        TrustBadge.trustedDriver => '🟢',
        TrustBadge.topRated => '⭐',
        TrustBadge.frequentDriver => '🚘',
        TrustBadge.verifiedStudent => '🎓',
        TrustBadge.campusAmbassador => '🏆',
      };

  String get label => switch (this) {
        TrustBadge.trustedDriver => 'Trusted Driver',
        TrustBadge.topRated => 'Top Rated',
        TrustBadge.frequentDriver => 'Frequent Driver',
        TrustBadge.verifiedStudent => 'Verified Student',
        TrustBadge.campusAmbassador => 'Campus Ambassador',
      };
}

class TrustScore {
  const TrustScore({required this.score, required this.label, required this.badges});
  final int score;
  final String label;
  final List<TrustBadge> badges;
}

/// A transparent, deterministic 0–100 score computed from a participant's
/// own ride stats — never a stored, hand-picked number. Starts at a neutral
/// baseline of 50 and moves with real signals: ride volume (capped so a
/// handful of rides can't dominate), rating relative to the 3-star
/// midpoint, a verification bonus, and penalties for cancellations/reports.
/// The exact weights are a documented judgment call (no official O6U rubric
/// exists for this brand-new feature), not a fabricated academic fact.
TrustScore computeTrustScore(RideParticipant participant) {
  var score = 50.0;
  score += participant.completedRides.clamp(0, 100) * 0.3;
  score += (participant.averageRating - 3) * 10;
  score += participant.verified ? 10 : 0;
  score -= participant.cancellations * 3;
  score -= participant.reportsReceived * 15;
  final clamped = score.clamp(0, 100).round();

  final label = switch (clamped) {
    >= 90 => 'Excellent',
    >= 75 => 'Great',
    >= 60 => 'Good',
    >= 40 => 'Fair',
    _ => 'New / Limited History',
  };

  final badges = <TrustBadge>[
    if (participant.verified) TrustBadge.verifiedStudent,
    if (clamped >= 85 && participant.completedRides >= 10) TrustBadge.trustedDriver,
    if (participant.averageRating >= 4.8) TrustBadge.topRated,
    if (participant.completedRides >= 25) TrustBadge.frequentDriver,
    if (participant.completedRides >= 50 && participant.reportsReceived == 0) TrustBadge.campusAmbassador,
  ];

  return TrustScore(score: clamped, label: label, badges: badges);
}
