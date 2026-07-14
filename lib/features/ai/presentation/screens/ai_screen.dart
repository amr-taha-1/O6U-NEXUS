import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TextField, InputDecoration, InputBorder;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/ai_chat_controller.dart';
import '../widgets/ai_message_bubble.dart';

class _Tool {
  const _Tool(this.icon, this.label, this.color, this.route);
  final IconData icon;
  final String label;
  final Color Function(AppColors) color;
  final String route;
}

final _tools = [
  _Tool(CupertinoIcons.slider_horizontal_3, 'GPA Simulator', (c) => c.info, AppRoutes.aiGpaSimulator),
  _Tool(CupertinoIcons.calendar_badge_plus, 'Study Planner', (c) => c.accent, AppRoutes.aiStudyPlanner),
  _Tool(CupertinoIcons.flag, 'Graduation', (c) => c.success, AppRoutes.aiGraduationPlanner),
  _Tool(CupertinoIcons.doc_person, 'Resume Builder', (c) => c.due, AppRoutes.aiResumeBuilder),
  _Tool(CupertinoIcons.text_badge_checkmark, 'Lecture Summary', (c) => c.warning, AppRoutes.aiLectureSummary),
];

/// Turns the transcript into an answer, in the shape of a decision. The AI
/// tab root.
class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends ConsumerState<AiScreen> {
  final _draftController = TextEditingController();

  void _send(String text) {
    if (text.trim().isEmpty) return;
    ref.read(aiChatControllerProvider.notifier).send(text.trim());
    _draftController.clear();
  }

  @override
  void dispose() {
    _draftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final chat = ref.watch(aiChatControllerProvider);
    final prompts = ref.watch(suggestedPromptsProvider);

    return LargeTitleScaffold(
      title: 'AI',
      bottomPadding: 88,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              itemCount: _tools.length,
              separatorBuilder: (_, _) => const SizedBox(width: 9),
              itemBuilder: (context, i) {
                final tool = _tools[i];
                final c = tool.color(colors);
                return AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  onTap: () => context.push(tool.route),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(color: AppColors.tint(c, 0.16), borderRadius: AppRadius.smRadius),
                        alignment: Alignment.center,
                        child: Icon(tool.icon, size: 13, color: c),
                      ),
                      const SizedBox(width: 8),
                      Text(tool.label, style: text.bodyEmphasized.copyWith(fontSize: 13.5)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (chat.messages.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: AppRadius.xlRadius,
                            gradient: LinearGradient(colors: [colors.accentDeep, colors.infoDeep]),
                          ),
                          alignment: Alignment.center,
                          child: Icon(CupertinoIcons.sparkles, size: 24, color: colors.onAccent),
                        ),
                        const SizedBox(height: 14),
                        Text('Ask about your record', style: text.headline, textAlign: TextAlign.center),
                        const SizedBox(height: 4),
                        Text(
                          "Nexus reads your transcript, attendance and timetable. It doesn't search the web.",
                          style: text.callout,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  for (final message in chat.messages)
                    Padding(padding: const EdgeInsets.only(bottom: 14), child: AiMessageBubble(message: message)),
                if (chat.typing) const Padding(padding: EdgeInsets.only(bottom: 14), child: AiTypingIndicator()),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              itemCount: prompts.length,
              separatorBuilder: (_, _) => const SizedBox(width: 7),
              itemBuilder: (context, i) => GestureDetector(
                onTap: () => _send(prompts[i]),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: AppRadius.pillRadius,
                    border: Border.all(color: colors.hairline, width: 0.5),
                  ),
                  child: Text(prompts[i], style: text.subhead.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 12),
            child: AppCard(
              tier: AppCardTier.raised,
              borderRadius: AppRadius.pillRadius,
              padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _draftController,
                      onSubmitted: _send,
                      style: text.body.copyWith(fontSize: 15.5),
                      cursorColor: colors.accent,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Ask Nexus…',
                        hintStyle: text.body.copyWith(color: colors.textDim, fontSize: 15.5),
                      ),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _draftController,
                    builder: (context, value, _) {
                      final hasText = value.text.trim().isNotEmpty;
                      return GestureDetector(
                        onTap: hasText ? () => _send(_draftController.text) : null,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: hasText ? colors.accentDeep : colors.textPrimary.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(CupertinoIcons.arrow_up, size: 15, color: hasText ? colors.onAccent : colors.textDim),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
