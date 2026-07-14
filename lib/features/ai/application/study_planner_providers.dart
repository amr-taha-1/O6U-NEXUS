import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../domain/study_block.dart';

/// Turns free hours into a plan the student didn't have to make. Static
/// dummy grid — ports the reference's `StudyPlanner` `blocks` array
/// (SPECS.planner) verbatim; the reference's own planner is static too.
final studyBlocksProvider = Provider<List<StudyBlock>>((ref) {
  const lec = StudyBlockType.lecture;
  const ai = StudyBlockType.aiPlaced;
  const exam = StudyBlockType.exam;
  return const [
    StudyBlock(day: 0, row: 0, label: 'CS402', type: lec),
    StudyBlock(day: 1, row: 0, label: 'MA201', type: lec),
    StudyBlock(day: 3, row: 0, label: 'Practice', type: ai),
    StudyBlock(day: 5, row: 0, label: 'Weak', type: ai),
    StudyBlock(day: 2, row: 1, label: 'CS310', type: lec),
    StudyBlock(day: 4, row: 1, label: 'Mock', type: ai),
    StudyBlock(day: 6, row: 1, label: 'EXAM', type: exam),
    StudyBlock(day: 0, row: 2, label: 'Revise', type: ai),
    StudyBlock(day: 1, row: 2, label: 'Algo', type: ai),
    StudyBlock(day: 3, row: 2, label: 'PH101', type: lec),
    StudyBlock(day: 5, row: 2, label: 'Cards', type: ai),
  ];
});

/// One of the three "why Nexus placed these" cards under the week grid.
class PlannerInsight {
  const PlannerInsight({required this.title, required this.body, required this.color});
  final String title;
  final String body;
  final Color color;
}

final plannerInsightsProvider = Provider<List<PlannerInsight>>((ref) {
  final c = AppColors.dark;
  return [
    PlannerInsight(
      title: 'Reads your real gaps',
      body: 'Free hours between lectures become study blocks.',
      color: c.success,
    ),
    PlannerInsight(
      title: 'Prioritises weakness',
      body: "MA201 gets the most hours — it's dragging your GPA.",
      color: c.warning,
    ),
    PlannerInsight(
      title: 'Re-plans automatically',
      body: 'A moved deadline reshuffles the whole week.',
      color: c.info,
    ),
  ];
});
