import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/academics_providers.dart';
import '../../domain/exam.dart';

/// Not in the design reference — designed to match the Records list on
/// Academics and the "Next exam · 3 days" stat already shown on Home.
class ExamScheduleScreen extends ConsumerWidget {
  const ExamScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exams = ref.watch(examsProvider);

    return AppPushScaffold(
      title: 'Exam Schedule',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Upcoming'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final exam in exams) Padding(padding: const EdgeInsets.only(bottom: 10), child: _ExamCard(exam: exam)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  const _ExamCard({required this.exam});
  final Exam exam;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(exam.courseName, style: text.bodyEmphasized.copyWith(fontSize: 15.5)),
                    const SizedBox(height: 1),
                    Text(exam.courseCode, style: text.footnote),
                  ],
                ),
              ),
              TagChip(label: exam.type, color: colors.info),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(CupertinoIcons.calendar, size: 14, color: colors.textDim),
              const SizedBox(width: 6),
              Expanded(child: Text('${exam.date} · ${exam.time}', style: text.subhead.copyWith(fontSize: 13))),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(CupertinoIcons.location, size: 14, color: colors.textDim),
              const SizedBox(width: 6),
              Expanded(child: Text(exam.room, style: text.subhead.copyWith(fontSize: 13))),
            ],
          ),
          const SizedBox(height: 10),
          TagChip(label: exam.countdown, color: colors.due),
        ],
      ),
    );
  }
}
