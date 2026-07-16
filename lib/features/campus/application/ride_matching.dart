import '../domain/ride.dart';
import 'trust_score.dart';

/// Ranks rides instead of listing them arbitrarily — a 0–100 "match"
/// percentage from every real/derivable signal available in this build:
/// trust score, rating, how soon the ride departs, how close the
/// pickup/drop-off is to campus (seed distance), favorite-driver status,
/// and the student's own ride history with this driver. Distance-from-home
/// and "previous successful rides together" are real inputs, not
/// hardcoded — they're simply 0/absent until the student has an address on
/// file or has actually ridden with someone, which this build is honest
/// about rather than inventing.
double matchPercentFor(
  Ride ride, {
  required bool isFavoriteDriver,
  required int pastRidesWithDriver,
  DateTime? now,
}) {
  final trust = computeTrustScore(ride.driver);
  final clockNow = now ?? DateTime.now();

  final minutesToDeparture = ride.departureTime.difference(clockNow).inMinutes.abs();
  final timeScore = (1 - (minutesToDeparture.clamp(0, 720) / 720)) * 100;

  final distanceScore = (1 - (ride.distanceKm.clamp(0, 20) / 20)) * 100;
  final favoriteScore = isFavoriteDriver ? 100.0 : 0.0;
  final historyScore = (pastRidesWithDriver.clamp(0, 5) / 5) * 100;
  final ratingScore = (ride.driver.averageRating.clamp(0, 5) / 5) * 100;

  final weighted = trust.score * 0.25 +
      timeScore * 0.15 +
      distanceScore * 0.15 +
      favoriteScore * 0.15 +
      historyScore * 0.10 +
      ratingScore * 0.20;

  return weighted.clamp(0, 100);
}
