import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/graduation_screen.dart';
import 'package:o6u_nexus/features/academics/presentation/screens/transcript_screen.dart';
import 'package:o6u_nexus/features/curriculum/application/curriculum_engine.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/curriculum/presentation/screens/course_catalog_screen.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
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
  });

  testWidgets('GraduationScreen renders the real degree-audit breakdown', (tester) async {
    await pumpReady(tester, const GraduationScreen());
    expect(find.text('Degree Progress'), findsWidgets);
    expect(find.textContaining('Department Mandatory'), findsOneWidget);
    expect(find.textContaining('91 of 144 hours'), findsOneWidget);
  });

  testWidgets('CourseCatalogScreen computes real eligibility from the transcript and bylaw', (tester) async {
    await pumpReady(tester, const CourseCatalogScreen());
    expect(find.text('Course Catalog'), findsWidgets);
    // Independently derived from the real transcript + bylaw prerequisites —
    // matches the student's actual registered summer courses.
    expect(find.text('Knowledge Management'), findsOneWidget);
    expect(find.text('Database Management Systems 2'), findsOneWidget);
    // Locked: Computer Networks (NTM313) hasn't been passed yet, so it gates
    // several later courses — appears as a missing-prerequisite chip more
    // than once.
    expect(find.text('Computer Networks'), findsWidgets);
  });
}
