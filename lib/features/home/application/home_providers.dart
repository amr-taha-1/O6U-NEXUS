import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/schedule_item.dart';
import '../../schedule/application/schedule_providers.dart';
import '../../schedule/domain/schedule_session.dart';

/// Today's real classes (`assets/data/schedule.json`, via
/// `todaysSessionsProvider`), mapped into the [ScheduleItem] shape
/// `DayTimeline` already renders — replaces the previous fully-fictional
/// static list (CS402/MA201/EN102) with the student's actual registered
/// summer sessions. See docs/Architecture.md "Real data".
final todayScheduleProvider = FutureProvider<List<ScheduleItem>>((ref) async {
  final sessions = await ref.watch(todaysSessionsProvider.future);
  return [for (final session in sessions) _toScheduleItem(session)];
});

ScheduleItem _toScheduleItem(ScheduleSession session) {
  final isLab = session.type == SessionType.lab;
  final colors = AppColors.dark;
  return ScheduleItem(
    time: session.startLabel,
    title: '${session.courseCode} · ${session.courseName}',
    meta: '${session.instructor ?? 'Instructor TBA'} · Room ${session.room} · ${session.timeRangeLabel}',
    accent: isLab ? colors.warning : colors.info,
    icon: isLab ? CupertinoIcons.lab_flask : CupertinoIcons.book,
    kind: isLab ? ScheduleItemKind.lab : ScheduleItemKind.lecture,
  );
}
