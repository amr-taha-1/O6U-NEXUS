import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../curriculum/application/curriculum_engine.dart';
import '../../../curriculum/domain/catalog_course.dart';
import '../../../transcript/presentation/grade_colors.dart';
import '../../application/course_details.dart';

/// Every course reference anywhere in the app is clickable and lands here.
/// One screen, fed by [courseDetailsProvider], which merges whatever real
/// sources know about the code: the bylaw (prerequisites, next courses,
/// credit hours), the transcript (every attempt, chronological, transfer
/// credits included), and eligibility. See docs/Architecture.md "Real data".
class CourseDetailsScreen extends ConsumerWidget {
  const CourseDetailsScreen({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(courseDetailsProvider(code));

    return AppPushScaffold(
      title: code.toUpperCase(),
      body: detailsAsync.when(
        data: (details) => details == null
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: StatusPlaceholder.empty(
                  icon: CupertinoIcons.question_circle,
                  title: 'Course not found',
                  message: 'This code doesn\'t match the bylaw, your transcript, or your registered courses.',
                ),
              )
            : _CourseDetailsBody(details: details),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Column(
            children: [
              SkeletonBox(height: 90, borderRadius: BorderRadius.all(Radius.circular(18))),
              SizedBox(height: 12),
              SkeletonListTile(isFirst: true),
              SkeletonListTile(),
            ],
          ),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load this course: $error'),
      ),
    );
  }
}

class _CourseDetailsBody extends StatelessWidget {
  const _CourseDetailsBody({required this.details});
  final CourseDetails details;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final catalog = details.catalogCourse;
    final status = details.eligibility?.status;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(details.code, style: text.subhead.copyWith(color: colors.accent, fontWeight: FontWeight.w600, letterSpacing: 1)),
                const SizedBox(height: 3),
                Text(details.name, style: text.title2),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    if (status != null) _StatusChip(status: status),
                    if (catalog != null) TagChip(label: categoryLabel(catalog.category), color: colors.info),
                    if (catalog != null) TagChip(label: '${catalog.creditHours} credit hours', color: colors.textMuted),
                    if (catalog != null) TagChip(label: 'Year ${catalog.yearLevel}', color: colors.textMuted),
                    if (details.isRepeated) TagChip(label: 'Repeated · ${details.attempts.length}x', color: colors.warning, icon: CupertinoIcons.arrow_2_circlepath),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (catalog != null) ...[
          const SectionHeader('Course Info'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _InfoRow(isFirst: true, label: 'Department', value: departmentFor(catalog) ?? '—'),
                  _InfoRow(label: 'Type', value: categoryLabel(catalog.category)),
                  if (details.estimatedWorkload != null)
                    _InfoRow(
                      label: 'Estimated workload',
                      value: '${'●' * details.estimatedWorkload!}${'○' * (5 - details.estimatedWorkload!)}',
                      valueColor: colors.accent,
                    ),
                ],
              ),
            ),
          ),
          if (details.estimatedWorkload != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
              child: Text(
                'Estimated from credit hours and prerequisite depth — not a real difficulty score (no cohort data exists to compute one).',
                style: text.footnote.copyWith(color: colors.textDim),
              ),
            ),
        ],
        const SectionHeader('Prerequisites'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: catalog == null || catalog.prerequisiteCourseCodes.isEmpty && !catalog.requiresArticle40
              ? Text('None', style: text.footnote.copyWith(color: colors.textDim))
              : Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    for (final missing in details.eligibility?.missingPrerequisites ?? const <CatalogCourse>[])
                      _CourseChip(course: missing, color: colors.warning),
                    for (final code in catalog.prerequisiteCourseCodes)
                      if (details.eligibility?.missingPrerequisites.any((m) => m.code == code) != true)
                        TagChip(label: code, color: colors.success, icon: CupertinoIcons.checkmark),
                    if (catalog.requiresArticle40)
                      TagChip(label: 'Article 40 credit-hour threshold', color: colors.info),
                  ],
                ),
        ),
        if (details.nextCourses.isNotEmpty) ...[
          const SectionHeader('Unlocks Next'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [for (final next in details.nextCourses) _CourseChip(course: next, color: colors.accent)],
            ),
          ),
        ],
        const SectionHeader('My Record'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: details.attempts.isEmpty
              ? AppCard(
                  child: StatusPlaceholder.empty(
                    icon: CupertinoIcons.doc_text,
                    title: status == EligibilityStatus.registered ? 'In progress' : 'Not taken yet',
                    message: switch (status) {
                      EligibilityStatus.locked => 'Locked — missing prerequisites above.',
                      EligibilityStatus.registered => 'Registered this term — no grade posted yet.',
                      _ => 'Not on your transcript.',
                    },
                  ),
                )
              : AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < details.attempts.length; i++)
                        _AttemptRow(attempt: details.attempts[i], isFirst: i == 0),
                    ],
                  ),
                ),
        ),
        if (details.attempts.isNotEmpty) ...[
          const SectionHeader('Statistics'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Row(
                children: [
                  Expanded(child: _StatColumn(label: 'Attempts', value: '${details.attempts.length}', color: colors.textPrimary)),
                  Expanded(child: _StatColumn(label: 'Latest grade', value: details.latestGrade, color: gradeColor(colors, details.latestGrade))),
                  Expanded(child: _StatColumn(label: 'Points earned', value: details.totalPointsEarned.toStringAsFixed(1), color: colors.accent)),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final EligibilityStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (label, color) = switch (status) {
      EligibilityStatus.completed => ('Completed', colors.success),
      EligibilityStatus.registered => ('Registered This Term', colors.info),
      EligibilityStatus.eligible => ('Eligible Now', colors.accent),
      EligibilityStatus.locked => ('Locked', colors.warning),
    };
    return TagChip(label: label, color: color, filled: true);
  }
}

class _CourseChip extends ConsumerWidget {
  const _CourseChip({required this.course, required this.color});
  final CatalogCourse course;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.courseDetailsPath(course.code)),
      child: TagChip(label: '${course.name} (${course.code})', color: color),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.isFirst = false, this.valueColor});
  final String label;
  final String value;
  final bool isFirst;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: text.body.copyWith(fontSize: 14.5)),
          Text(value, style: text.bodyEmphasized.copyWith(fontSize: 14.5, color: valueColor)),
        ],
      ),
    );
  }
}

class _AttemptRow extends StatelessWidget {
  const _AttemptRow({required this.attempt, required this.isFirst});
  final CourseAttempt attempt;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = gradeColor(colors, attempt.grade);

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
                Text(attempt.semesterLabel, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                if (attempt.creditHours != null || attempt.points != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    [
                      if (attempt.creditHours != null) '${attempt.creditHours} credit hours',
                      if (attempt.points != null) '${attempt.points!.toStringAsFixed(1)} pts',
                    ].join(' · '),
                    style: text.footnote.copyWith(color: colors.textMuted),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: AppColors.tint(color, 0.14), borderRadius: AppRadius.smRadius),
            child: Text(attempt.grade, style: text.monoBody.copyWith(color: color, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Column(
      children: [
        Text(value, style: text.title2.copyWith(color: color, fontSize: 20)),
        const SizedBox(height: 2),
        Text(label, style: text.footnote.copyWith(fontSize: 11.5), textAlign: TextAlign.center),
      ],
    );
  }
}
