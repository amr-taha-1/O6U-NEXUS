import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/schedule/application/schedule_providers.dart';
import '../../../../features/schedule/domain/schedule_session.dart';
import '../../../../features/transcript/data/transcript_repository.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/course.dart';
import '../../../../shared/domain/student.dart';
import '../widgets/course_details_sheet.dart';

/// Makes the university's academic record readable in a glance, and honest
/// about risk. The Academics tab root.
class AcademicsScreen extends ConsumerWidget {
  const AcademicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final courses = ref.watch(coursesProvider);
    final gpaTrend = ref.watch(semesterGpaTrendProvider).valueOrNull ?? const [];
    final nextSession = ref.watch(nextSessionProvider).valueOrNull;

    return LargeTitleScaffold(
      title: 'Academics',
      body: studentAsync.when(
        data: (student) => _AcademicsBody(student: student, courses: courses, gpaTrend: gpaTrend, nextSession: nextSession),
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
  const _AcademicsBody({required this.student, required this.courses, required this.gpaTrend, required this.nextSession});
  final Student student;
  final List<Course> courses;
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
        const SectionHeader('This semester'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < courses.length; i++)
                  _CourseRow(course: courses[i], isFirst: i == 0, onTap: () => showCourseDetailsSheet(context, courses[i])),
              ],
            ),
          ),
        ),
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
                  subtitle: 'Next: MA201 midterm · 3 days',
                  onTap: () => context.push(AppRoutes.academicsExams),
                ),
                NavRowCard(
                  icon: CupertinoIcons.chart_bar,
                  iconColor: colors.accent,
                  title: 'Grades',
                  subtitle: 'Semester GPA 3.24',
                  onTap: () => context.push(AppRoutes.academicsGrades),
                ),
                NavRowCard(
                  icon: CupertinoIcons.doc_checkmark,
                  iconColor: colors.success,
                  title: 'Assignments',
                  subtitle: '1 due Sunday · CS402',
                  onTap: () => context.push(AppRoutes.academicsAssignments),
                ),
                NavRowCard(
                  icon: CupertinoIcons.gauge,
                  iconColor: colors.success,
                  title: 'Attendance',
                  subtitle: '92% · one course below the line',
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
  const _CourseRow({required this.course, required this.isFirst, required this.onTap});
  final Course course;
  final bool isFirst;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
        child: Row(
          children: [
            ProgressRing(percent: course.attendancePercent),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 15.5)),
                  const SizedBox(height: 1),
                  Text(
                    course.isAttendanceAtRisk
                        ? '${course.code} · below the 75% threshold'
                        : '${course.code} · ${course.creditHours} credit hours',
                    style: text.footnote.copyWith(color: course.isAttendanceAtRisk ? colors.warning : colors.textMuted),
                  ),
                ],
              ),
            ),
            Text(course.grade, style: text.monoBody.copyWith(fontSize: 14)),
            const SizedBox(width: 4),
            Icon(CupertinoIcons.chevron_forward, size: 17, color: colors.textDim),
          ],
        ),
      ),
    );
  }
}
