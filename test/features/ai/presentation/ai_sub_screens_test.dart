import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/gpa_simulator_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/graduation_planner_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/lecture_summary_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/resume_builder_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/study_planner_screen.dart';
import 'package:o6u_nexus/shared/data/grade_scale_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';

/// One smoke test per AI pushed sub-screen: pumps the widget inside a
/// [ProviderScope] + [MaterialApp], asserts key content renders, no
/// exceptions. See docs/Architecture.md "Testing".
Future<void> _pump(WidgetTester tester, Widget screen) {
  return tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(theme: AppTheme.dark(), home: screen),
    ),
  );
}

/// [AiMessageBubble] uses `flutter_animate`'s `.animate()`, which kicks off a
/// zero-duration `Timer` on `initState`. Pump once more and unmount before
/// the test ends so that timer fires and clears — see
/// docs/Architecture.md's `flutter_animate` + widget-test note.
Future<void> _settleAnimatedTimers(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
}

/// GpaSimulatorScreen, GraduationPlannerScreen, and ResumeBuilderScreen all
/// read real data via [currentStudentProvider]. They share ONE
/// [ProviderContainer], resolved once in [setUpAll]: `flutter_test`'s
/// asset-bundle platform channel only tolerates a single real disk-backed
/// asset load per isolate — a *second* independent `rootBundle.loadString`
/// call in the same test file hangs forever, regardless of which screen
/// triggers it. Reusing one already-resolved container sidesteps that
/// entirely — see academics_real_data_screens_test.dart's note.
late ProviderContainer _container;

Future<void> _pumpReady(WidgetTester tester, Widget screen) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: _container,
      child: MaterialApp(theme: AppTheme.dark(), home: screen),
    ),
  );
  await tester.pump();
}

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    await _container.read(currentStudentProvider.future);
    await _container.read(gradeScaleProvider.future);
  });

  tearDownAll(() {
    _container.dispose();
  });

  testWidgets('GpaSimulatorScreen renders the projected GPA hero and grade pickers', (tester) async {
    await _pumpReady(tester, const GpaSimulatorScreen());
    expect(find.text('GPA Simulator'), findsWidgets);
    expect(find.text('PROJECTED CUMULATIVE'), findsOneWidget);
    expect(find.text('CS402'), findsOneWidget);
    expect(find.textContaining('MA201'), findsWidgets);
  });

  testWidgets('StudyPlannerScreen renders the week grid and the trust claim', (tester) async {
    await _pump(tester, const StudyPlannerScreen());
    expect(find.text('Study Planner'), findsWidgets);
    expect(find.textContaining('0 conflicts'), findsOneWidget);
    expect(find.text('EXAM'), findsOneWidget);
  });

  testWidgets('GraduationPlannerScreen renders the timeline and bottleneck warning', (tester) async {
    await _pumpReady(tester, const GraduationPlannerScreen());
    expect(find.text('Graduation Planner'), findsWidgets);
    expect(find.textContaining('CS412'), findsOneWidget);
  });

  testWidgets('ResumeBuilderScreen renders the Nexus verdict card and skills', (tester) async {
    await _pumpReady(tester, const ResumeBuilderScreen());
    expect(find.text('Resume Builder'), findsWidgets);
    expect(find.text('Your resume draft is ready.'), findsOneWidget);
    expect(find.text('Export as PDF'), findsOneWidget);
    await _settleAnimatedTimers(tester);
  });

  testWidgets('LectureSummaryScreen renders the Nexus verdict card and key takeaways', (tester) async {
    await _pump(tester, const LectureSummaryScreen());
    expect(find.text('Lecture Summary'), findsWidgets);
    expect(find.textContaining('balanced trees'), findsWidgets);
    await _settleAnimatedTimers(tester);
  });
}
