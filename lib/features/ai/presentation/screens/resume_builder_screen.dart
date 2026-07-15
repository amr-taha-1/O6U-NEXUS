import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/course_repository.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/ai_message.dart';
import '../../../../shared/domain/course.dart';
import '../../../../shared/domain/student.dart';
import '../../application/resume_builder_providers.dart';
import '../widgets/ai_message_bubble.dart';

/// Nexus has drafted a resume from the student's transcript and course
/// history. Not in the design reference — new, but reads as a sibling of
/// Nexus's other structured answers: verdict-first, then evidence, never a
/// wall of prose (SPECS.nexus pin #1).
class ResumeBuilderScreen extends ConsumerWidget {
  const ResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final courses = ref.watch(coursesProvider);
    final verdict = ref.watch(resumeVerdictProvider);

    return AppPushScaffold(
      title: 'Resume Builder',
      body: studentAsync.when(
        data: (student) => _ResumeBody(student: student, courses: courses, verdict: verdict),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: SkeletonListTile(isFirst: true),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your record: $error'),
      ),
    );
  }
}

class _ResumeBody extends StatelessWidget {
  const _ResumeBody({required this.student, required this.courses, required this.verdict});
  final Student student;
  final List<Course> courses;
  final AiAssistantMessage verdict;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AiMessageBubble(message: verdict),
        ),
        const SectionHeader('Education'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: _EducationCard(student: student),
        ),
        const SectionHeader('Skills'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: _SkillsCard(courses: courses),
        ),
        const SectionHeader('Projects'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: const StatusPlaceholder.empty(
              icon: CupertinoIcons.folder,
              title: 'No projects added yet',
              message: "Nexus will suggest ones from your coursework once you link a GitHub repo.",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 18, AppSpacing.screenMargin, 0),
          child: AppButton(
            label: 'Export as PDF',
            icon: CupertinoIcons.arrow_down_doc,
            expand: true,
            onPressed: () =>
                AppSnackbar.show(context, message: 'Resume exported to Downloads.', kind: AppSnackbarKind.success),
          ),
        ),
      ],
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(student.university, style: text.bodyEmphasized.copyWith(fontSize: 15.5)),
          const SizedBox(height: 2),
          Text('${student.major} · Level ${student.level}', style: text.footnote),
          const SizedBox(height: 10),
          Row(
            children: [
              _StatChip(label: 'Cumulative GPA', value: student.cumulativeGpa.toStringAsFixed(2), color: colors.accent),
              const SizedBox(width: 8),
              _StatChip(
                label: 'Credit hours',
                value: '${student.creditHoursCompleted}/${student.creditHoursTotal}',
                color: colors.info,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(color: AppColors.tint(color, 0.1), borderRadius: AppRadius.smRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: text.footnote.copyWith(fontSize: 11)),
            const SizedBox(height: 2),
            Text(value, style: text.monoBody.copyWith(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.courses});
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        children: [for (final course in courses) TagChip(label: course.name, color: colors.info)],
      ),
    );
  }
}
