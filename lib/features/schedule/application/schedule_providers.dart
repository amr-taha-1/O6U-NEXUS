import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/schedule_repository.dart';
import '../domain/schedule_session.dart';

/// Sunday-first weekday order, matching the university week (Sunday through
/// Thursday; Friday/Saturday are the weekend).
const weekdayOrder = [Weekday.sunday, Weekday.monday, Weekday.tuesday, Weekday.wednesday, Weekday.thursday];

final weeklyScheduleProvider = FutureProvider<Map<Weekday, List<ScheduleSession>>>((ref) async {
  final sessions = await ref.watch(scheduleProvider.future);
  final byDay = <Weekday, List<ScheduleSession>>{for (final day in weekdayOrder) day: []};
  for (final session in sessions) {
    byDay[session.day]!.add(session);
  }
  for (final list in byDay.values) {
    list.sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
  }
  return byDay;
});

final todaysSessionsProvider = FutureProvider<List<ScheduleSession>>((ref) async {
  final byDay = await ref.watch(weeklyScheduleProvider.future);
  final today = WeekdayX.fromDateTimeWeekday(DateTime.now().weekday);
  return today == null ? const [] : byDay[today]!;
});

/// The single next class chronologically — today if one hasn't started yet,
/// otherwise the next session on a later day this week (wrapping back to
/// Sunday if the rest of the week is done). Null if the schedule is empty.
final nextSessionProvider = FutureProvider<ScheduleSession?>((ref) async {
  final byDay = await ref.watch(weeklyScheduleProvider.future);
  final now = DateTime.now();
  final today = WeekdayX.fromDateTimeWeekday(now.weekday);
  final nowMinutes = now.hour * 60 + now.minute;

  if (today != null) {
    for (final session in byDay[today]!) {
      if (session.startMinutes > nowMinutes) return session;
    }
  }

  final todayIndex = today == null ? -1 : weekdayOrder.indexOf(today);
  for (var offset = 1; offset <= weekdayOrder.length; offset++) {
    final day = weekdayOrder[(todayIndex + offset) % weekdayOrder.length];
    final sessions = byDay[day]!;
    if (sessions.isNotEmpty) return sessions.first;
  }
  return null;
});

/// Minutes until [nextSessionProvider]'s session — clock-driven only when
/// asked, not a ticking timer (unlike the fictional Home countdown this
/// replaces conceptually; real schedules don't need a fake live clock).
final minutesUntilNextSessionProvider = FutureProvider<int?>((ref) async {
  final next = await ref.watch(nextSessionProvider.future);
  if (next == null) return null;
  final byDay = await ref.watch(weeklyScheduleProvider.future);
  final now = DateTime.now();
  final today = WeekdayX.fromDateTimeWeekday(now.weekday);
  final nowMinutes = now.hour * 60 + now.minute;

  if (today == next.day && byDay[today]!.any((s) => s == next) && next.startMinutes > nowMinutes) {
    return next.startMinutes - nowMinutes;
  }

  final todayIndex = today == null ? -1 : weekdayOrder.indexOf(today);
  final nextDayIndex = weekdayOrder.indexOf(next.day);
  var daysAway = nextDayIndex - todayIndex;
  if (daysAway <= 0) daysAway += weekdayOrder.length;
  final minutesLeftToday = today == null ? 0 : (24 * 60 - nowMinutes);
  final fullDaysBetween = daysAway - 1;
  return minutesLeftToday + fullDaysBetween * 24 * 60 + next.startMinutes;
});
