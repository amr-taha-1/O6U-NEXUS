import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/transcript/application/transcript_enrichment.dart';
import '../../../../features/transcript/data/transcript_repository.dart';
import '../../../../features/transcript/domain/transcript_course.dart';
import '../../../../features/transcript/presentation/grade_colors.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/semester.dart';
import '../../../../shared/domain/student.dart';

/// The official record, and a way to hand it to someone. Ports the
/// reference's `Transcript` component (SPECS.transcript) — cumulative GPA
/// sits above the semesters, and export is a single, registrar-sealed
/// button. No backend, so export is simulated. Real data, read from
/// `assets/data/{student,transcript}.json` exactly as it would be read from
/// an official O6U API once one exists. Per-course hours/points are
/// backfilled from the bylaw + grading scale where the raw transcript
/// doesn't carry them directly — see `enrichedTranscriptProvider`.
class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final transcriptAsync = ref.watch(enrichedTranscriptProvider);
    final transferredCreditsAsync = ref.watch(transferredCreditsProvider);

    return AppPushScaffold(
      title: 'Transcript',
      body: studentAsync.when(
        data: (student) => transcriptAsync.when(
          data: (semesters) => transferredCreditsAsync.when(
            data: (transferredCredits) => _TranscriptBody(
              student: student,
              semesters: semesters,
              transferredCredits: transferredCredits,
            ),
            loading: () => const _TranscriptLoading(),
            error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your transcript: $error'),
          ),
          loading: () => const _TranscriptLoading(),
          error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your transcript: $error'),
        ),
        loading: () => const _TranscriptLoading(),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your record: $error'),
      ),
    );
  }
}

class _TranscriptLoading extends StatelessWidget {
  const _TranscriptLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: Column(
        children: [
          SkeletonBox(height: 90, borderRadius: BorderRadius.all(Radius.circular(18))),
          SizedBox(height: 12),
          SkeletonListTile(isFirst: true),
          SkeletonListTile(),
          SkeletonListTile(),
        ],
      ),
    );
  }
}

class _TranscriptBody extends StatelessWidget {
  const _TranscriptBody({required this.student, required this.semesters, required this.transferredCredits});
  final Student student;
  final List<Semester> semesters;
  final List<TranscriptCourse> transferredCredits;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final positive = student.gpaDelta >= 0;

    return Column(
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
                      '${positive ? '+' : '−'}${student.gpaDelta.abs().toStringAsFixed(2)} vs. last semester',
                      style: text.subhead.copyWith(
                        color: positive ? colors.success : colors.danger,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (transferredCredits.isNotEmpty) ...[
          const SectionHeader('Transferred Credits'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < transferredCredits.length; i++)
                    _CourseTile(course: transferredCredits[i], isFirst: i == 0),
                ],
              ),
            ),
          ),
        ],
        const SectionHeader('Semesters'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Column(
            children: [for (final semester in semesters.reversed) _SemesterCard(semester: semester)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
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
    );
  }
}

class _SemesterCard extends StatelessWidget {
  const _SemesterCard({required this.semester});
  final Semester semester;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.hairline, width: 0.5))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(semester.label, style: text.bodyEmphasized.copyWith(fontSize: 15.5)),
                        const SizedBox(height: 1),
                        Text(
                          '${semester.creditHours} hours · ${semester.points.toStringAsFixed(1)} points',
                          style: text.footnote,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.14), borderRadius: AppRadius.smRadius),
                    child: Text(
                      'GPA ${semester.gpa.toStringAsFixed(2)}',
                      style: text.monoBody.copyWith(color: colors.accent, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            for (var i = 0; i < semester.courses.length; i++)
              _CourseTile(course: semester.courses[i], isFirst: i == 0),
          ],
        ),
      ),
    );
  }
}

class _CourseTile extends StatelessWidget {
  const _CourseTile({required this.course, required this.isFirst});
  final TranscriptCourse course;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = gradeColor(colors, course.grade);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(course.name, style: text.body.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 1),
                Text(course.code, style: text.caption1.copyWith(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Expanded(
            child: Text(
              course.creditHours?.toString() ?? '—',
              textAlign: TextAlign.center,
              style: text.footnote.copyWith(color: colors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              course.points?.toStringAsFixed(1) ?? '—',
              textAlign: TextAlign.center,
              style: text.monoSmall.copyWith(fontSize: 12, color: colors.textMuted),
            ),
          ),
          SizedBox(
            width: 44,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.tint(color, 0.14), borderRadius: AppRadius.smRadius),
              child: Text(course.grade, style: text.monoBody.copyWith(color: color, fontSize: 12.5)),
            ),
          ),
        ],
      ),
    );
  }
}
