import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/analytics/presentation/screens/academic_analytics_screen.dart';
import 'package:o6u_nexus/features/degree_progress/data/degree_progress_repository.dart';
import 'package:o6u_nexus/features/transcript/data/transcript_repository.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';

/// See docs/Architecture.md "Testing" — smoke test pattern, plus the
/// `flutter_animate` timer-settle note (this screen entrance-animates its
/// sections).
///
/// Racing real asset-bundle I/O (student/transcript/degree-progress JSON)
/// against fake-clock frame pumps is flaky — it depends on how many other
/// tests already ran, not on real time. Pre-resolving the providers on a
/// [ProviderContainer] before the first frame, then handing that same
/// container to the widget tree via [UncontrolledProviderScope], makes the
/// data available synchronously on the very first build instead.
void main() {
  testWidgets('AcademicAnalyticsScreen renders real CGPA, trend, and distribution', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(currentStudentProvider.future);
    await container.read(transcriptProvider.future);
    await container.read(degreeProgressProvider.future);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.dark(), home: const AcademicAnalyticsScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Academic Analytics'), findsWidgets);
    expect(find.text('2.67'), findsWidgets); // real CGPA
    expect(find.textContaining('Fa23 · 1.67'), findsOneWidget); // shortened semester chip
    expect(find.text('REPEATED COURSES'), findsOneWidget); // SectionHeader uppercases its label

    // This screen staggers several `flutter_animate` entrance effects
    // (grade-distribution bars, trend card, etc.) with per-row delays, so a
    // single short pump isn't enough to drain every pending Timer before
    // unmount — give the whole entrance sequence room to finish first.
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
