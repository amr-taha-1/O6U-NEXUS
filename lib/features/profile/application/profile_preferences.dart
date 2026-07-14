import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Trivial UI-driven toggles for Settings and Security. In-memory only —
/// nothing persists across a cold app restart in this sprint.
final quietHoursEnabledProvider = StateProvider<bool>((ref) => true);

final faceIdEnabledProvider = StateProvider<bool>((ref) => true);
