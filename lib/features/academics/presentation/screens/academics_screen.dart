import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/schedule/application/schedule_providers.dart';
import '../../../../features/schedule/domain/schedule_session.dart';
import '../../../../features/transcript/application/transcript_enrichment.dart';
import '../../../../features/transcript/data/transcript_repository.dart';
import '../../../../features/transcript/domain/transcript_course.dart';
import '../../../../features/transcript/presentation/grade_colors.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/semester.dart';
import '../../../../shared/domain/student.dart';

/// Makes the university's academic record readable in a glance, and honest
/// about risk. The Academics tab root.
class AcademicsScreen extends ConsumerWidget {
  const AcademicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final gpaTrend = ref.watch(semesterGpaTrendProvider).valueOrNull ?? const [];
    final nextSession = ref.watch(nextSessionProvider).valueOrNull;
    // The student's latest active semester — transcript.json is
    // chronological, so the last entry is always the most recent, whatever
    // it happens to be. Never a hardcoded semester.
    final latestSemester = ref.watch(enrichedTranscriptProvider).valueOrNull?.lastOrNull;

    return LargeTitleScaffold(
      title: 'Academics',
      body: studentAsync.when(
        data: (student) => _AcademicsBody(
          student: student,
          latestSemester: latestSemester,
          gpaTrend: gpaTrend,
          nextSession: nextSession,
        ),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your academic record: $error'),
      ),
    );
  }
}

class _AcademicsBody extends StatelessWidget {
  const _AcademicsBody({
    required this.student,
    required this.latestSemester,
    required this.gpaTrend,
    required this.nextSession,
  });
  final Student student;
  final Semester? latestSemester;
  final List<double> gpaTrend;
  final ScheduleSession? nextSession;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final positive = student.gpaDelta >= 0;
    final deltaColor = positive ? colors.success : colors.danger;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cumulative GPA', style: text.subhead.copyWith(fontWeight: FontWeight.w500)),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(student.cumulativeGpa.toStringAsFixed(2), style: text.monoTitle),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  Icon(
                                    positive ? CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_right,
                                    size: 13,
                                    color: deltaColor,
                                  ),
                                  Text(
                                    '${positive ? '+' : '−'}${student.gpaDelta.abs().toStringAsFixed(2)}',
                                    style: text.subhead.copyWith(color: deltaColor, fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text('vs. last semester', style: text.caption1.copyWith(color: colors.textDim, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    if (gpaTrend.isNotEmpty)
                      GpaSparkline(
                        values: gpaTrend,
                        color: colors.accent,
                        min: 1.0,
                        max: 4.0,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                AppProgressBar(value: student.degreeProgress, color: colors.accent, height: 6),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level ${student.level} · ${student.creditHoursCompleted} of ${student.creditHoursTotal} hours',
                      style: text.footnote,
                    ),
                    Text(
                      '${student.creditHoursRemaining} hrs left',
                      style: text.monoSmall.copyWith(color: colors.accent, fontSize: 12.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (latestSemester != null) ...[
          SectionHeader(latestSemester!.label),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < latestSemester!.courses.length; i++)
                    _CourseRow(course: latestSemester!.courses[i], isFirst: i == 0),
                ],
              ),
            ),
          ),
        ],
        const SectionHeader('Records'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                NavRowCard(
                  isFirst: true,
                  icon: CupertinoIcons.calendar,
                  iconColor: colors.info,
                  title: 'Schedule',
                  subtitle: nextSession == null
                      ? 'This week\'s classes'
                      : 'Next: ${nextSession!.courseName} · ${nextSession!.day.label}',
                  onTap: () => context.push(AppRoutes.academicsSchedule),
                ),
                NavRowCard(
                  icon: CupertinoIcons.timer,
                  iconColor: colors.due,
                  title: 'Exam Schedule',
                  subtitle: 'No official exam schedule published yet',
                  onTap: () => context.push(AppRoutes.academicsExams),
                ),
                NavRowCard(
                  icon: CupertinoIcons.chart_bar,
                  iconColor: colors.accent,
                  title: 'Grades',
                  subtitle: latestSemester == null
                      ? '${student.cumulativeGpa.toStringAsFixed(2)} CGPA'
                      : '${latestSemester!.label} GPA ${latestSemester!.gpa.toStringAsFixed(2)}',
                  onTap: () => context.push(AppRoutes.academicsGrades),
                ),
                NavRowCard(
                  icon: CupertinoIcons.doc_checkmark,
                  iconColor: colors.success,
                  title: 'Assignments',
                  subtitle: 'No official assignment data available yet',
                  onTap: () => context.push(AppRoutes.academicsAssignments),
                ),
                NavRowCard(
                  icon: CupertinoIcons.gauge,
                  iconColor: colors.success,
                  title: 'Attendance',
                  subtitle: 'No official attendance data available yet',
                  onTap: () => context.push(AppRoutes.academicsAttendance),
                ),
                NavRowCard(
                  icon: CupertinoIcons.doc_text,
                  iconColor: colors.info,
                  title: 'Transcript',
                  subtitle: '${student.cumulativeGpa.toStringAsFixed(2)} CGPA · official record',
                  onTap: () => context.push(AppRoutes.academicsTranscript),
                ),
                NavRowCard(
                  icon: CupertinoIcons.chart_bar_alt_fill,
                  iconColor: colors.due,
                  title: 'Academic Analytics',
                  subtitle: 'Trends, grade mix, repeated courses',
                  onTap: () => context.push(AppRoutes.academicsAnalytics),
                ),
                NavRowCard(
                  icon: CupertinoIcons.flag,
                  iconColor: colors.warning,
                  title: 'Degree Progress',
                  subtitle: '${student.creditHoursRemaining} hours remaining',
                  onTap: () => context.push(AppRoutes.academicsGraduation),
                ),
                NavRowCard(
                  icon: CupertinoIcons.square_stack_3d_up,
                  iconColor: colors.info,
                  title: 'Course Catalog',
                  subtitle: 'What can I register next?',
                  onTap: () => context.push(AppRoutes.academicsCatalog),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CourseRow extends StatelessWidget {
  const _CourseRow({required this.course, required this.isFirst});
  final TranscriptCourse course;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = gradeColor(colors, course.grade);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(AppRoutes.courseDetailsPath(course.code)),
      child: Container(
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
                  Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 15.5)),
                  const SizedBox(height: 1),
                  Text(
                    '${course.code}${course.creditHours != null ? ' · ${course.creditHours} credit hours' : ''}',
                    style: text.footnote.copyWith(color: colors.textMuted),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: AppColors.tint(color, 0.14), borderRadius: AppRadius.smRadius),
              child: Text(course.grade, style: text.monoBody.copyWith(color: color, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
