import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/domain.dart';
import '../domain/assignment.dart';
import '../domain/exam.dart';

/// Screen-local dummy fixtures for Academics' pushed sub-screens. These are
/// small enough, and specific enough to a single screen, that a repository
/// indirection would add no value — same call as
/// `features/home/application/home_providers.dart`'s `todayScheduleProvider`.

/// One tile in the Schedule screen's week strip.
class WeekDay {
  const WeekDay({required this.label, required this.date, required this.isToday});
  final String label;
  final int date;
  final bool isToday;
}

final weekStripProvider = Provider<List<WeekDay>>((ref) {
  const labels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  return [for (var i = 0; i < labels.length; i++) WeekDay(label: labels[i], date: 11 + i, isToday: i == 1)];
});

/// The week's day rows, reusing [ScheduleItem]'s shape (see
/// `home_providers.dart`'s `todayScheduleProvider`) even though the
/// Schedule screen renders it with an accent bar rather than a dot timeline.
final weekScheduleProvider = Provider<List<ScheduleItem>>((ref) {
  final c = AppColors.dark;
  return [
    ScheduleItem(
      time: '09:00',
      title: 'EN102 Â· Technical Writing',
      meta: 'Hall D3 Â· Dr. Nadia',
      accent: c.info,
      icon: CupertinoIcons.book,
      kind: ScheduleItemKind.lecture,
    ),
    ScheduleItem(
      time: '10:30',
      title: 'CS402 Â· Data Structures',
      meta: 'Hall A1 Â· moved Â· Dr. Hesham',
      accent: c.accent,
      icon: CupertinoIcons.book,
      kind: ScheduleItemKind.lecture,
    ),
    ScheduleItem(
      time: '12:30',
      title: 'Free Â· Nexus placed revision',
      meta: 'Library Room 4',
      accent: c.success,
      icon: CupertinoIcons.sparkles,
      kind: ScheduleItemKind.freeBlock,
    ),
    ScheduleItem(
      time: '15:30',
      title: 'MA201 Â· Lab',
      meta: 'Lab 4 Â· Eng. Omar',
      accent: c.warning,
      icon: CupertinoIcons.exclamationmark_triangle,
      kind: ScheduleItemKind.lab,
    ),
  ];
});

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
      dueLabel: 'Graded Â· A',
      status: AssignmentStatus.graded,
    ),
    Assignment(
      title: 'Essay Draft',
      courseCode: 'EN102',
      dueLabel: 'Graded Â· A-',
      status: AssignmentStatus.graded,
    ),
  ];
});

/// Level 1-3 done, Level 4 now, Summer advised, Graduation forecast — ports
/// the reference's `GradPlanner` `steps` array.
final graduationStepsProvider = Provider<List<GraduationStep>>((ref) {
  final c = AppColors.dark;
  return [
    GraduationStep(title: 'Level 1', subtitle: '30 hrs', statusLabel: 'Done', status: GraduationStepStatus.done, accent: c.success),
    GraduationStep(title: 'Level 2', subtitle: '32 hrs', statusLabel: 'Done', status: GraduationStepStatus.done, accent: c.success),
    GraduationStep(title: 'Level 3', subtitle: '30 hrs', statusLabel: 'Done', status: GraduationStepStatus.done, accent: c.success),
    GraduationStep(title: 'Level 4', subtitle: '18 hrs', statusLabel: 'Now', status: GraduationStepStatus.now, accent: c.accent),
    GraduationStep(title: 'Summer', subtitle: '6 hrs', statusLabel: 'Advised', status: GraduationStepStatus.advised, accent: c.warning),
    GraduationStep(title: 'Graduation', subtitle: 'Aug 2027', statusLabel: '96%', status: GraduationStepStatus.forecast, accent: c.info),
  ];
});
