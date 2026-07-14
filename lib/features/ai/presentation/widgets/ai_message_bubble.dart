import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/ai_message.dart';

/// Answers are structured: verdict first, reasoning second, evidence chips
/// third — never a wall of prose. See
/// docs/reference/o6u-nexus-ios.tsx SPECS.nexus pin #1.
class AiMessageBubble extends StatelessWidget {
  const AiMessageBubble({super.key, required this.message});

  final AiMessage message;

  @override
  Widget build(BuildContext context) {
    return switch (message) {
      AiUserMessage(:final text) => _UserBubble(text: text),
      AiAssistantMessage() => _AssistantCard(message: message as AiAssistantMessage),
    }
        .animate()
        .fadeIn(duration: AppMotion.entrance)
        .slideY(begin: 0.06, end: 0);
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colors.accentDeep,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Text(text, style: context.textStyles.body.copyWith(color: colors.onAccent, fontSize: 15.5)),
        ),
      ),
    );
  }
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({required this.message});
  final AiAssistantMessage message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.94),
        child: AppCard(
          tier: AppCardTier.raised,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.sparkles, size: 13, color: colors.accent),
                  const SizedBox(width: 7),
                  Text('NEXUS', style: text.caption2.copyWith(color: colors.accent, fontSize: 11, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 9),
              Text(message.verdict, style: text.headline.copyWith(fontSize: 16)),
              const SizedBox(height: 6),
              Text(message.body, style: text.callout.copyWith(fontSize: 14.5)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [for (final chip in message.chips) TagChip(label: chip.label, color: chip.color)],
              ),
              const SizedBox(height: 12),
              AppButton(label: message.ctaLabel, expand: true, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class AiTypingIndicator extends StatelessWidget {
  const AiTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Align(
      alignment: Alignment.centerLeft,
      child: AppCard(
        tier: AppCardTier.raised,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Container(width: 7, height: 7, decoration: BoxDecoration(color: colors.accent, shape: BoxShape.circle))
                    .animate(onPlay: (c) => c.repeat())
                    .fadeIn(duration: 400.ms, delay: (i * 160).ms)
                    .then()
                    .fadeOut(duration: 400.ms),
              ),
          ],
        ),
      ),
    );
  }
}
