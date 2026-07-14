import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class _GlanceStat {
  const _GlanceStat(this.label, this.value, this.color, this.sub);
  final String label;
  final String value;
  final Color Function(AppColors) color;
  final String sub;
}

final _stats = [
  _GlanceStat('Attendance', '92%', (c) => c.success, 'across 5 courses'),
  _GlanceStat('Next exam', '3 days', (c) => c.warning, 'MA201 · midterm'),
  _GlanceStat('Deadlines', '2 open', (c) => c.due, 'both due Sunday'),
  _GlanceStat('Credits left', '24 hrs', (c) => c.info, 'graduate Aug 2027'),
];

/// Four numbers a student actually re-checks. Anything else belongs in
/// Academics.
class GlanceGrid extends StatelessWidget {
  const GlanceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.7,
        children: [
          for (final stat in _stats)
            AppCard(
              onTap: () => context.go(AppRoutes.academics),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stat.label, style: text.footnote.copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    stat.value,
                    style: text.title2.copyWith(color: stat.color(colors), fontSize: 22, letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 2),
                  Text(stat.sub, style: text.caption1.copyWith(color: colors.textDim, fontWeight: FontWeight.w400, fontSize: 11.5)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
