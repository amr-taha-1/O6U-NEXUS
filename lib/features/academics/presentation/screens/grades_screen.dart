import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/course.dart';
import '../../application/academics_providers.dart';

/// Semester and cumulative GPA, side by side — nothing else. Ports the
/// reference's `Grades` component (SPECS.grades). Also where a student
/// checks their GPA in general; there's no separate GPA screen.
class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final courses = ref.watch(coursesProvider);
    final student = ref.watch(currentStudentProvider);
    final semesterGpa = ref.watch(semesterGpaProvider);

    return AppPushScaffold(
      title: 'Grades',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Semester GPA', style: text.subhead),
                      Text(semesterGpa.toStringAsFixed(2), style: text.monoTitle.copyWith(fontSize: 36)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Cumulative', style: text.subhead),
                      Text(
                        student.cumulativeGpa.toStringAsFixed(2),
                        style: text.title2.copyWith(color: colors.accent, fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('This semester'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [for (var i = 0; i < courses.length; i++) _GradeRow(course: courses[i], isFirst: i == 0)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradeRow extends StatelessWidget {
  const _GradeRow({required this.course, required this.isFirst});
  final Course course;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final chipColor = course.grade.startsWith('A')
        ? colors.success
        : course.grade.startsWith('C')
            ? colors.warning
            : colors.info;

    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                const SizedBox(height: 1),
                Text('${course.code} Â· ${course.creditHours} credit hours', style: text.footnote),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: AppColors.tint(chipColor, 0.12), borderRadius: AppRadius.smRadius),
            child: Text(course.grade, style: text.monoBody.copyWith(color: chipColor, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
