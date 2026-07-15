import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/academics_providers.dart';
import '../../domain/assignment.dart';

/// Not in the design reference — a list of assignments across courses,
/// mirroring `course_details_sheet.dart`'s "Materials" list pattern.
class AssignmentsScreen extends ConsumerWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = ref.watch(assignmentsProvider);

    return AppPushScaffold(
      title: 'Assignments',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Across your courses'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < assignments.length; i++)
                    _AssignmentRow(assignment: assignments[i], isFirst: i == 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignmentRow extends StatelessWidget {
  const _AssignmentRow({required this.assignment, required this.isFirst});
  final Assignment assignment;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final statusColor = switch (assignment.status) {
      AssignmentStatus.notSubmitted => colors.due,
      AssignmentStatus.submitted => colors.info,
      AssignmentStatus.graded => colors.success,
    };

    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        children: [
          Icon(CupertinoIcons.doc_text, size: 16, color: colors.textMuted),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(assignment.title, style: text.body.copyWith(fontSize: 14.5, fontWeight: FontWeight.w500)),
                const SizedBox(height: 1),
                Text(
                  '${assignment.courseCode} · ${assignment.dueLabel}',
                  style: text.caption1.copyWith(color: colors.textMuted, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TagChip(label: assignment.status.label, color: statusColor),
        ],
      ),
    );
  }
}
