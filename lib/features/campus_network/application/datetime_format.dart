/// Hand-rolled date/time labels — not `intl.DateFormat`. See
/// `Ride.departureTimeLabel`'s doc comment in `features/campus/domain/ride.dart`
/// for why: no locale-data initialization footgun, and it's proven safe
/// under `flutter_test`.
const _weekdayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', // ignore: prefer_adjacent_string_concatenation
];

String formatTimeOfDay(DateTime time) {
  final h = time.hour;
  final m = time.minute;
  final period = h >= 12 ? 'PM' : 'AM';
  final h12 = h % 12 == 0 ? 12 : h % 12;
  return '$h12:${m.toString().padLeft(2, '0')} $period';
}

String formatWeekdayName(DateTime time) => _weekdayNames[time.weekday - 1];

String formatShortDate(DateTime time) => '${_monthNames[time.month - 1]} ${time.day}';
