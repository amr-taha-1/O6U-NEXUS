import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/schedule_item.dart';

/// A simulated clock, ticking one minute every 6 seconds — purely cosmetic
/// (there's no backend to poll), but it's what makes the Home countdown
/// feel alive instead of static. Ports the reference's `mins` state.
class ClockNotifier extends Notifier<int> {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() => _timer?.cancel());
    _timer = Timer.periodic(const Duration(seconds: 6), (_) => state = state + 1);
    return 9 * 60 + 18; // 09:18
  }
}

final clockMinutesProvider = NotifierProvider<ClockNotifier, int>(ClockNotifier.new);

final clockLabelProvider = Provider<String>((ref) {
  final mins = ref.watch(clockMinutesProvider);
  final h = (mins ~/ 60) % 24;
  final m = mins % 60;
  return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
});

/// Minutes remaining until the next-up class (CS402 at 10:30).
final nextClassCountdownProvider = Provider<String>((ref) {
  final mins = ref.watch(clockMinutesProvider);
  final left = 630 - mins;
  if (left <= 0) return 'now';
  if (left > 60) return 'in ${left ~/ 60}h ${left % 60}m';
  return 'in ${left}m';
});

/// Whether the Nexus thread banner is showing. Dismissing it (either
/// action) hides it for the rest of the session — see the reference's
/// SPECS.today pin #1.
class NexusThreadVisibleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void dismiss() => state = false;
}

final nexusThreadVisibleProvider = NotifierProvider<NexusThreadVisibleNotifier, bool>(NexusThreadVisibleNotifier.new);

final todayScheduleProvider = Provider<List<ScheduleItem>>((ref) {
  final c = AppColors.dark;
  return [
    ScheduleItem(
      time: '09:00',
      title: 'EN102 · Technical Writing',
      meta: 'Hall D3 · 60 min',
      accent: c.info,
      icon: CupertinoIcons.book,
      kind: ScheduleItemKind.lecture,
    ),
    ScheduleItem(
      time: '10:30',
      title: 'CS402 · Data Structures',
      meta: 'Hall B2 · 90 min',
      accent: c.accent,
      icon: CupertinoIcons.book,
      kind: ScheduleItemKind.lecture,
    ),
    ScheduleItem(
      time: '12:30',
      title: 'Free — 3 hours',
      meta: 'Nexus placed: revise CS402',
      accent: c.success,
      icon: CupertinoIcons.sparkles,
      kind: ScheduleItemKind.freeBlock,
    ),
    ScheduleItem(
      time: '15:30',
      title: 'MA201 · Lab',
      meta: 'Lab 4 · attendance at 68%',
      accent: c.warning,
      icon: CupertinoIcons.exclamationmark_triangle,
      kind: ScheduleItemKind.lab,
    ),
  ];
});
