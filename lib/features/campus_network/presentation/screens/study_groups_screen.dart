import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/datetime_format.dart';
import '../../application/study_group_membership.dart';
import '../../data/study_group_repository.dart';
import '../../domain/study_group.dart';

/// Course-tied study sessions students create and join. See
/// `study_group_repository.dart` for why the listings are seed content.
class StudyGroupsScreen extends ConsumerWidget {
  const StudyGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(studyGroupsProvider);
    final joined = ref.watch(studyGroupMembershipProvider);

    return AppPushScaffold(
      title: 'Study Groups',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        child: Column(
          children: [for (final group in groups) Padding(padding: const EdgeInsets.only(bottom: 10), child: _GroupCard(group: group, joined: joined.contains(group.id)))],
        ),
      ),
    );
  }
}

class _GroupCard extends ConsumerWidget {
  const _GroupCard({required this.group, required this.joined});
  final StudyGroup group;
  final bool joined;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(group.courseName, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                    Text('${group.courseCode} · organized by ${group.organizer.fullName}', style: text.footnote.copyWith(color: colors.textMuted)),
                  ],
                ),
              ),
              TagChip(label: group.meetingType.label, color: group.meetingType == MeetingType.online ? colors.info : colors.warning),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(CupertinoIcons.location, size: 13, color: colors.textDim),
              const SizedBox(width: 5),
              Expanded(child: Text(group.location, style: text.footnote, overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Icon(CupertinoIcons.clock, size: 13, color: colors.textDim),
              const SizedBox(width: 5),
              Text('${formatWeekdayName(group.meetingTime)}, ${formatTimeOfDay(group.meetingTime)}', style: text.footnote),
              const Spacer(),
              Text('${group.members.length}/${group.maxStudents} joined', style: text.footnote.copyWith(color: colors.textMuted)),
            ],
          ),
          const SizedBox(height: 10),
          AppButton(
            label: group.isFull && !joined ? 'Full' : (joined ? 'Leave' : 'Join'),
            variant: joined ? AppButtonVariant.destructive : AppButtonVariant.secondary,
            expand: true,
            onPressed: group.isFull && !joined ? null : () => ref.read(studyGroupMembershipProvider.notifier).toggle(group.id),
          ),
        ],
      ),
    );
  }
}
