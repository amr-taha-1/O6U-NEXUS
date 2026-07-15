import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/assignments_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/attendance_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/exam_schedule_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/grades_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/schedule_screen.dart';

/// One smoke test per Academics pushed sub-screen: pumps the widget inside a
/// [ProviderScope] + [MaterialApp], asserts key content renders, no
/// exceptions. See docs/Architecture.md "Testing".
///
/// TranscriptScreen and GraduationScreen (real-data screens) live in their
/// own file (academics_real_data_screens_test.dart). `flutter_test`'s
/// asset-bundle platform channel only tolerates one real disk-backed asset
/// load per isolate — GradesScreen's real `currentStudentProvider` read
/// would be the first, and a *second* one (Transcript/Graduation) in the
/// same isolate never resolves. Splitting the files sidesteps that
/// flutter_test-only interaction — see academics_real_data_screens_test.dart
/// and docs/Architecture.md "Testing".
Future<void> _pump(WidgetTester tester, Widget screen) {
  return tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(theme: AppTheme.dark(), home: screen),
    ),
  );
}

void main() {
  testWidgets('ScheduleScreen renders the week and room-change footer', (tester) async {
    await _pump(tester, const ScheduleScreen());
    expect(find.text('Schedule'), findsWidgets);
    expect(find.textContaining('Two rooms changed this week'), findsOneWidget);
  });

  testWidgets('ExamScheduleScreen renders the upcoming exam list', (tester) async {
    await _pump(tester, const ExamScheduleScreen());
    expect(find.text('Exam Schedule'), findsWidgets);
    expect(find.textContaining('Linear Algebra'), findsOneWidget);
  });

  testWidgets('GradesScreen renders semester and cumulative GPA', (tester) async {
    await _pump(tester, const GradesScreen());
    expect(find.text('Grades'), findsWidgets);
    expect(find.text('Semester GPA'), findsOneWidget);
    expect(find.text('3.24'), findsOneWidget);
  });

  testWidgets('AttendanceScreen renders the overall ring and at-risk warning', (tester) async {
    await _pump(tester, const AttendanceScreen());
    expect(find.text('Attendance'), findsWidgets);
    expect(find.textContaining('overall'), findsOneWidget);
    expect(find.textContaining('MA201'), findsWidgets);
  });

  testWidgets('AssignmentsScreen renders CS402 Assignment 5', (tester) async {
    await _pump(tester, const AssignmentsScreen());
    expect(find.text('Assignments'), findsWidgets);
    expect(find.text('Assignment 5'), findsOneWidget);
  });
}
