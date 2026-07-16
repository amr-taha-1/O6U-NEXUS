import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../course_details/application/course_details.dart' show categoryLabel;
import '../../application/campus_dna_provider.dart';

/// An honest "student intelligence profile": strongest/weakest bylaw course
/// category and real GPA trend direction, computed live from the real
/// transcript. See [CampusDnaInsight]'s doc comment for exactly what's
/// deliberately *not* here (best study time, learning style, productivity
/// trends) and why — no activity-tracking data source exists to compute
/// them from honestly.
class CampusDnaScreen extends ConsumerWidget {
  const CampusDnaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dnaAsync = ref.watch(campusDnaProvider);

    return AppPushScaffold(
      title: 'Campus DNA',
      body: dnaAsync.when(
        data: (dna) => _DnaBody(dna: dna),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: StatusPlaceholder.error(message: 'Couldn\'t compute your Campus DNA: $error'),
        ),
      ),
    );
  }
}

class _DnaBody extends StatelessWidget {
  const _DnaBody({required this.dna});
  final CampusDnaInsight dna;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Strongest & Weakest Areas', topPadding: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: dna.strongestCategory == null
              ? const StatusPlaceholder.empty(
                  icon: CupertinoIcons.chart_pie,
                  title: 'Not enough data yet',
                  message: 'Once more graded courses map to bylaw categories, this fills in automatically.',
                )
              : Row(
                  children: [
                    Expanded(
                      child: _CategoryCard(
                        label: 'Strongest',
                        category: categoryLabel(dna.strongestCategory!),
                        gpa: dna.strongestCategoryAvgGpa!,
                        color: colors.success,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (dna.weakestCategory != null)
                      Expanded(
                        child: _CategoryCard(
                          label: 'Weakest',
                          category: categoryLabel(dna.weakestCategory!),
                          gpa: dna.weakestCategoryAvgGpa!,
                          color: colors.warning,
                        ),
                      ),
                  ],
                ),
        ),
        const SectionHeader('Performance Trend'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: dna.gpaTrend.length < 2
                ? Text('Not enough semesters yet to detect a trend.', style: text.footnote.copyWith(color: colors.textDim))
                : Row(
                    children: [
                      GpaSparkline(values: dna.gpaTrend, color: colors.accent, min: 1.0, max: 4.0),
                      const SizedBox(width: 12),
                      Text(dna.trendDirection ?? 'Stable', style: text.bodyEmphasized),
                    ],
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 16, AppSpacing.screenMargin, 0),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: AppRadius.lgRadius,
              color: AppColors.tint(colors.info, 0.08),
              border: Border.all(color: AppColors.tint(colors.info, 0.25), width: 0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.info_circle, size: 16, color: colors.info),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Best study time, learning style, and productivity trends aren\'t shown — this build has no '
                    'activity-tracking data to compute them from honestly, so they\'re left out rather than guessed.',
                    style: text.footnote.copyWith(color: colors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.label, required this.category, required this.gpa, required this.color});
  final String label;
  final String category;
  final double gpa;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(), style: text.caption2.copyWith(color: color, letterSpacing: 0.6)),
          const SizedBox(height: 4),
          Text(category, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
          const SizedBox(height: 2),
          Text('${gpa.toStringAsFixed(2)} avg grade points/hr', style: text.footnote.copyWith(color: context.colors.textMuted)),
        ],
      ),
    );
  }
}
