import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../features/schedule/domain/schedule_session.dart';

/// Schedules local "class starting soon" notifications for every session in
/// the real weekly timetable (`features/schedule/`) — one per enabled
/// offset (1h/30m/10m before), recurring weekly via
/// [DateTimeComponents.dayOfWeekAndTime]. A temporary local mechanism until
/// October 6 University's official API can push real-time changes (room
/// swaps, cancellations) — see docs/Architecture.md "Real data".
abstract final class ClassNotificationScheduler {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static const _channelId = 'class_reminders';

  static Future<void> initialize() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(android: androidInit, iOS: iosInit, macOS: iosInit),
    );

    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        'Class reminders',
        description: 'Alerts before your lectures and labs start',
        importance: Importance.high,
      ),
    );
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Cancels every previously scheduled class reminder and re-schedules
  /// from scratch against the current [sessions] and enabled offsets — the
  /// simplest way to stay correct whenever the schedule or Settings toggles
  /// change, given how few notifications this ever produces (sessions ×
  /// enabled offsets, at most a few dozen).
  static Future<void> rescheduleAll({
    required List<ScheduleSession> sessions,
    required bool enabled,
    required bool oneHourBefore,
    required bool thirtyMinBefore,
    required bool tenMinBefore,
  }) async {
    await _plugin.cancelAll();
    if (!enabled) return;

    final offsets = <int>[
      if (oneHourBefore) 60,
      if (thirtyMinBefore) 30,
      if (tenMinBefore) 10,
    ];
    if (offsets.isEmpty) return;

    var id = 0;
    for (final session in sessions) {
      for (final offsetMinutes in offsets) {
        final reminderMinutes = session.startMinutes - offsetMinutes;
        if (reminderMinutes < 0) continue; // no session starts early enough for this to matter today
        await _plugin.zonedSchedule(
          id: id++,
          title: '${_typeLabel(session.type)} in $offsetMinutes min',
          body: '${session.courseName} · Room ${session.room}',
          scheduledDate: _nextInstanceOf(session.day, reminderMinutes ~/ 60, reminderMinutes % 60),
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              'Class reminders',
              channelDescription: 'Alerts before your lectures and labs start',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }

  static String _typeLabel(SessionType type) => switch (type) {
    SessionType.lecture => 'Lecture',
    SessionType.lab => 'Lab',
  };

  static int _dateTimeWeekday(Weekday day) => switch (day) {
    Weekday.sunday => DateTime.sunday,
    Weekday.monday => DateTime.monday,
    Weekday.tuesday => DateTime.tuesday,
    Weekday.wednesday => DateTime.wednesday,
    Weekday.thursday => DateTime.thursday,
  };

  static tz.TZDateTime _nextInstanceOf(Weekday day, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    final targetWeekday = _dateTimeWeekday(day);
    while (scheduled.weekday != targetWeekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
