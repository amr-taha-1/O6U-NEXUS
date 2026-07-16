import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/campus_reputation.dart';
import '../../application/current_student_campus_member.dart';
import '../../data/campus_member_repository.dart';
import '../../domain/campus_member.dart';

/// "Student Profile 2.0" + "LinkedIn for Students" combined: skills,
/// programming languages, certificates, GitHub/LinkedIn/portfolio links,
/// volunteer hours, reputation breakdown, badges, and a project portfolio.
/// `memberId == 'me'` resolves to the signed-in student's own real-data
/// card; any other id resolves against the seed member directory.
class MemberProfileScreen extends ConsumerWidget {
  const MemberProfileScreen({super.key, required this.memberId});
  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (memberId == 'me') {
      final meAsync = ref.watch(currentStudentAsCampusMemberProvider);
      return AppPushScaffold(
        title: 'My Profile',
        body: meAsync.when(
          data: (member) => _ProfileBody(member: member, isMe: true),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: SkeletonListTile(isFirst: true),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: StatusPlaceholder.error(message: 'Couldn\'t load your profile: $error'),
          ),
        ),
      );
    }

    final member = ref.watch(campusMemberByIdProvider(memberId));
    return AppPushScaffold(
      title: member?.fullName ?? 'Profile',
      body: member == null
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: StatusPlaceholder.empty(icon: CupertinoIcons.person, title: 'Member not found', message: 'This profile may no longer exist.'),
            )
          : _ProfileBody(member: member, isMe: false),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.member, required this.isMe});
  final CampusMember member;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final level = computeCampusLevel(member.xp);
    final reputation = computeReputation(member);
    final badges = computeCampusBadges(member, reputation);

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.18), shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Icon(CupertinoIcons.person_alt, size: 24, color: colors.accent),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Flexible(child: Text(member.fullName, style: text.title3, overflow: TextOverflow.ellipsis)),
                              const SizedBox(width: 6),
                              Icon(CupertinoIcons.checkmark_seal_fill, size: 15, color: colors.info),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('${member.faculty} · ${member.department}', style: text.footnote),
                          Text('Level ${member.level}', style: text.footnote.copyWith(color: colors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _Stat(label: 'Followers', value: '${member.followers}')),
                    Expanded(child: _Stat(label: 'Following', value: '${member.following}')),
                    Expanded(child: _Stat(label: 'Coins', value: '${member.campusCoins}')),
                    Expanded(child: _Stat(label: 'Volunteer hrs', value: '${member.volunteerHours}')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SectionHeader('Campus Level'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Level ${level.level}', style: text.bodyEmphasized),
                    Text('${level.xpIntoLevel} / ${level.xpForNextLevel} XP', style: text.footnote.copyWith(color: colors.textMuted)),
                  ],
                ),
                const SizedBox(height: 8),
                AppProgressBar(value: level.progress, color: colors.accent),
              ],
            ),
          ),
        ),
        const SectionHeader('Reputation'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            child: Column(
              children: [
                _ReputationRow(label: 'Academic', value: reputation.academic, color: colors.info),
                _ReputationRow(label: 'Community', value: reputation.community, color: colors.success),
                _ReputationRow(label: 'Leadership', value: reputation.leadership, color: colors.warning),
                _ReputationRow(label: 'Innovation', value: reputation.innovation, color: colors.accent),
              ],
            ),
          ),
        ),
        if (badges.isNotEmpty) ...[
          const SectionHeader('Badges'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final badge in badges)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.12), borderRadius: AppRadius.smRadius),
                    child: Text('${badge.emoji} ${badge.label}', style: text.caption1.copyWith(fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          ),
        ],
        if (member.skills.isNotEmpty || member.programmingLanguages.isNotEmpty) ...[
          const SectionHeader('Skills'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final skill in member.skills) TagChip(label: skill, color: colors.textMuted),
                for (final lang in member.programmingLanguages) TagChip(label: lang, color: colors.info, icon: CupertinoIcons.chevron_left_slash_chevron_right),
              ],
            ),
          ),
        ],
        if (member.certificates.isNotEmpty) ...[
          const SectionHeader('Certificates'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < member.certificates.length; i++)
                    Container(
                      constraints: const BoxConstraints(minHeight: 48),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(border: i == 0 ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.rosette, size: 15, color: colors.warning),
                          const SizedBox(width: 10),
                          Expanded(child: Text(member.certificates[i], style: text.body.copyWith(fontSize: 14))),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
        if (member.projects.isNotEmpty) ...[
          const SectionHeader('Portfolio'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final project in member.projects)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(project.title, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                          const SizedBox(height: 3),
                          Text(project.description, style: text.footnote),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [for (final tech in project.techStack) TagChip(label: tech, color: colors.accent)],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (member.githubUrl != null || member.linkedinUrl != null || member.portfolioUrl != null) ...[
          const SectionHeader('Links'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  if (member.githubUrl != null) _LinkRow(icon: CupertinoIcons.link, label: 'GitHub', value: member.githubUrl!, isFirst: true),
                  if (member.linkedinUrl != null) _LinkRow(icon: CupertinoIcons.link, label: 'LinkedIn', value: member.linkedinUrl!, isFirst: member.githubUrl == null),
                  if (member.portfolioUrl != null)
                    _LinkRow(icon: CupertinoIcons.link, label: 'Portfolio', value: member.portfolioUrl!, isFirst: member.githubUrl == null && member.linkedinUrl == null),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Column(
      children: [
        Text(value, style: text.title3.copyWith(fontSize: 17)),
        const SizedBox(height: 1),
        Text(label, style: text.footnote.copyWith(fontSize: 11.5)),
      ],
    );
  }
}

class _ReputationRow extends StatelessWidget {
  const _ReputationRow({required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: text.footnote)),
          Expanded(child: AppProgressBar(value: value / 100, color: color)),
          const SizedBox(width: 10),
          SizedBox(width: 30, child: Text('$value', textAlign: TextAlign.right, style: text.monoSmall.copyWith(fontSize: 12))),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.icon, required this.label, required this.value, required this.isFirst});
  final IconData icon;
  final String label;
  final String value;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        children: [
          Icon(icon, size: 15, color: colors.info),
          const SizedBox(width: 10),
          Text(label, style: text.body.copyWith(fontSize: 14)),
          const Spacer(),
          Flexible(child: Text(value, style: text.footnote.copyWith(color: colors.textMuted), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
