import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/student.dart';

class _GlanceStat {
  const _GlanceStat(this.label, this.value, this.color, this.sub);
  final String label;
  final String value;
  final Color Function(AppColors) color;
  final String sub;
}

final _unavailableStats = [
  _GlanceStat('Attendance', '—', (c) => c.textDim, 'No official data yet'),
  _GlanceStat('Next exam', '—', (c) => c.textDim, 'No exam schedule published'),
  _GlanceStat('Deadlines', '—', (c) => c.textDim, 'No official data yet'),
];

/// Four numbers a student actually re-checks. Anything else belongs in
/// Academics. "Credits left" is real (from the student's actual record);
/// the other three have no official data source (no attendance system, no
/// published exam schedule, no assignment tracker), so they show an honest
/// "—" rather than a fabricated number — see docs/Architecture.md
/// "Real data".
class GlanceGrid extends ConsumerWidget {
  const GlanceGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final student = ref.watch(currentStudentProvider).valueOrNull;
    final creditsLeft = _GlanceStat(
      'Credits left',
      student == null ? '—' : '${student.creditHoursRemaining} hrs',
      (c) => c.info,
      'toward graduation',
    );
    final stats = [..._unavailableStats, creditsLeft];

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
          for (final stat in stats)
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
