import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/data/grade_scale_repository.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/course.dart';
import '../../../../shared/domain/grade_band.dart';
import '../../application/gpa_simulator_controller.dart';

/// Lets a student feel the consequence of a grade before the exam. Ports the
/// reference's `GpaSim` (SPECS.gpasim): the projected number is the hero and
/// recomputes live — no Calculate button, ever; grades are segmented pickers
/// because a grade is discrete; Nexus ends the screen naming the single
/// highest-leverage move, so it ends in advice, not arithmetic.
class GpaSimulatorScreen extends ConsumerWidget {
  const GpaSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(coursesProvider);
    final studentAsync = ref.watch(currentStudentProvider);
    final gradeScaleAsync = ref.watch(gradeScaleProvider);
    final picks = ref.watch(gpaSimulatorControllerProvider);

    return AppPushScaffold(
      title: 'GPA Simulator',
      body: studentAsync.when(
        data: (student) => gradeScaleAsync.when(
          data: (gradeScale) {
            final sim = ref.watch(gpaSimulationProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: _ProjectedHero(projected: sim.projected, delta: sim.delta, current: student.cumulativeGpa),
                ),
                const SectionHeader('Move a grade, watch it move'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: Column(
                    children: [
                      for (final course in courses)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _CourseGradeCard(
                            course: course,
                            gradeScale: gradeScale,
                            picked: picks[course.code] ?? course.grade,
                            onPick: (grade) => ref.read(gpaSimulatorControllerProvider.notifier).pick(course.code, grade),
                          ),
                        ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, 4, AppSpacing.screenMargin, 0),
                  child: _InsightCard(),
                ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: SkeletonListTile(isFirst: true),
          ),
          error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load the grading scale: $error'),
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

class _ProjectedHero extends StatelessWidget {
  const _ProjectedHero({required this.projected, required this.delta, required this.current});
  final double projected;
  final double delta;
  final double current;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final positive = delta >= 0;
    final deltaColor = positive ? colors.success : colors.danger;

    return AppCard(
      padding: const EdgeInsets.all(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.tint(colors.accentDeep, 0.25), colors.surface],
      ),
      child: Column(
        children: [
          Text(
            'PROJECTED CUMULATIVE',
            style: text.caption2.copyWith(color: colors.accent, letterSpacing: 0.8),
          ),
          const SizedBox(height: 6),
          Text(projected.toStringAsFixed(2), style: text.monoDisplay),
          const SizedBox(height: 8),
          Text(
            '${positive ? '+' : '−'}${delta.abs().toStringAsFixed(2)} from ${current.toStringAsFixed(2)}',
            style: text.bodyEmphasized.copyWith(color: deltaColor, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _CourseGradeCard extends StatelessWidget {
  const _CourseGradeCard({required this.course, required this.gradeScale, required this.picked, required this.onPick});
  final Course course;
  final List<GradeBand> gradeScale;
  final String picked;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    final grades = [for (final band in gradeScale) band.letter];

    return AppCard(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(course.code, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
              Text('${course.creditHours} hrs', style: text.footnote),
            ],
          ),
          const SizedBox(height: 9),
          // A `Wrap`, not a `Row` of `Expanded`s: the real grading scale has
          // 11 bands (A through F), too many to fit one row legibly.
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final grade in grades)
                SizedBox(
                  width: 50,
                  child: _GradeButton(label: grade, selected: grade == picked, onTap: () => onPick(grade)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradeButton extends StatelessWidget {
  const _GradeButton({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        constraints: const BoxConstraints(minHeight: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? colors.accentDeep : colors.textPrimary.withValues(alpha: 0.05),
          borderRadius: AppRadius.mdRadius,
          border: selected ? null : Border.all(color: colors.hairline, width: 0.5),
        ),
        child: Text(
          label,
          style: text.monoBody.copyWith(fontSize: 12.5, color: selected ? colors.onAccent : colors.textMuted),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      dashed: true,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CupertinoIcons.sparkles, size: 16, color: colors.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: text.footnote.copyWith(fontSize: 13.5, height: 1.45),
                children: [
                  const TextSpan(text: 'Pulling MA201 from C+ to B is worth '),
                  TextSpan(
                    text: '+0.04',
                    style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(
                    text: ' on your cumulative — the single largest move available to you this term.',
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
