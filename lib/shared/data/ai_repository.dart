import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../domain/ai_message.dart';

/// Canned Nexus replies, keyed by the exact suggested-prompt text — ports
/// the reference's `AI_REPLIES` map verbatim. A real LLM integration later
/// replaces [reply] with a network call; [suggestedPrompts] and the
/// [AiMessage] shape stay the same.
class AiRepository {
  const AiRepository();

  static final AppColors _c = AppColors.dark;

  static final Map<String, AiAssistantMessage> _replies = {
    'Can I graduate next semester?': AiAssistantMessage(
      verdict: 'Not next semester — but you can finish in two.',
      body:
          "You have 24 credit hours left and the registration cap is 18. I've built a path: 18 hours next term plus a 6-hour summer session. Two of the remaining courses have prerequisites you already cleared.",
      chips: [
        AiChip(label: '18 + 6 hours', color: _c.info),
        AiChip(label: 'Summer required', color: _c.warning),
        AiChip(label: 'Graduate: Aug 2027', color: _c.success),
      ],
      ctaLabel: 'Show the plan',
    ),
    'Why is my GPA dropping?': AiAssistantMessage(
      verdict: 'MA201 is doing the damage.',
      body:
          'Your midterm fell 14 points and attendance is at 68% — below the 75% threshold. Every other course is stable or improving. Fixing MA201 alone lifts your cumulative GPA to an estimated 3.28.',
      chips: [
        AiChip(label: 'MA201 · 68%', color: _c.danger),
        AiChip(label: 'Midterm −14', color: _c.warning),
        AiChip(label: 'Recoverable', color: _c.success),
      ],
      ctaLabel: 'Book revision blocks',
    ),
    'Plan my week': AiAssistantMessage(
      verdict: '14 study hours placed. No conflicts.',
      body:
          'I used the gaps between your lectures and protected Friday evening. MA201 gets the most hours because it\'s the course dragging your GPA. Your mock exam sits on Friday morning, 48 hours before the real one.',
      chips: [
        AiChip(label: '14 hrs placed', color: _c.accent),
        AiChip(label: '0 conflicts', color: _c.success),
        AiChip(label: 'Mock exam Fri', color: _c.info),
      ],
      ctaLabel: 'Add to calendar',
    ),
    'What should I revise tonight?': AiAssistantMessage(
      verdict: 'Balanced trees. Two hours is enough.',
      body:
          "Thursday's CS402 quiz covers lectures 6 and 7, and balanced trees is the only topic you haven't opened in the CMS. Everything else on the quiz you've already been assessed on — and scored above 85%.",
      chips: [
        AiChip(label: 'Lecture 7', color: _c.info),
        AiChip(label: '2 hrs', color: _c.accent),
        AiChip(label: 'Quiz Thursday', color: _c.warning),
      ],
      ctaLabel: 'Open lecture 7',
    ),
  };

  List<String> get suggestedPrompts => _replies.keys.toList();

  /// Simulates "Nexus reads only your record" — anything outside the
  /// canned set gets the same honest fallback the reference uses.
  AiAssistantMessage reply(String prompt) {
    return _replies[prompt] ??
        AiAssistantMessage(
          verdict: 'I can only answer from your record.',
          body:
              'Try one of the suggestions below — I read your transcript, attendance, timetable and deadlines, and nothing else.',
          chips: [AiChip(label: 'Record-only', color: _c.accent)],
          ctaLabel: 'See what Nexus reads',
        );
  }
}

final aiRepositoryProvider = Provider<AiRepository>((ref) => const AiRepository());
