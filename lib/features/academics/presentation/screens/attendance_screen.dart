import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/domain/course.dart';
import '../../application/academics_providers.dart';

/// Shows the 75% line, and how far a student is from it. Ports the
/// reference's `Attendance` component (SPECS.attendance) � the ring is the
/// summary, the bars are the truth, and both share one colour rule.
class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = context.textStyles;
    final courses = ref.watch(coursesProvider);
    final overall = ref.watch(overallAttendanceProvider);
    final atRisk = courses.where((c) => c.isAttendanceAtRisk).toList();

    return AppPushScaffold(
      title: 'Attendance',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Row(
                children: [
                  ProgressRing(percent: overall, size: 78, strokeWidth: 5),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$overall% overall', style: text.headline),
                        const SizedBox(height: 3),
                        Text(
                          "Above the university's 75% threshold in ${courses.length - atRisk.length} of ${courses.length} courses.",
                          style: text.subhead.copyWith(fontSize: 13.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader('By course'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final course in courses) Padding(padding: const EdgeInsets.only(bottom: 9), child: _CourseBar(course: course)),
              ],
            ),
          ),
          if (atRisk.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: _AtRiskCard(course: atRisk.first),
            ),
        ],
      ),
    );
  }
}

class _CourseBar extends StatelessWidget {
  const _CourseBar({required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final low = course.isAttendanceAtRisk;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${course.code} · ${course.name}',
                  style: text.bodyEmphasized.copyWith(fontSize: 14.5),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${course.attendancePercent}%',
                style: text.monoBody.copyWith(color: low ? colors.warning : colors.success, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 9),
          AppProgressBar(
            value: course.attendancePercent / 100,
            color: low ? colors.warning : colors.success,
            thresholdPercent: kAttendanceThreshold,
          ),
        ],
      ),
    );
  }
}

class _AtRiskCard extends StatelessWidget {
  const _AtRiskCard({required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final pointsBelow = kAttendanceThreshold.round() - course.attendancePercent;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: AppRadius.xlRadius,
        color: AppColors.tint(colors.warning, 0.1),
        border: Border.all(color: AppColors.tint(colors.warning, 0.3), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CupertinoIcons.exclamationmark_triangle, size: 17, color: colors.warning),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${course.code} is $pointsBelow points below the line', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 3),
                Text(
                  'Four lectures brings it back to 78%. Nexus can hold those hours for you.',
                  style: text.footnote.copyWith(fontSize: 13.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
