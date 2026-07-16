import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/academics_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/graduation_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/schedule_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/transcript_screen.dart';
import 'package:o6u_nexus/features/curriculum/application/curriculum_engine.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/curriculum/presentation/screens/course_catalog_screen.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/schedule/application/schedule_providers.dart';
import 'package:o6u_nexus/features/schedule/data/schedule_repository.dart';
import 'package:o6u_nexus/features/transcript/application/transcript_enrichment.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
import 'package:o6u_nexus/shared/data/grade_scale_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';

/// Smoke tests for the Academics screens that read real data via
/// `FutureProvider`s (student, transcript, degree progress — see
/// docs/Architecture.md "Real data").
///
/// All tests in this file share ONE [ProviderContainer], resolved once in
/// [setUpAll]. `flutter_test`'s asset-bundle platform channel only tolerates
/// a single real disk-backed asset load per isolate — a *second* independent
/// `rootBundle.loadString` call in the same test file hangs forever,
/// regardless of which screen triggers it. Reusing one already-resolved
/// container sidesteps that entirely: only the first read ever touches disk.
late ProviderContainer _container;

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    await _container.read(currentStudentProvider.future);
    await _container.read(transcriptProvider.future);
    await _container.read(degreeProgressProvider.future);
    await _container.read(curriculumProvider.future);
    await _container.read(minCreditHoursForGraduationProjectProvider.future);
    await _container.read(courseEligibilityProvider.future);
    await _container.read(estimatedRemainingSemestersProvider.future);
    await _container.read(scheduleProvider.future);
    await _container.read(weeklyScheduleProvider.future);
    await _container.read(nextSessionProvider.future);
    await _container.read(minutesUntilNextSessionProvider.future);
    await _container.read(gradeScaleProvider.future);
    await _container.read(enrichedTranscriptProvider.future);
    await _container.read(transferredCreditsProvider.future);
  });

  tearDownAll(() {
    _container.dispose();
  });

  Future<void> pumpReady(WidgetTester tester, Widget screen) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: _container,
        child: MaterialApp(theme: AppTheme.dark(), home: screen),
      ),
    );
    await tester.pump();
  }

  testWidgets('TranscriptScreen renders the real cumulative GPA and semesters', (tester) async {
    await pumpReady(tester, const TranscriptScreen());
    expect(find.text('Transcript'), findsWidgets);
    expect(find.text('Export official PDF'), findsOneWidget);
    expect(find.text('2.67'), findsWidgets); // real CGPA
    expect(find.textContaining('Fall 2023/2024'), findsOneWidget);
    // Transferred Credits: a distinct section above the semester list.
    expect(find.text('TRANSFERRED CREDITS'), findsOneWidget); // SectionHeader uppercases
    expect(find.text('Mathematics I'), findsOneWidget);
    expect(find.text('Mathematics II'), findsOneWidget);
    // Backfilled from the bylaw + grade scale — Marketing & Digital Strategy
    // (URM122, 2 hrs) graded A in Spring 2023/2024 had no stored points;
    // 2 x 4.0 = 8.0, computed live rather than shown as "—".
    expect(find.text('8.0'), findsOneWidget);
  });

  testWidgets('AcademicsScreen shows the real latest semester, not the earliest', (tester) async {
    await pumpReady(tester, const AcademicsScreen());
    expect(find.text('Academics'), findsWidgets);
    // The transcript's latest entry is Spring 2025/2026 — must show that,
    // never the first semester on record (Fall 2023/2024).
    expect(find.text('SPRING 2025/2026'), findsOneWidget); // SectionHeader uppercases
    expect(find.text('Information Systems'), findsOneWidget); // a Spring 2025/2026 course
    expect(find.textContaining('Fall 2023/2024'), findsNothing);
  });

  testWidgets('GraduationScreen renders the real degree-audit breakdown', (tester) async {
    await pumpReady(tester, const GraduationScreen());
    expect(find.text('Degree Progress'), findsWidgets);
    expect(find.textContaining('Department Mandatory'), findsOneWidget);
    expect(find.textContaining('91 of 144 hours'), findsOneWidget);
  });

  testWidgets('ScheduleScreen renders the real weekly timetable with lecture/lab distinction', (tester) async {
    await pumpReady(tester, const ScheduleScreen());
    expect(find.text('Schedule'), findsWidgets);
    // All three registered courses appear (9 credit hours total — the
    // schedule isn't hardcoded to two courses).
    expect(find.text('Geographic Information System'), findsWidgets);
    expect(find.text('Knowledge Management'), findsWidgets);
    expect(find.text('Database Management Systems 2'), findsWidgets);
    expect(find.text('Sunday'), findsOneWidget);
    expect(find.text('Wednesday'), findsOneWidget);
    expect(find.text('Lecture'), findsWidgets);
    expect(find.text('Lab'), findsWidgets);
    // Instructor names, transliterated from the official Arabic timetable.
    // `findsWidgets` (not `findsOneWidget`): whichever session is
    // chronologically "next" at test-run time also renders in the hero
    // "NEXT UP" card in addition to its place in the day list, so any
    // instructor's name can legitimately appear twice depending on the
    // real wall-clock time the suite runs at.
    expect(find.text('Dr. Ayman Hassanein'), findsWidgets); // GIS lecture + DBMS2 lecture
    expect(find.text('Eng. Mohamed Kamal'), findsWidgets);
    expect(find.text('Dr. Mohamed Eissa'), findsWidgets);
    expect(find.text('Eng. Shady Badeer'), findsWidgets);
    expect(find.text('Eng. Ahmed Khaled'), findsWidgets);
  });

  testWidgets('CourseCatalogScreen computes real eligibility from the transcript and bylaw', (tester) async {
    await pumpReady(tester, const CourseCatalogScreen());
    expect(find.text('Course Catalog'), findsWidgets);
    // The student's actual registered summer courses show under "Currently
    // registered this term" — never under "Eligible to register next"
    // (registering for something you're already taking makes no sense).
    expect(find.text('CURRENTLY REGISTERED THIS TERM'), findsOneWidget); // SectionHeader uppercases
    expect(find.text('Knowledge Management'), findsOneWidget);
    expect(find.text('Database Management Systems 2'), findsOneWidget);
    // Elective 2, for this specialization, IS Geographic Information System
    // — the bylaw's ISE326A entry, not a separate "Elective 2" placeholder.
    expect(find.text('Geographic Information System (Elective 2)'), findsOneWidget);
    // Locked: Computer Networks (NTM313) hasn't been passed yet, so it gates
    // several later courses — appears as a missing-prerequisite chip more
    // than once.
    expect(find.text('Computer Networks'), findsWidgets);
  });
}
