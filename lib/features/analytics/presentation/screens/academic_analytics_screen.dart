import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/degree_progress/data/degree_progress_repository.dart';
import '../../../../features/degree_progress/domain/degree_progress.dart';
import '../../../../features/transcript/data/transcript_repository.dart';
import '../../../../features/transcript/presentation/grade_colors.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/semester.dart';
import '../../../../shared/domain/student.dart';
import '../../application/analytics_providers.dart';

/// CGPA, the semester-GPA trend, hours completed/remaining, grade
/// distribution, repeated courses, and progress toward graduation — all
/// derived live from the real transcript and degree-progress data, so this
/// view can never drift out of sync with Transcript or Degree Progress.
class AcademicAnalyticsScreen extends ConsumerWidget {
  const AcademicAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final transcriptAsync = ref.watch(transcriptProvider);
    final progressAsync = ref.watch(degreeProgressProvider);

    return AppPushScaffold(
      title: 'Academic Analytics',
      body: studentAsync.when(
        data: (student) => transcriptAsync.when(
          data: (semesters) => progressAsync.when(
            data: (progress) => _AnalyticsBody(student: student, semesters: semesters, progress: progress),
            loading: () => const _AnalyticsLoading(),
            error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load degree progress: $error'),
          ),
          loading: () => const _AnalyticsLoading(),
          error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your transcript: $error'),
        ),
        loading: () => const _AnalyticsLoading(),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your record: $error'),
      ),
    );
  }
}

class _AnalyticsLoading extends StatelessWidget {
  const _AnalyticsLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: Column(
        children: [
          SkeletonBox(height: 120, borderRadius: BorderRadius.all(Radius.circular(18))),
          SizedBox(height: 12),
          SkeletonListTile(isFirst: true),
          SkeletonListTile(),
        ],
      ),
    );
  }
}

class _AnalyticsBody extends ConsumerWidget {
  const _AnalyticsBody({required this.student, required this.semesters, required this.progress});
  final Student student;
  final List<Semester> semesters;
  final DegreeProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final gradeBands = ref.watch(gradeDistributionProvider).valueOrNull ?? const [];
    final totalCourses = ref.watch(totalGradedCoursesProvider).valueOrNull ?? 0;
    final repeatedCourses = ref.watch(repeatedCoursesProvider).valueOrNull ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Row(
            children: [
              Expanded(
                child: _MetricCard(label: 'Cumulative GPA', value: student.cumulativeGpa.toStringAsFixed(2), color: colors.accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(label: 'Hours completed', value: '${student.creditHoursCompleted}', color: colors.info),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(label: 'Hours remaining', value: '${student.creditHoursRemaining}', color: colors.warning),
              ),
            ],
          ),
        ).animate().fadeIn(duration: AppMotion.entrance),
        const SectionHeader('Semester GPA trend'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: _TrendCard(semesters: semesters),
        ).animate().fadeIn(duration: AppMotion.entrance).slideY(begin: 0.06, end: 0),
        const SectionHeader('Progress toward graduation'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${progress.graduationHoursCompleted} of ${progress.graduationHoursRequired} hours', style: text.bodyEmphasized),
                    Text('${(progress.overallProgress * 100).round()}%', style: text.monoBody.copyWith(color: colors.info)),
                  ],
                ),
                const SizedBox(height: 9),
                AppProgressBar(value: progress.overallProgress, color: colors.info, height: 8),
              ],
            ),
          ),
        ).animate().fadeIn(duration: AppMotion.entrance),
        const SectionHeader('Grade distribution'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < gradeBands.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: i == gradeBands.length - 1 ? 0 : 10),
                    child: _GradeBandRow(
                      label: gradeBands[i].label,
                      count: gradeBands[i].count,
                      total: totalCourses,
                      delayMs: i * 80,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SectionHeader('Repeated courses'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: repeatedCourses.isEmpty
              ? const AppCard(
                  child: StatusPlaceholder.empty(
                    icon: CupertinoIcons.checkmark_seal,
                    title: 'No repeated courses',
                    message: 'Every course on record was completed on the first attempt.',
                  ),
                )
              : Column(
                  children: [for (final course in repeatedCourses) _RepeatedCourseRow(course: course)],
                ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: text.footnote.copyWith(fontSize: 11)),
          const SizedBox(height: 3),
          Text(value, style: text.title2.copyWith(color: color, fontSize: 20)),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.semesters});
  final List<Semester> semesters;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final gpas = [for (final s in semesters) s.gpa];
    final best = gpas.isEmpty ? 0.0 : gpas.reduce((a, b) => a > b ? a : b);
    final worst = gpas.isEmpty ? 0.0 : gpas.reduce((a, b) => a < b ? a : b);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: GpaSparkline(values: gpas, color: colors.accent, min: 1.0, max: 4.0, width: 260, height: 80),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TrendStat(label: 'Best', value: best.toStringAsFixed(2), color: colors.success),
              _TrendStat(label: 'Lowest', value: worst.toStringAsFixed(2), color: colors.danger),
              _TrendStat(label: 'Semesters', value: '${semesters.length}', color: colors.textMuted),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final semester in semesters)
                TagChip(label: '${_shortLabel(semester.label)} · ${semester.gpa.toStringAsFixed(2)}', color: colors.accent),
            ],
          ),
        ],
      ),
    );
  }

  /// "Fall 2023/2024" → "Fa23": season abbreviation + the last two digits
  /// of the range's first year.
  String _shortLabel(String label) {
    final parts = label.split(' ');
    if (parts.length < 2) return label;
    final firstYear = parts[1].split('/').first;
    final yearSuffix = firstYear.length >= 2 ? firstYear.substring(firstYear.length - 2) : firstYear;
    return '${parts[0].substring(0, 2)}$yearSuffix';
  }
}

class _TrendStat extends StatelessWidget {
  const _TrendStat({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Column(
      children: [
        Text(value, style: text.monoBody.copyWith(color: color, fontSize: 15)),
        Text(label, style: text.caption1.copyWith(color: context.colors.textDim, fontWeight: FontWeight.w400)),
      ],
    );
  }
}

class _GradeBandRow extends StatelessWidget {
  const _GradeBandRow({required this.label, required this.count, required this.total, required this.delayMs});
  final String label;
  final int count;
  final int total;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = _bandColor(colors, label);
    final fraction = total == 0 ? 0.0 : count / total;

    return Row(
      children: [
        SizedBox(width: 46, child: Text(label, style: text.bodyEmphasized.copyWith(fontSize: 13.5))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fraction,
                child: Container(height: 10, color: color),
              ),
            ),
          ).animate(delay: delayMs.ms).scaleX(begin: 0, end: 1, curve: AppMotion.standardCurve, duration: 500.ms, alignment: Alignment.centerLeft),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 22,
          child: Text('$count', textAlign: TextAlign.right, style: text.monoSmall.copyWith(fontSize: 12, color: color)),
        ),
      ],
    );
  }

  Color _bandColor(AppColors colors, String label) {
    switch (label) {
      case 'A':
        return colors.success;
      case 'B':
        return colors.info;
      case 'C':
        return colors.warning;
      case 'D':
        return colors.danger;
      case 'F':
        return kFailDeepRed;
      case 'W':
        return colors.textDim;
      default:
        return colors.textMuted;
    }
  }
}

class _RepeatedCourseRow extends StatelessWidget {
  const _RepeatedCourseRow({required this.course});
  final RepeatedCourse course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
            const SizedBox(height: 1),
            Text(course.code, style: text.footnote),
            const SizedBox(height: 9),
            Row(
              children: [
                for (var i = 0; i < course.attempts.length; i++) ...[
                  if (i > 0) Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Icon(CupertinoIcons.arrow_right, size: 12, color: colors.textDim)),
                  TagChip(label: course.attempts[i], color: gradeColor(colors, course.attempts[i])),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
