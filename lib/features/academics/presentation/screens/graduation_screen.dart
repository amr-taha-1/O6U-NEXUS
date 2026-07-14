import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/graduation_step.dart';
import '../../../../shared/domain/student.dart';
import '../../application/academics_providers.dart';

/// Compresses four years into one legible path with one warning. Ports the
/// reference's `GradPlanner` component (SPECS.gradplan) � framed here as
/// the static "Graduation Progress" record, not the AI chat framing that a
/// separate in-progress feature owns.
class GraduationScreen extends ConsumerWidget {
  const GraduationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final student = ref.watch(currentStudentProvider);
    final steps = ref.watch(graduationStepsProvider);

    return AppPushScaffold(
      title: 'Graduation Progress',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.tint(colors.infoDeep, 0.22), colors.surface],
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.flag_fill, size: 22, color: colors.info),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('96% on-time', style: text.title3),
                        const SizedBox(height: 2),
                        Text(
                          '${student.creditHoursRemaining} hours left · graduate ${student.expectedGraduation}',
                          style: text.subhead.copyWith(fontSize: 13.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Your path'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (var i = 0; i < steps.length; i++)
                  _StepRow(step: steps[i], isLast: i == steps.length - 1, filled: i < 4, lineOn: i < 3),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
            child: const _BottleneckCard(),
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
                Text('Predicted bottleneck · CS412', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 3),
                Text(
                  'Offered in Fall only, and a prerequisite for two remaining courses. Taking it this summer removes a full semester of delay.',
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
