import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message.freezed.dart';

@freezed
abstract class AiChip with _$AiChip {
  const factory AiChip({required String label, required Color color}) = _AiChip;
}

/// A Nexus chat turn. Modeled as a union because a user turn and an
/// assistant turn render as genuinely different widgets (a plain bubble vs.
/// a structured verdict/body/chips/CTA card) — see the reference's `Nexus`
/// component and SPECS.nexus pin #1 ("Answers are structured … never a wall
/// of prose").
@freezed
sealed class AiMessage with _$AiMessage {
  const factory AiMessage.user({required String text}) = AiUserMessage;

  const factory AiMessage.assistant({
    required String verdict,
    required String body,
    required List<AiChip> chips,
    required String ctaLabel,
  }) = AiAssistantMessage;
}
