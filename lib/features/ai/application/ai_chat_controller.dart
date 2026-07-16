import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/ai_message.dart';
import 'ai_reply_engine.dart';

class AiChatState {
  const AiChatState({this.messages = const [], this.typing = false});
  final List<AiMessage> messages;
  final bool typing;

  AiChatState copyWith({List<AiMessage>? messages, bool? typing}) {
    return AiChatState(messages: messages ?? this.messages, typing: typing ?? this.typing);
  }
}

/// Nexus chat state. [send] computes its reply from the real record
/// (`ai_reply_engine.dart`) — the artificial delay is purely cosmetic (a
/// real model call would have its own latency anyway), not a stand-in for
/// canned data.
class AiChatController extends Notifier<AiChatState> {
  @override
  AiChatState build() => const AiChatState();

  Future<void> send(String text) async {
    state = state.copyWith(messages: [...state.messages, AiMessage.user(text: text)], typing: true);
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    final reply = await buildAiReply(text, ref);
    state = state.copyWith(messages: [...state.messages, reply], typing: false);
  }
}

final aiChatControllerProvider = NotifierProvider<AiChatController, AiChatState>(AiChatController.new);

final suggestedPromptsProvider = Provider<List<String>>((ref) => suggestedAiPrompts);
