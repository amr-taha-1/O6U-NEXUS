import 'package:flutter/foundation.dart';

enum AssignmentStatus { notSubmitted, submitted, graded }

extension AssignmentStatusX on AssignmentStatus {
  String get label => switch (this) {
        AssignmentStatus.notSubmitted => 'Not submitted',
        AssignmentStatus.submitted => 'Submitted',
        AssignmentStatus.graded => 'Graded',
      };
}

/// A single assignment on the Assignments screen. Not in the design
/// reference � mirrors the "Materials" list pattern from
/// `course_details_sheet.dart` across all of a student's courses.
@immutable
class Assignment {
  const Assignment({
    required this.title,
    required this.courseCode,
    required this.dueLabel,
    required this.status,
  });

  final String title;
  final String courseCode;

  /// e.g. "Due Sunday", "Graded · A-".
  final String dueLabel;
  final AssignmentStatus status;
}
