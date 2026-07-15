import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_session.freezed.dart';

/// The official bylaw rule for reading an instructor's title on the
/// timetable: "د" (Dr.) means the session is a Lecture; "م" (Eng./Demonstrator)
/// means it's a Lab. Stored explicitly per session rather than re-derived
/// from the instructor string everywhere it's needed.
enum SessionType { lecture, lab }

enum Weekday { sunday, monday, tuesday, wednesday, thursday }

/// One weekly class meeting from the real Summer timetable
/// (`assets/data/schedule.json`), filtered to the student's own registered
/// courses and confirmed lecture/lab sections. A temporary local data
/// source until October 6 University provides an official API — see
/// docs/Architecture.md "Real data".
@freezed
abstract class ScheduleSession with _$ScheduleSession {
  const factory ScheduleSession({
    required String courseCode,
    required String courseName,
    required SessionType type,
    required Weekday day,
    /// Minutes since midnight.
    required int startMinutes,
    required int endMinutes,
    required String room,
    String? instructor,
  }) = _ScheduleSession;

  const ScheduleSession._();

  String get startLabel => _formatMinutes(startMinutes);
  String get endLabel => _formatMinutes(endMinutes);
  String get timeRangeLabel => '$startLabel–$endLabel';

  static String _formatMinutes(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '${h12.toString()}:${m.toString().padLeft(2, '0')} $period';
  }
}

extension WeekdayX on Weekday {
  String get label => switch (this) {
    Weekday.sunday => 'Sunday',
    Weekday.monday => 'Monday',
    Weekday.tuesday => 'Tuesday',
    Weekday.wednesday => 'Wednesday',
    Weekday.thursday => 'Thursday',
  };

  /// Maps [DateTime.weekday] (1=Monday..7=Sunday) to the university week
  /// (Sunday through Thursday; Friday/Saturday are the weekend, so they
  /// have no [Weekday] equivalent).
  static Weekday? fromDateTimeWeekday(int dateTimeWeekday) => switch (dateTimeWeekday) {
    7 => Weekday.sunday,
    1 => Weekday.monday,
    2 => Weekday.tuesday,
    3 => Weekday.wednesday,
    4 => Weekday.thursday,
    _ => null,
  };
}
