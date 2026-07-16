import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/ai/application/graduation_planner_providers.dart';
import 'package:o6u_nexus/features/ai/application/resume_builder_providers.dart';
import 'package:o6u_nexus/features/ai/application/study_planner_providers.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/gpa_simulator_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/graduation_planner_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/lecture_summary_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/resume_builder_screen.dart';
import 'package:o6u_nexus/features/ai/presentation/screens/study_planner_screen.dart';
import 'package:o6u_nexus/features/curriculum/application/curriculum_engine.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/schedule/application/schedule_providers.dart';
import 'package:o6u_nexus/features/schedule/data/schedule_repository.dart';
import 'package:o6u_nexus/features/transcript/application/transcript_enrichment.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
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

/// GpaSimulatorScreen, GraduationPlannerScreen, ResumeBuilderScreen, and
/// StudyPlannerScreen all read real data (schedule, transcript, bylaw,
/// degree progress). They share ONE [ProviderContainer], resolved once in
/// [setUpAll] — see academics_real_data_screens_test.dart's note and
/// carpool_test.dart's doc comment for why nothing here re-awaits an
/// already-resolved container future inside a `testWidgets` body.
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
    await _container.read(transcriptProvider.future);
    await _container.read(transferredCreditsProvider.future);
    await _container.read(enrichedTranscriptProvider.future);
    await _container.read(curriculumProvider.future);
    await _container.read(minCreditHoursForGraduationProjectProvider.future);
    await _container.read(scheduleProvider.future);
    await _container.read(weeklyScheduleProvider.future);
    await _container.read(nextSessionProvider.future);
    await _container.read(courseEligibilityProvider.future);
    await _container.read(currentlyRegisteredCoursesProvider.future);
    await _container.read(lockedCoursesProvider.future);
    await _container.read(estimatedRemainingSemestersProvider.future);
    await _container.read(degreeProgressProvider.future);
    await _container.read(aiGraduationStepsProvider.future);
    await _container.read(studyBlocksProvider.future);
    await _container.read(resumeVerdictProvider.future);
    await _container.read(resumeSkillCourseNamesProvider.future);
  });

  tearDownAll(() {
    _container.dispose();
  });

  testWidgets('GpaSimulatorScreen renders the projected GPA hero and real registered courses', (tester) async {
    await _pumpReady(tester, const GpaSimulatorScreen());
    expect(find.text('GPA Simulator'), findsWidgets);
    expect(find.text('PROJECTED CUMULATIVE'), findsOneWidget);
    // The real currently-registered courses, not the fictional CS402/MA201.
    expect(find.text('ISM413'), findsOneWidget);
    expect(find.text('ISM424'), findsOneWidget);
    expect(find.text('ISE326A'), findsOneWidget);
  });

  testWidgets('StudyPlannerScreen renders the real weekly lecture/lab grid', (tester) async {
    await _pumpReady(tester, const StudyPlannerScreen());
    expect(find.text('Study Planner'), findsWidgets);
    // Real course codes from the real timetable populate the grid cells.
    expect(find.text('ISM413'), findsWidgets);
    expect(find.text('No automatic study-block placement yet'), findsOneWidget);
  });

  testWidgets('GraduationPlannerScreen renders the real degree-progress path, no fabricated bottleneck', (tester) async {
    await _pumpReady(tester, const GraduationPlannerScreen());
    expect(find.text('Graduation Planner'), findsWidgets);
    expect(find.text('Department Mandatory'), findsOneWidget);
    // The old fabricated "CS412" bottleneck course never existed in the
    // real bylaw and must be gone.
    expect(find.textContaining('CS412'), findsNothing);
  });

  testWidgets('ResumeBuilderScreen renders the real major, not a fabricated "Computer Science" claim', (tester) async {
    await _pumpReady(tester, const ResumeBuilderScreen());
    expect(find.text('Resume Builder'), findsWidgets);
    expect(find.text('Your resume draft is ready.'), findsOneWidget);
    expect(find.textContaining('Information Systems'), findsWidgets);
    expect(find.textContaining('Computer Science'), findsNothing);
    expect(find.text('Export as PDF'), findsOneWidget);
    await _settleAnimatedTimers(tester);
  });

  testWidgets('LectureSummaryScreen is honest about having no real lecture source connected', (tester) async {
    await _pump(tester, const LectureSummaryScreen());
    expect(find.text('Lecture Summary'), findsWidgets);
    expect(find.textContaining('No lecture recording or CMS source'), findsOneWidget);
    // The old fabricated "balanced trees" CS402 content must be gone.
    expect(find.textContaining('balanced trees'), findsNothing);
    await _settleAnimatedTimers(tester);
  });
}
