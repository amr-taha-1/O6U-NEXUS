import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/ai_message.dart';

/// There is no real lecture-recording/CMS ingestion pipeline anywhere in
/// this app (that would be new infrastructure, not a data-consistency fix)
/// — so unlike the rest of Nexus's replies, this one can't be computed from
/// a real source. Previously this hardcoded a specific fake lecture
/// ("CS402 · Lecture 7 · balanced trees") for a course the student was
/// never enrolled in; it now says so honestly instead of inventing content
/// for a real course that never happened either.
final lectureSummaryVerdictProvider = Provider<AiAssistantMessage>((ref) {
  final c = AppColors.dark;
  return AiAssistantMessage(
    verdict: 'No lecture recording or CMS source connected yet.',
    body: 'Nexus can only summarize a lecture once it can read the recording or slides — that '
        'integration isn\'t built yet, so nothing below is invented to fill the gap.',
    chips: [AiChip(label: 'No source connected', color: c.textDim)],
    ctaLabel: 'Connect a source',
  );
});

/// One bullet in the "key takeaways" list under the verdict card — empty
/// until a real lecture source exists, rather than fabricated content.
class LectureKeyPoint {
  const LectureKeyPoint({required this.title, required this.body});
  final String title;
  final String body;
}

final lectureKeyPointsProvider = Provider<List<LectureKeyPoint>>((ref) => const []);
