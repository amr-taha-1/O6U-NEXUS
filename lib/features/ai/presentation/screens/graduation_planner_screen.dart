import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/graduation_step.dart';
import '../../../../shared/domain/student.dart';
import '../../application/graduation_planner_providers.dart';

/// Compresses four years into one legible path with one warning, in Nexus's
/// own voice — "I built this from your transcript," not a static record.
/// Ports the reference's `GradPlanner` (SPECS.gradplan): 96% on-time is a
/// probability, always labelled as one; the bottleneck is the entire point
/// of the screen. A separate, independently-built sibling of Academics'
/// "Graduation Progress" screen (`features/academics/.../graduation_screen.dart`)
/// — a little structural duplication here is expected, not a bug.
class GraduationPlannerScreen extends ConsumerWidget {
  const GraduationPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final steps = ref.watch(aiGraduationStepsProvider);

    return AppPushScaffold(
      title: 'Graduation Planner',
      body: studentAsync.when(
        data: (student) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: _NexusHero(hoursLeft: student.creditHoursRemaining),
            ),
            const SectionHeader('Your path, as Nexus sees it'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                children: [
                  for (var i = 0; i < steps.length; i++)
                    _StepRow(step: steps[i], isLast: i == steps.length - 1, filled: i < 4, lineOn: i < 3),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
              child: _BottleneckCard(),
            ),
          ],
        ),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your record: $error'),
      ),
    );
  }
}

class _NexusHero extends StatelessWidget {
  const _NexusHero({required this.hoursLeft});
  final int hoursLeft;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.tint(colors.accentDeep, 0.24), colors.surface],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.sparkles, size: 15, color: colors.accent),
              const SizedBox(width: 7),
              Text('NEXUS BUILT THIS PLAN', style: text.caption2.copyWith(color: colors.accent, letterSpacing: 0.7)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(CupertinoIcons.flag_fill, size: 22, color: colors.accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('96% on-time', style: text.title3),
                    const SizedBox(height: 2),
                    Text(
                      '$hoursLeft hours left at your current pace',
                      style: text.subhead.copyWith(fontSize: 13.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.isLast, required this.filled, required this.lineOn});
  final GraduationStep step;
  final bool isLast;
  final bool filled;
  final bool lineOn;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? step.accent : null,
                    border: Border.all(color: step.accent, width: 2),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1.5, color: lineOn ? AppColors.tint(colors.success, 0.4) : colors.hairline),
                ),
            ],
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: AppCard(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(step.title, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                          const SizedBox(height: 1),
                          Text(step.subtitle, style: text.footnote),
                        ],
                      ),
                    ),
                    TagChip(label: step.statusLabel, color: step.accent),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottleneckCard extends StatelessWidget {
  const _BottleneckCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: AppRadius.xlRadius,
        color: AppColors.tint(colors.warning, 0.1),
        border: Border.all(color: AppColors.tint(colors.warning, 0.3), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CupertinoIcons.exclamationmark_triangle, size: 17, color: colors.warning),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nexus flagged a bottleneck · CS412', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 3),
                Text(
                  "It's Fall-only and a prerequisite for two courses you still need. I moved it to summer "
                  'in this plan — that alone removes a full semester of delay.',
                  style: text.footnote.copyWith(fontSize: 13.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
