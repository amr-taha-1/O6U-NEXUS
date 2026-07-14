import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/semester.dart';

/// The official record, and a way to hand it to someone. Ports the
/// reference's `Transcript` component (SPECS.transcript) � cumulative GPA
/// sits above the semesters, and export is a single, registrar-sealed
/// button. No backend, so export is simulated.
class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final student = ref.watch(currentStudentProvider);
    final semesters = ref.watch(semestersProvider);

    return AppPushScaffold(
      title: 'Transcript',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cumulative · ${student.creditHoursCompleted} of ${student.creditHoursTotal} hours',
                    style: text.subhead,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(student.cumulativeGpa.toStringAsFixed(2), style: text.monoTitle.copyWith(fontSize: 38)),
                      const SizedBox(width: 8),
                      Text(
                        '+${student.gpaDelta.toStringAsFixed(2)}',
                        style: text.subhead.copyWith(color: colors.success, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('Semesters'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [for (var i = 0; i < semesters.length; i++) _SemesterRow(semester: semesters[i], isFirst: i == 0)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 16, AppSpacing.screenMargin, 0),
            child: AppButton(
              label: 'Export official PDF',
              variant: AppButtonVariant.secondary,
              icon: CupertinoIcons.arrow_down_doc,
              expand: true,
              onPressed: () => AppSnackbar.show(
                context,
                message: 'Export simulated · no backend in this build.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 10, AppSpacing.screenMargin, 0),
            child: Text(
              'Sealed and signed by the registrar. Verifiable by QR for 90 days.',
              textAlign: TextAlign.center,
              style: text.footnote.copyWith(color: colors.textDim, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SemesterRow extends StatelessWidget {
  const _SemesterRow({required this.semester, required this.isFirst});
  final Semester semester;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
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
                Text(semester.label, style: text.bodyEmphasized.copyWith(fontWeight: FontWeight.w500, fontSize: 14.5)),
                const SizedBox(height: 1),
                Text('${semester.creditHours} credit hours', style: text.footnote),
              ],
            ),
          ),
          Text(semester.gpa.toStringAsFixed(2), style: text.monoBody.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
