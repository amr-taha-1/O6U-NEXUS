import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/curriculum_engine.dart';
import '../../domain/catalog_course.dart';

/// "Which courses can I register next?" — the eligibility engine, derived
/// live from the real transcript and the department bylaw's prerequisite
/// chains (`assets/data/bylaw_information_systems.json`). Nothing here is
/// hardcoded: a course is eligible the moment its prerequisites show up as
/// passed in the transcript. See docs/Architecture.md "Real data".
class CourseCatalogScreen extends ConsumerWidget {
  const CourseCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eligibilityAsync = ref.watch(courseEligibilityProvider);
    final estimatedSemestersAsync = ref.watch(estimatedRemainingSemestersProvider);

    return AppPushScaffold(
      title: 'Course Catalog',
      body: eligibilityAsync.when(
        data: (eligibility) => _CatalogBody(
          eligibility: eligibility,
          estimatedSemesters: estimatedSemestersAsync.valueOrNull,
        ),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load the course catalog: $error'),
      ),
    );
  }
}

class _CatalogBody extends StatelessWidget {
  const _CatalogBody({required this.eligibility, required this.estimatedSemesters});
  final List<CourseEligibility> eligibility;
  final int? estimatedSemesters;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    final registered = [for (final e in eligibility) if (e.status == EligibilityStatus.registered) e];
    final eligibleNow = [for (final e in eligibility) if (e.status == EligibilityStatus.eligible) e];
    final locked = [for (final e in eligibility) if (e.status == EligibilityStatus.locked) e];
    final completedCount = eligibility.where((e) => e.status == EligibilityStatus.completed).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Row(
              children: [
                _StatColumn(label: 'Completed', value: '$completedCount', color: colors.success),
                _StatColumn(label: 'Registered', value: '${registered.length}', color: colors.info),
                _StatColumn(label: 'Eligible now', value: '${eligibleNow.length}', color: colors.accent),
                _StatColumn(label: 'Locked', value: '${locked.length}', color: colors.warning),
              ],
            ),
          ),
        ),
        if (estimatedSemesters != null && estimatedSemesters! > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 10, AppSpacing.screenMargin, 0),
            child: Text(
              'At your own historical pace, an estimated $estimatedSemesters more '
              '${estimatedSemesters == 1 ? 'semester' : 'semesters'} to graduate. An estimate, not a promise.',
              style: text.footnote.copyWith(color: colors.textDim),
            ),
          ),
        if (registered.isNotEmpty) ...[
          const SectionHeader('Currently registered this term'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < registered.length; i++)
                    _RegisteredRow(course: registered[i].course, isFirst: i == 0),
                ],
              ),
            ),
          ),
        ],
        const SectionHeader('Eligible to register next'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: eligibleNow.isEmpty
              ? const AppCard(
                  child: StatusPlaceholder.empty(
                    icon: CupertinoIcons.checkmark_seal,
                    title: 'Nothing new to unlock',
                    message: 'Every unlockable course is already completed or already registered.',
                  ),
                )
              : AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < eligibleNow.length; i++)
                        _EligibleRow(course: eligibleNow[i].course, isFirst: i == 0),
                    ],
                  ),
                ),
        ),
        const SectionHeader('Locked'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Column(
            children: [for (final e in locked) _LockedCard(eligibility: e)],
          ),
        ),
      ],
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
    return Expanded(
      child: Column(
        children: [
          Text(value, style: text.title2.copyWith(color: color, fontSize: 22)),
          const SizedBox(height: 2),
          Text(label, style: text.footnote.copyWith(fontSize: 11.5)),
        ],
      ),
    );
  }
}

class _EligibleRow extends StatelessWidget {
  const _EligibleRow({required this.course, required this.isFirst});
  final CatalogCourse course;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
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
                  Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                  const SizedBox(height: 1),
                  Text('${course.code} · ${course.creditHours} credit hours', style: text.footnote),
                ],
              ),
            ),
            Icon(CupertinoIcons.checkmark_circle, size: 18, color: colors.success),
          ],
        ),
      ),
    );
  }
}

class _RegisteredRow extends StatelessWidget {
  const _RegisteredRow({required this.course, required this.isFirst});
  final CatalogCourse course;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
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
                  Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                  const SizedBox(height: 1),
                  Text('${course.code} · ${course.creditHours} credit hours', style: text.footnote),
                ],
              ),
            ),
            Icon(CupertinoIcons.time, size: 18, color: colors.info),
          ],
        ),
      ),
    );
  }
}

class _LockedCard extends StatelessWidget {
  const _LockedCard({required this.eligibility});
  final CourseEligibility eligibility;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final course = eligibility.course;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.all(13),
        onTap: () => context.push(AppRoutes.courseDetailsPath(course.code)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.lock, size: 15, color: colors.textDim),
                const SizedBox(width: 8),
                Expanded(child: Text(course.name, style: text.bodyEmphasized.copyWith(fontSize: 14.5))),
              ],
            ),
            const SizedBox(height: 2),
            Text('${course.code} · ${course.creditHours} credit hours', style: text.footnote),
            if (eligibility.missingPrerequisites.isNotEmpty) ...[
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final missing in eligibility.missingPrerequisites)
                    TagChip(label: missing.name, color: colors.warning),
                ],
              ),
            ] else if (course.requiresArticle40) ...[
              const SizedBox(height: 9),
              Text(
                'Needs the bylaw\'s minimum completed credit hours to register (Article 40).',
                style: text.footnote.copyWith(color: colors.textDim),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
