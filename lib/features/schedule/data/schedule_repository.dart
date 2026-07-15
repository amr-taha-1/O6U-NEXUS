import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/json_asset_loader.dart';
import '../domain/schedule_session.dart';

const _assetPath = 'assets/data/schedule.json';

const _typeByJsonValue = <String, SessionType>{'lecture': SessionType.lecture, 'lab': SessionType.lab};

const _dayByJsonValue = <String, Weekday>{
  'sunday': Weekday.sunday,
  'monday': Weekday.monday,
  'tuesday': Weekday.tuesday,
  'wednesday': Weekday.wednesday,
  'thursday': Weekday.thursday,
};

int _minutesFromClock(String hhmm) {
  final parts = hhmm.split(':');
  return int.parse(parts[0]) * 60 + int.parse(parts[1]);
}

/// Reads the student's real Summer-term weekly schedule from
/// `assets/data/schedule.json` — filtered to their own registered courses
/// and confirmed lecture/lab sections, not the full department timetable.
/// A temporary local data source until October 6 University provides an
/// official API — see docs/Architecture.md "Real data".
class ScheduleRepository {
  const ScheduleRepository();

  Future<List<ScheduleSession>> getSchedule() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    final rows = json['sessions'] as List<dynamic>;
    return [
      for (final row in rows.cast<Map<String, dynamic>>())
        ScheduleSession(
          courseCode: row['courseCode'] as String,
          courseName: row['courseName'] as String,
          type: _typeByJsonValue[row['type'] as String]!,
          day: _dayByJsonValue[row['day'] as String]!,
          startMinutes: _minutesFromClock(row['startTime'] as String),
          endMinutes: _minutesFromClock(row['endTime'] as String),
          room: row['room'] as String,
          instructor: row['instructor'] as String?,
        ),
    ];
  }
}

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) => const ScheduleRepository());

final scheduleProvider = FutureProvider<List<ScheduleSession>>((ref) {
  return ref.watch(scheduleRepositoryProvider).getSchedule();
});
