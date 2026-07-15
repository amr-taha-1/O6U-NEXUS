import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/json_asset_loader.dart';
import '../domain/dashboard_data.dart';

const _assetPath = 'assets/data/dashboard.json';

/// Reads the Home dashboard's own config (greeting, quick actions) from
/// `assets/data/dashboard.json` — see the note on `StudentRepository` re:
/// temporary local data source.
class DashboardRepository {
  const DashboardRepository();

  Future<DashboardData> getDashboardData() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    final actions = json['quickActions'] as List<dynamic>;
    return DashboardData(
      greetingName: json['greetingName'] as String,
      quickActions: [
        for (final a in actions)
          QuickAction(
            label: (a as Map<String, dynamic>)['label'] as String,
            iconName: a['iconName'] as String,
            route: a['route'] as String,
          ),
      ],
    );
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) => const DashboardRepository());

final dashboardDataProvider = FutureProvider<DashboardData>((ref) {
  return ref.watch(dashboardRepositoryProvider).getDashboardData();
});
