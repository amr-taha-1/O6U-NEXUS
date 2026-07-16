import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/leaderboard_providers.dart';

/// Multiple leaderboards, each a live sort — see `leaderboard_providers.dart`
/// for exactly what each one ranks by and why (especially "Top GPA," which
/// ranks by academic reputation rather than real classmate GPAs no source
/// in this app has).
class LeaderboardsScreen extends ConsumerStatefulWidget {
  const LeaderboardsScreen({super.key});

  @override
  ConsumerState<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends ConsumerState<LeaderboardsScreen> {
  LeaderboardCategory _category = LeaderboardCategory.topContributors;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    if (_category == LeaderboardCategory.topClubs) {
      final clubEntries = ref.watch(clubLeaderboardProvider);
      return AppPushScaffold(
        title: 'Leaderboards',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CategoryPicker(selected: _category, onChanged: (c) => setState(() => _category = c)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < clubEntries.length; i++)
                      Container(
                        constraints: const BoxConstraints(minHeight: 52),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(border: i == 0 ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
                        child: Row(
                          children: [
                            SizedBox(width: 26, child: Text('${clubEntries[i].rank}', style: text.monoBody.copyWith(color: colors.accent))),
                            Expanded(child: Text(clubEntries[i].name, style: text.body.copyWith(fontSize: 14.5))),
                            Text('${clubEntries[i].memberCount} members', style: text.footnote.copyWith(color: colors.textMuted)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    final entries = ref.watch(leaderboardProvider(_category));
    return AppPushScaffold(
      title: 'Leaderboards',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CategoryPicker(selected: _category, onChanged: (c) => setState(() => _category = c)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: entries.isEmpty
                ? const StatusPlaceholder.empty(icon: CupertinoIcons.chart_bar, title: 'No entries yet', message: 'Nobody qualifies for this leaderboard yet.')
                : AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        for (var i = 0; i < entries.length; i++)
                          Container(
                            constraints: const BoxConstraints(minHeight: 56),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                            decoration: BoxDecoration(border: i == 0 ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 26,
                                  child: Text(
                                    '${entries[i].rank}',
                                    style: text.monoBody.copyWith(color: entries[i].rank <= 3 ? colors.warning : colors.textMuted),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(entries[i].member.fullName, style: text.body.copyWith(fontSize: 14.5, fontWeight: FontWeight.w500)),
                                      Text(entries[i].member.department, style: text.caption1.copyWith(color: colors.textMuted)),
                                    ],
                                  ),
                                ),
                                Text(entries[i].scoreLabel, style: text.footnote.copyWith(color: colors.textMuted)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPicker extends StatelessWidget {
  const _CategoryPicker({required this.selected, required this.onChanged});
  final LeaderboardCategory selected;
  final ValueChanged<LeaderboardCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin, vertical: 10),
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        children: [
          for (final category in LeaderboardCategory.values)
            GestureDetector(
              onTap: () => onChanged(category),
              child: TagChip(label: category.label, color: colors.accent, filled: category == selected, selected: category == selected),
            ),
        ],
      ),
    );
  }
}
