import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/ai_message.dart';

/// Nexus's canned verdict for the drafted resume. Not in the design
/// reference — a new screen that must still read as a sibling of Nexus's
/// other structured answers (SPECS.nexus pin #1: verdict first, reasoning
/// second, evidence chips third, never a wall of prose).
final resumeVerdictProvider = Provider<AiAssistantMessage>((ref) {
  final c = AppColors.dark;
  return AiAssistantMessage(
    verdict: 'Your resume draft is ready.',
    body:
        'I pulled this from your transcript and course history — Computer Science, strongest in '
        'your data-structures and database coursework. Nothing here is invented; every line traces '
        'back to a course or your student record.',
    chips: [
      AiChip(label: '3 sections', color: c.info),
      AiChip(label: 'CS-focused', color: c.accent),
      AiChip(label: 'Draft · v1', color: c.warning),
    ],
    ctaLabel: 'Regenerate',
  );
});
