import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Which study groups the signed-in student has joined this session — same
/// in-memory convention as `carpool_favorites.dart`.
class StudyGroupMembershipNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String groupId) {
    state = state.contains(groupId) ? {for (final id in state) if (id != groupId) id} : {...state, groupId};
  }
}

final studyGroupMembershipProvider = NotifierProvider<StudyGroupMembershipNotifier, Set<String>>(
  StudyGroupMembershipNotifier.new,
);
