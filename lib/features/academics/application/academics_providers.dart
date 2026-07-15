import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/assignment.dart';
import '../domain/exam.dart';

/// Screen-local dummy fixtures for Academics' pushed sub-screens. These are
/// small enough, and specific enough to a single screen, that a repository
/// indirection would add no value — same call as
/// `features/home/application/home_providers.dart`'s `todayScheduleProvider`.
///
/// The Schedule screen itself reads real data now — see
/// `features/schedule/`.

/// This semester's GPA — distinct from the student's cumulative GPA.
final semesterGpaProvider = Provider<double>((ref) => 3.24);

/// Overall attendance across all courses (the same 92% cited on Home's
/// "At a glance" grid and the Academics hub's Records subtitle).
final overallAttendanceProvider = Provider<int>((ref) => 92);

final examsProvider = Provider<List<Exam>>((ref) {
  return const [
    Exam(
      courseCode: 'MA201',
      courseName: 'Linear Algebra',
      type: 'Midterm',
      date: 'Tue, 21 Jul',
      time: '09:00',
      room: 'Hall A4',
      countdown: 'in 3 days',
    ),
    Exam(
      courseCode: 'CS402',
      courseName: 'Data Structures',
      type: 'Quiz',
      date: 'Thu, 16 Jul',
      time: '10:30',
      room: 'Hall B2',
      countdown: 'in 2 days',
    ),
    Exam(
      courseCode: 'PH101',
      courseName: 'Physics II',
      type: 'Midterm',
      date: 'Mon, 27 Jul',
      time: '11:00',
      room: 'Hall C1',
      countdown: 'in 2 weeks',
    ),
    Exam(
      courseCode: 'CS310',
      courseName: 'Databases',
      type: 'Final',
      date: 'Sat, 8 Aug',
      time: '09:00',
      room: 'Lab 2',
      countdown: 'in 4 weeks',
    ),
    Exam(
      courseCode: 'EN102',
      courseName: 'Technical Writing',
      type: 'Final',
      date: 'Sun, 9 Aug',
      time: '09:00',
      room: 'Hall D3',
      countdown: 'in 4 weeks',
    ),
  ];
});

final assignmentsProvider = Provider<List<Assignment>>((ref) {
  return const [
    Assignment(
      title: 'Assignment 5',
      courseCode: 'CS402',
      dueLabel: 'Due Sunday',
      status: AssignmentStatus.notSubmitted,
    ),
    Assignment(
      title: 'Problem Set 4',
      courseCode: 'MA201',
      dueLabel: 'Due Wednesday',
      status: AssignmentStatus.notSubmitted,
    ),
    Assignment(
      title: 'Lab Report 3',
      courseCode: 'CS310',
      dueLabel: 'Due Friday',
      status: AssignmentStatus.submitted,
    ),
    Assignment(
      title: 'Lab Worksheet 2',
      courseCode: 'PH101',
      dueLabel: 'Due Monday',
      status: AssignmentStatus.submitted,
    ),
    Assignment(
      title: 'Assignment 4',
      courseCode: 'CS402',
      dueLabel: 'Graded · A',
      status: AssignmentStatus.graded,
    ),
    Assignment(
      title: 'Essay Draft',
      courseCode: 'EN102',
      dueLabel: 'Graded · A-',
      status: AssignmentStatus.graded,
    ),
  ];
});
