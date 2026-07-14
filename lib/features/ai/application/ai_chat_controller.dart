import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/ai_repository.dart';
import '../../../shared/domain/ai_message.dart';

class AiChatState {
  const AiChatState({this.messages = const [], this.typing = false});
  final List<AiMessage> messages;
  final bool typing;

  AiChatState copyWith({List<AiMessage>? messages, bool? typing}) {
    return AiChatState(messages: messages ?? this.messages, typing: typing ?? this.typing);
  }
}

/// Nexus chat state. A real model call later replaces the [Future.delayed]
/// in [send] with a network request — the state shape doesn't change.
class AiChatController extends Notifier<AiChatState> {
  @override
  AiChatState build() => const AiChatState();

  Future<void> send(String text) async {
    final repo = ref.read(aiRepositoryProvider);
    state = state.copyWith(messages: [...state.messages, AiMessage.user(text: text)], typing: true);
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    final reply = repo.reply(text);
    state = state.copyWith(messages: [...state.messages, reply], typing: false);
  }
}

final aiChatControllerProvider = NotifierProvider<AiChatController, AiChatState>(AiChatController.new);

final suggestedPromptsProvider = Provider<List<String>>((ref) => ref.watch(aiRepositoryProvider).suggestedPrompts);
