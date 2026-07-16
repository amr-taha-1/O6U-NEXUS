import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Favorite drivers/passengers — session-scoped in-memory state, the same
/// pattern as [SearchHistoryNotifier] and the class-reminder toggles.
/// Ready to swap for persisted/server-synced favorites later without
/// touching any screen that reads it.
class CarpoolFavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String participantId) {
    state = state.contains(participantId)
        ? {for (final id in state) if (id != participantId) id}
        : {...state, participantId};
  }

  bool isFavorite(String participantId) => state.contains(participantId);
}

final carpoolFavoritesProvider = NotifierProvider<CarpoolFavoritesNotifier, Set<String>>(
  CarpoolFavoritesNotifier.new,
);

/// How many rides the student has actually completed with each driver —
/// starts empty (honest: this build has no booking backend to populate it
/// from), but the shape is real and ready for a future "my ride history"
/// feature to fill in without changing [matchPercentFor]'s signature.
final pastRidesWithDriverProvider = Provider.family<int, String>((ref, driverId) => 0);
