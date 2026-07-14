import 'package:flutter/cupertino.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/course.dart';

Future<void> showCourseDetailsSheet(BuildContext context, Course course) {
  return showAppBottomSheet(context, builder: (_) => CourseDetailsSheet(course: course));
}

/// A course's grade, attendance, and materials â€” opens as a sheet, not a
/// new page, so the student never loses the Academics list. See
/// docs/reference/o6u-nexus-ios.tsx SPECS.portal pin #3.
class CourseDetailsSheet extends StatelessWidget {
  const CourseDetailsSheet({super.key, required this.course});

  final Course course;

  static const _materials = [
    ('Lecture 7 Â· Balanced trees', 'PDF Â· 2.4 MB', false),
    ('Assignment 5', 'Due Sunday Â· not submitted', true),
    ('Past papers Â· 2024', 'PDF Â· 6 files', false),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final risk = course.isAttendanceAtRisk;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.code, style: text.subhead.copyWith(color: colors.accent, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  const SizedBox(height: 3),
                  Text(course.name, style: text.title2),
                  const SizedBox(height: 3),
                  Text(course.nextSession, style: text.subhead),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: colors.textPrimary.withValues(alpha: 0.08), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(CupertinoIcons.xmark, size: 15, color: colors.textMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _StatBox(label: 'Grade', value: course.grade, color: colors.textPrimary)),
            const SizedBox(width: 9),
            Expanded(
              child: _StatBox(
                label: 'Attendance',
                value: '${course.attendancePercent}%',
                color: risk ? colors.warning : colors.success,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(child: _StatBox(label: 'Credit hrs', value: '${course.creditHours}', color: colors.textPrimary)),
          ],
        ),
        if (risk) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: AppRadius.lgRadius,
              color: AppColors.tint(colors.warning, 0.1),
              border: Border.all(color: AppColors.tint(colors.warning, 0.3), width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.exclamationmark_triangle, size: 16, color: colors.warning),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('78% chance of an academic warning', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                          const SizedBox(height: 4),
                          Text(
                            'Attending the next 4 lectures and submitting assignment 5 by Sunday drops this to 21%.',
                            style: text.footnote.copyWith(color: colors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppButton(label: 'Ask Nexus to fix this', expand: true, onPressed: () => Navigator.of(context).pop()),
              ],
            ),
          ),
        ],
        const SectionHeader('Materials', topPadding: 18),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < _materials.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  constraints: const BoxConstraints(minHeight: 52),
                  decoration: BoxDecoration(border: i == 0 ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.doc_text, size: 16, color: colors.info),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_materials[i].$1, style: text.body.copyWith(fontSize: 14.5, fontWeight: FontWeight.w500)),
                            Text(
                              _materials[i].$2,
                              style: text.caption1.copyWith(color: _materials[i].$3 ? colors.due : colors.textMuted, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.chevron_forward, size: 16, color: colors.textDim),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: context.textStyles.footnote.copyWith(fontSize: 11.5)),
          const SizedBox(height: 3),
          Text(value, style: context.textStyles.title3.copyWith(color: color, fontSize: 19)),
        ],
      ),
    );
  }
}
