import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/json_asset_loader.dart';
import '../domain/grade_band.dart';

const _assetPath = 'assets/data/grade_scale.json';

/// Reads the official O6U grading scale from
/// `assets/data/grade_scale.json` — every GPA calculation in the app
/// (the GPA Simulator, and any future grade-points math) must go through
/// this instead of a hardcoded letter→points map, so the one source of
/// truth is the uploaded scale, not code. See docs/Architecture.md
/// "Real data".
class GradeScaleRepository {
  const GradeScaleRepository();

  Future<List<GradeBand>> getGradeScale() async {
    final json = await JsonAssetLoader.loadList(_assetPath);
    return [
      for (final entry in json.cast<Map<String, dynamic>>())
        GradeBand(
          letter: entry['letter'] as String,
          minPercent: (entry['minPercent'] as num).toDouble(),
          maxPercent: (entry['maxPercent'] as num?)?.toDouble(),
          points: (entry['points'] as num).toDouble(),
        ),
    ];
  }
}

final gradeScaleRepositoryProvider = Provider<GradeScaleRepository>((ref) => const GradeScaleRepository());

final gradeScaleProvider = FutureProvider<List<GradeBand>>((ref) {
  return ref.watch(gradeScaleRepositoryProvider).getGradeScale();
});

/// Grade-points lookups against the real scale — every GPA calculation in
/// the app should go through these, never a hardcoded letter→points map.
extension GradeScaleX on List<GradeBand> {
  double pointsForLetter(String letter) {
    for (final band in this) {
      if (band.letter == letter) return band.points;
    }
    return 0;
  }

  /// The letter grade for a raw marks percentage, per the official scale.
  String letterForPercent(double percent) {
    for (final band in this) {
      if (band.covers(percent)) return band.letter;
    }
    return isEmpty ? '—' : last.letter;
  }

  /// Weighted GPA for a set of (creditHours, letter grade) pairs — the same
  /// formula used for cumulative/semester GPA everywhere else in the app:
  /// sum(points × hours) / sum(hours).
  double gpaFor(Iterable<(int creditHours, String letter)> courses) {
    var totalHours = 0;
    var totalPoints = 0.0;
    for (final (hours, letter) in courses) {
      totalHours += hours;
      totalPoints += pointsForLetter(letter) * hours;
    }
    return totalHours == 0 ? 0 : totalPoints / totalHours;
  }
}
