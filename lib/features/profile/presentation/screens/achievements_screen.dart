import 'package:flutter/cupertino.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/widgets.dart';

class _Badge {
  const _Badge(this.icon, this.color, this.title, this.subtitle, this.earned);
  final IconData icon;
  final Color Function(AppColors) color;
  final String title;
  final String subtitle;
  final bool earned;
}

final _badges = [
  _Badge(CupertinoIcons.rosette, (c) => c.accent, "Dean's List", 'Achieved', true),
  _Badge(CupertinoIcons.checkmark_seal_fill, (c) => c.success, 'Perfect Attendance', 'ISM413', true),
  _Badge(CupertinoIcons.alarm, (c) => c.info, 'Early Bird', 'Never late this term', true),
  _Badge(CupertinoIcons.flame_fill, (c) => c.warning, 'Study Streak', '14 days', true),
  _Badge(CupertinoIcons.chart_bar_fill, (c) => c.due, 'Course Topper', 'ISM424', false),
  _Badge(CupertinoIcons.moon_stars_fill, (c) => c.accent, 'Night Owl', '20 late-night sessions', false),
  _Badge(CupertinoIcons.tag_fill, (c) => c.info, 'Marketplace Pro', '10 items sold', false),
  _Badge(CupertinoIcons.person_2_fill, (c) => c.success, 'Mentor', 'Helped 5 peers', false),
];

/// Badges earned this degree — a grid, earned badges full-color, locked ones
/// dimmed with a lock overlay, mirroring the reference's stat-tile grid
/// pattern (`GlanceGrid`).
class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final earnedCount = _badges.where((b) => b.earned).length;
    return AppPushScaffold(
      title: 'Achievements',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 4),
            child: Text('$earnedCount of ${_badges.length} earned', style: context.textStyles.callout),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: GridView.count(
              crossAxisCount: context.isExpanded ? 3 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.05,
              children: [for (final badge in _badges) _BadgeTile(badge: badge)],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});

  final _Badge badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = badge.earned ? badge.color(colors) : colors.textDim;

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.tint(color, badge.earned ? 0.18 : 0.1),
              borderRadius: AppRadius.mdRadius,
            ),
            alignment: Alignment.center,
            child: Icon(badge.icon, size: 18, color: color),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  badge.title,
                  style: text.bodyEmphasized.copyWith(fontSize: 14, color: badge.earned ? colors.textPrimary : colors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!badge.earned) Icon(CupertinoIcons.lock_fill, size: 13, color: colors.textDim),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            badge.subtitle,
            style: text.footnote.copyWith(fontSize: 11.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
