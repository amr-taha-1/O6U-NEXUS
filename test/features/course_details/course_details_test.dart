import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/course_details/application/course_details.dart';
import 'package:o6u_nexus/features/course_details/presentation/screens/course_details_screen.dart';
import 'package:o6u_nexus/features/curriculum/application/curriculum_engine.dart';
import 'package:o6u_nexus/features/curriculum/data/curriculum_repository.dart';
import 'package:o6u_nexus/features/transcript/application/transcript_enrichment.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
import 'package:o6u_nexus/shared/data/grade_scale_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';

/// Feature 2 (Course Details) — see docs/Architecture.md "Testing" for why
/// every real-data test in a file shares one [ProviderContainer] resolved
/// once in [setUpAll].
late ProviderContainer _container;

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    await _container.read(currentStudentProvider.future);
    await _container.read(transcriptProvider.future);
    await _container.read(transferredCreditsProvider.future);
    await _container.read(gradeScaleProvider.future);
    await _container.read(enrichedTranscriptProvider.future);
    await _container.read(curriculumProvider.future);
    await _container.read(minCreditHoursForGraduationProjectProvider.future);
    await _container.read(courseEligibilityProvider.future);
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

  group('courseDetailsProvider', () {
    test('a completed transcript course resolves with catalog + attempt data', () async {
      final details = await _container.read(courseDetailsProvider('CSM117').future);
      expect(details, isNotNull);
      expect(details!.name, 'Introduction to Programming');
      expect(details.hasBeenTaken, isTrue);
      expect(details.attempts.single.grade, 'B-');
      expect(details.eligibility?.status, EligibilityStatus.completed);
    });

    test('a currently-registered bylaw course with no transcript entry yet is registered, not eligible or completed', () async {
      final details = await _container.read(courseDetailsProvider('ISM413').future);
      expect(details, isNotNull);
      expect(details!.name, 'Database Management Systems 2');
      expect(details.hasBeenTaken, isFalse);
      expect(details.eligibility?.status, EligibilityStatus.registered);
    });

    test('an unknown code matches no real source and resolves to null', () async {
      final details = await _container.read(courseDetailsProvider('ZZZ999').future);
      expect(details, isNull);
    });
  });

  testWidgets('CourseDetailsScreen renders bylaw info, status, and record for a completed course', (tester) async {
    await pumpReady(tester, const CourseDetailsScreen(code: 'CSM117'));
    expect(find.text('Introduction to Programming'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.textContaining('Fall 2023/2024'), findsOneWidget);
    expect(find.text('B-'), findsWidgets);
  });

  testWidgets('CourseDetailsScreen shows an honest not-found state for an unknown code', (tester) async {
    await pumpReady(tester, const CourseDetailsScreen(code: 'ZZZ999'));
    expect(find.text('Course not found'), findsOneWidget);
  });
}
