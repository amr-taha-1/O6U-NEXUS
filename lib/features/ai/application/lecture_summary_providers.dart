import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/ai_message.dart';

/// Nexus's summary of CS402 Lecture 7 — ties back to the "balanced trees"
/// quiz-prep thread referenced on Home and in the AI chat's "What should I
/// revise tonight?" reply (see `shared/data/ai_repository.dart`), for
/// narrative consistency across the app.
final lectureSummaryVerdictProvider = Provider<AiAssistantMessage>((ref) {
  final c = AppColors.dark;
  return AiAssistantMessage(
    verdict: 'CS402 · Lecture 7 covered balanced trees in 40 minutes.',
    body:
        "I condensed the recording and slides into the three ideas Thursday's quiz actually tests. "
        "You haven't opened this lecture in the CMS yet — everything else on the quiz you've "
        'already scored above 85% on.',
    chips: [
      AiChip(label: '12 min read → 3 min summary', color: c.info),
      AiChip(label: '3 key concepts', color: c.accent),
      AiChip(label: 'Quiz Thursday', color: c.warning),
    ],
    ctaLabel: 'Open lecture 7',
  );
});

/// One bullet in the "key takeaways" list under the verdict card.
class LectureKeyPoint {
  const LectureKeyPoint({required this.title, required this.body});
  final String title;
  final String body;
}

final lectureKeyPointsProvider = Provider<List<LectureKeyPoint>>((ref) {
  return const [
    LectureKeyPoint(
      title: 'AVL rotation restores balance in O(log n)',
      body: 'A single or double rotation after an insert or delete keeps every subtree '
          'height-balanced without rebuilding the tree.',
    ),
    LectureKeyPoint(
      title: 'Red-black trees trade strict balance for fewer rotations',
      body: 'Looser height guarantees than AVL, but cheaper rebalancing — why most standard '
          'libraries use them under the hood.',
    ),
    LectureKeyPoint(
      title: "Balance factor is the quiz's core check",
      body: 'Expect a question asking you to compute the left/right subtree height difference and '
          'name the rotation it triggers.',
    ),
  ];
});
