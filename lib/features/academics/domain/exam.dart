import 'package:flutter/foundation.dart';

/// A single exam entry on the Exam Schedule screen. Not in the design
/// reference — dummy fixture data only, consistent with `coursesProvider`'s
/// five courses.
@immutable
class Exam {
  const Exam({
    required this.courseCode,
    required this.courseName,
    required this.type,
    required this.date,
    required this.time,
    required this.room,
    required this.countdown,
  });

  final String courseCode;
  final String courseName;

  /// e.g. "Midterm", "Final", "Quiz".
  final String type;
  final String date;
  final String time;
  final String room;

  /// e.g. "in 3 days".
  final String countdown;
}
