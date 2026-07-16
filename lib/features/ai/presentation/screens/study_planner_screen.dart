import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/study_planner_providers.dart';
import '../../domain/study_block.dart';

/// Turns free hours into a plan the student didn't have to make. Ports the
/// reference's `StudyPlanner` (SPECS.planner): "0 conflicts" is the trust
/// claim and must be visible before the grid; AI blocks are purple, lectures
/// grey, exams red — one glance tells you what the machine added.
class StudyPlannerScreen extends ConsumerWidget {
  const StudyPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = context.textStyles;
    final colors = context.colors;
    final blocksAsync = ref.watch(studyBlocksProvider);
    final blocks = blocksAsync.valueOrNull ?? const [];
    final insights = ref.watch(plannerInsightsProvider);

    return AppPushScaffold(
      title: 'Study Planner',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('This week · your real schedule', style: text.title3.copyWith(fontSize: 19)),
                      const SizedBox(height: 2),
                      Text('${blocks.length} real lecture/lab session${blocks.length == 1 ? '' : 's'}', style: text.subhead),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.sparkles, size: 19, color: colors.accent),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: _WeekGrid(blocks: blocks),
          ),
          const SectionHeader('Why Nexus placed these'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final insight in insights)
                  Padding(padding: const EdgeInsets.only(bottom: 9), child: _InsightRow(insight: insight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekGrid extends StatelessWidget {
  const _WeekGrid({required this.blocks});
  final List<StudyBlock> blocks;

  static const _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              for (final d in _days)
                Expanded(
                  child: Center(child: Text(d, style: text.monoMicro.copyWith(fontSize: 9.5, letterSpacing: 0.4))),
                ),
            ],
          ),
          const SizedBox(height: 6),
          for (var row = 0; row < 3; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  for (var day = 0; day < 7; day++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: day == 6 ? 0 : 4),
                        child: _BlockCell(block: _find(day, row)),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 14,
            alignment: WrapAlignment.center,
            children: [
              _LegendItem(label: 'Lectures', color: colors.textPrimary.withValues(alpha: 0.28)),
              _LegendItem(label: 'AI block', color: colors.accentDeep),
              _LegendItem(label: 'Exam', color: colors.danger),
            ],
          ),
        ],
      ),
    );
  }

  StudyBlock? _find(int day, int row) {
    for (final b in blocks) {
      if (b.day == day && b.row == row) return b;
    }
    return null;
  }
}

class _BlockCell extends StatelessWidget {
  const _BlockCell({required this.block});
  final StudyBlock? block;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = switch (block?.type) {
      StudyBlockType.lecture => colors.textPrimary.withValues(alpha: 0.28),
      StudyBlockType.aiPlaced => colors.accentDeep,
      StudyBlockType.exam => colors.danger,
      null => null,
    };

    return Container(
      height: 58,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color ?? colors.textPrimary.withValues(alpha: 0.035),
        borderRadius: AppRadius.smRadius,
        border: color == null ? Border.all(color: colors.hairline, width: 0.5) : null,
      ),
      child: block == null
          ? null
          : Text(
              block!.label,
              textAlign: TextAlign.center,
              style: text.caption1.copyWith(fontSize: 9.5, color: colors.onAccent),
            ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: text.footnote.copyWith(fontSize: 11.5)),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({required this.insight});
  final PlannerInsight insight;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return AppCard(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(insight.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5, color: insight.color)),
          const SizedBox(height: 2),
          Text(insight.body, style: text.footnote.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
