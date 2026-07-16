import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/campus_challenge_progress.dart';
import '../../application/campus_economy.dart';
import '../../data/campus_challenge_repository.dart';
import '../../domain/campus_challenge.dart';

/// Daily/weekly/semester missions. Advancing a mission is a real, working
/// local action (tap "Log progress") since there's no backend event to
/// react to yet (no real "answered a question" signal to hook into) —
/// completing one really does award real XP/Coins via
/// `campus_economy.dart`, it's just manually triggered rather than
/// automatically detected.
class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = ref.watch(campusChallengesProvider);
    final progress = ref.watch(campusChallengeProgressProvider);
    final xp = ref.watch(campusXpProvider);
    final coins = ref.watch(campusCoinsBalanceProvider);
    final colors = context.colors;

    return AppPushScaffold(
      title: 'Challenges',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Row(
                children: [
                  Expanded(child: _HeaderStat(label: 'XP earned', value: '$xp', color: colors.accent)),
                  Expanded(child: _HeaderStat(label: 'Coins earned', value: '$coins', color: colors.warning)),
                ],
              ),
            ),
          ),
          for (final cadence in ChallengeCadence.values) ...[
            SectionHeader('${cadence.label} Missions'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                children: [
                  for (final challenge in challenges.where((c) => c.cadence == cadence))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ChallengeCard(challenge: challenge, current: progress[challenge.id] ?? 0),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Column(
      children: [
        Text(value, style: text.title2.copyWith(color: color, fontSize: 22)),
        Text(label, style: text.footnote.copyWith(fontSize: 11.5)),
      ],
    );
  }
}

class _ChallengeCard extends ConsumerWidget {
  const _ChallengeCard({required this.challenge, required this.current});
  final CampusChallenge challenge;
  final int current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final completed = current >= challenge.targetCount;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text(challenge.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5))),
              if (completed) Icon(CupertinoIcons.checkmark_seal_fill, size: 18, color: colors.success),
            ],
          ),
          const SizedBox(height: 2),
          Text(challenge.description, style: text.footnote.copyWith(color: colors.textMuted)),
          const SizedBox(height: 8),
          AppProgressBar(value: current / challenge.targetCount, color: completed ? colors.success : colors.accent),
          const SizedBox(height: 6),
          Row(
            children: [
              Text('$current / ${challenge.targetCount}', style: text.footnote),
              const Spacer(),
              TagChip(label: '+${challenge.rewardXp} XP', color: colors.accent),
              const SizedBox(width: 6),
              TagChip(label: '+${challenge.rewardCoins} coins', color: colors.warning),
            ],
          ),
          if (!completed) ...[
            const SizedBox(height: 8),
            AppButton(
              label: 'Log progress',
              variant: AppButtonVariant.secondary,
              expand: true,
              onPressed: () => ref.read(campusChallengeProgressProvider.notifier).advance(challenge),
            ),
          ],
        ],
      ),
    );
  }
}
