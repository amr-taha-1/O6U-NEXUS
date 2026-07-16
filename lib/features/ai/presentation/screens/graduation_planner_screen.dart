import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/graduation_step.dart';
import '../../../../shared/domain/student.dart';
import '../../../curriculum/application/curriculum_engine.dart';
import '../../application/graduation_planner_providers.dart';

/// Compresses the real degree record into one legible path, in Nexus's own
/// voice — "I built this from your transcript," not an independent
/// fabricated record. A sibling of Academics' "Graduation Progress" screen
/// (`features/academics/.../graduation_screen.dart`) that reads the same
/// real `DegreeProgress`/eligibility data, just narrated differently — see
/// `graduation_planner_providers.dart`.
class GraduationPlannerScreen extends ConsumerWidget {
  const GraduationPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final stepsAsync = ref.watch(aiGraduationStepsProvider);
    final estimatedSemestersAsync = ref.watch(estimatedRemainingSemestersProvider);
    final lockedAsync = ref.watch(lockedCoursesProvider);

    return AppPushScaffold(
      title: 'Graduation Planner',
      body: studentAsync.when(
        data: (student) => stepsAsync.when(
          data: (steps) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: _NexusHero(
                  hoursLeft: student.creditHoursRemaining,
                  estimatedSemesters: estimatedSemestersAsync.valueOrNull,
                ),
              ),
              const SectionHeader('Your path, as Nexus sees it'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: Column(
                  children: [
                    for (var i = 0; i < steps.length; i++)
                      _StepRow(
                        step: steps[i],
                        isLast: i == steps.length - 1,
                        filled: steps[i].status == GraduationStepStatus.done,
                        lineOn: i > 0 && steps[i - 1].status == GraduationStepStatus.done,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
                child: _BottleneckCard(locked: lockedAsync.valueOrNull ?? const []),
              ),
            ],
          ),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: SkeletonListTile(isFirst: true),
          ),
          error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your record: $error'),
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
  const _NexusHero({required this.hoursLeft, required this.estimatedSemesters});
  final int hoursLeft;
  final int? estimatedSemesters;

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
                    Text(
                      estimatedSemesters == null
                          ? '$hoursLeft hours left'
                          : '~$estimatedSemesters ${estimatedSemesters == 1 ? 'semester' : 'semesters'} left',
                      style: text.title3,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$hoursLeft hours left at your own historical pace — an estimate, not a promise',
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
  const _BottleneckCard({required this.locked});
  final List<CourseEligibility> locked;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    if (locked.isEmpty) {
      return const SizedBox.shrink();
    }

    // The real course blocking the most other courses right now — a
    // genuine bottleneck, not a fabricated one.
    final blockedCounts = <String, int>{};
    for (final entry in locked) {
      for (final missing in entry.missingPrerequisites) {
        blockedCounts[missing.code] = (blockedCounts[missing.code] ?? 0) + 1;
      }
    }
    if (blockedCounts.isEmpty) {
      return const SizedBox.shrink();
    }
    final bottleneckCode = blockedCounts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    final bottleneckCourse = locked
        .expand((e) => e.missingPrerequisites)
        .firstWhere((c) => c.code == bottleneckCode);
    final blockedCount = blockedCounts[bottleneckCode]!;

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
                Text('Real bottleneck · ${bottleneckCourse.name} (${bottleneckCourse.code})', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 3),
                Text(
                  'Not yet completed, and it gates $blockedCount other course${blockedCount == 1 ? '' : 's'} still '
                  'locked on your real prerequisite chain. Clearing it first unlocks the most follow-on courses.',
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
