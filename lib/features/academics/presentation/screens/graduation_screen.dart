import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/degree_progress/data/degree_progress_repository.dart';
import '../../../../features/degree_progress/domain/degree_progress.dart';

/// The official degree-audit breakdown — how many hours are satisfied in
/// each requirement bucket, and how many remain. Framed as the static
/// record, not the AI-forecast framing that the AI tab's independent
/// Graduation Planner owns (deliberately not sharing code with it — see
/// docs/CHANGELOG.md, Batch E). Real data, read from
/// `assets/data/degree_progress.json`.
class GraduationScreen extends ConsumerWidget {
  const GraduationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(degreeProgressProvider);

    return AppPushScaffold(
      title: 'Degree Progress',
      body: progressAsync.when(
        data: (progress) => _DegreeProgressBody(progress: progress),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your degree progress: $error'),
      ),
    );
  }
}

class _DegreeProgressBody extends StatelessWidget {
  const _DegreeProgressBody({required this.progress});
  final DegreeProgress progress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Column(
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
                      Text('${progress.graduationHoursCompleted} of ${progress.graduationHoursRequired} hours', style: text.title3),
                      const SizedBox(height: 2),
                      Text(
                        '${progress.graduationHoursRemaining} hours remaining · CGPA ${progress.cgpa.toStringAsFixed(2)}',
                        style: text.subhead.copyWith(fontSize: 13.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppProgressBar(value: progress.overallProgress, color: colors.info, height: 8),
        ),
        const SectionHeader('Requirement categories'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Column(
            children: [for (final category in progress.categories) _CategoryCard(category: category)],
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});
  final DegreeRequirementCategory category;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final done = category.remainingHours == 0;
    final accent = done ? colors.success : colors.warning;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(category.name, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                ),
                TagChip(
                  label: done ? 'Complete' : '${category.remainingHours} hrs left',
                  color: accent,
                ),
              ],
            ),
            const SizedBox(height: 9),
            AppProgressBar(value: category.progress, color: accent, height: 6),
            const SizedBox(height: 6),
            Text(
              '${category.completedHours} of ${category.requiredHours} hours completed',
              style: text.footnote,
            ),
          ],
        ),
      ),
    );
  }
}
