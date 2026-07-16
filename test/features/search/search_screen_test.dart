import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/schedule/application/schedule_providers.dart';
import 'package:o6u_nexus/features/schedule/data/schedule_repository.dart';
import 'package:o6u_nexus/features/search/application/search_index.dart';
import 'package:o6u_nexus/features/search/presentation/screens/search_screen.dart';
import 'package:o6u_nexus/features/transcript/application/transcript_enrichment.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';

/// Feature 1 (Global Smart Search) — see docs/Architecture.md "Testing" for
/// why every real-data test in a file shares one [ProviderContainer]
/// resolved once in [setUpAll].
late ProviderContainer _container;

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    await _container.read(currentStudentProvider.future);
    await _container.read(transcriptProvider.future);
    await _container.read(transferredCreditsProvider.future);
    await _container.read(enrichedTranscriptProvider.future);
    await _container.read(curriculumProvider.future);
    await _container.read(degreeProgressProvider.future);
    await _container.read(scheduleProvider.future);
    await _container.read(weeklyScheduleProvider.future);
    await _container.read(searchIndexProvider.future);
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

  test('the index includes the real academic advisor, reachable from Home', () async {
    final student = await _container.read(currentStudentProvider.future);
    final results = await _container.read(searchIndexProvider.future);
    final advisorResult = results.firstWhere((r) => r.id == 'profile-advisor');
    expect(advisorResult.title, contains(student.academicAdvisor));
  });

  test('the index ranks a real, currently-registered course under Course Catalog & Bylaw', () async {
    final results = await _container.read(searchIndexProvider.future);
    final dbms2 = results.where((r) => r.title.contains('Database Management Systems 2'));
    expect(dbms2, isNotEmpty);
  });

  testWidgets('shows suggestions and recent searches before typing', (tester) async {
    await pumpReady(tester, const SearchScreen());
    expect(find.text('Search'), findsWidgets);
    expect(find.text('TRY SEARCHING FOR'), findsOneWidget);
    expect(find.text('Transcript'), findsWidgets);
  });

  testWidgets('typing a course name surfaces a ranked, categorized, highlighted result', (tester) async {
    await pumpReady(tester, const SearchScreen());
    await tester.enterText(find.byType(TextField), 'Database Management');
    await tester.pump();
    expect(find.textContaining('Database Management Systems 2'), findsWidgets);
    expect(find.text('COURSE CATALOG & BYLAW'), findsWidgets);
  });
}
