import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/lecture_summary_providers.dart';
import '../widgets/ai_message_bubble.dart';

/// Nexus has summarized a recent lecture. Not in the design reference — new,
/// but reads as a sibling of Nexus's other structured answers: verdict
/// first, then evidence, never a wall of prose (SPECS.nexus pin #1). Ties
/// back to the "balanced trees" quiz-prep thread on Home and the AI chat's
/// "What should I revise tonight?" reply, for narrative consistency.
class LectureSummaryScreen extends ConsumerWidget {
  const LectureSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verdict = ref.watch(lectureSummaryVerdictProvider);
    final points = ref.watch(lectureKeyPointsProvider);

    return AppPushScaffold(
      title: 'Lecture Summary',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AiMessageBubble(message: verdict),
          ),
          const SectionHeader('Key takeaways'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: points.isEmpty
                ? const StatusPlaceholder.empty(
                    icon: CupertinoIcons.doc_text,
                    title: 'Nothing to summarize yet',
                    message: 'Connect a lecture recording or slide deck to get real key takeaways.',
                  )
                : Column(
                    children: [
                      for (var i = 0; i < points.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: _KeyPointCard(index: i + 1, point: points[i]),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _KeyPointCard extends StatelessWidget {
  const _KeyPointCard({required this.index, required this.point});
  final int index;
  final LectureKeyPoint point;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), shape: BoxShape.circle),
            child: Text('$index', style: text.caption1.copyWith(color: colors.accent)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(point.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 3),
                Text(point.body, style: text.footnote.copyWith(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
