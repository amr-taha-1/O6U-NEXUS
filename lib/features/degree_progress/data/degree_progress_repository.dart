import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/json_asset_loader.dart';
import '../domain/degree_progress.dart';

const _assetPath = 'assets/data/degree_progress.json';

/// Reads the degree-audit breakdown from `assets/data/degree_progress.json`
/// — see the note on `StudentRepository` re: temporary local data source.
class DegreeProgressRepository {
  const DegreeProgressRepository();

  Future<DegreeProgress> getDegreeProgress() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    final categories = json['categories'] as List<dynamic>;
    return DegreeProgress(
      categories: [
        for (final c in categories)
          DegreeRequirementCategory(
            name: (c as Map<String, dynamic>)['name'] as String,
            requiredHours: c['required'] as int,
            completedHours: c['completed'] as int,
          ),
      ],
      graduationHoursRequired: json['graduationHoursRequired'] as int,
      graduationHoursCompleted: json['graduationHoursCompleted'] as int,
      cgpa: (json['cgpa'] as num).toDouble(),
    );
  }
}

final degreeProgressRepositoryProvider = Provider<DegreeProgressRepository>((ref) => const DegreeProgressRepository());

final degreeProgressProvider = FutureProvider<DegreeProgress>((ref) {
  return ref.watch(degreeProgressRepositoryProvider).getDegreeProgress();
});
