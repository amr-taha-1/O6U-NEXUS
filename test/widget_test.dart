import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/main.dart';

void main() {
  testWidgets('App boots to splash, then auto-advances to onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: O6uNexusApp()));

    expect(find.text('O6U Nexus'), findsOneWidget);
    expect(find.text('October 6 University'), findsOneWidget);

    // Let the splash screen's auto-navigation timer fire (see AppMotion.splash).
    await tester.pump(const Duration(milliseconds: 1750));
    await tester.pump();

    expect(find.text('Everything campus,\nin one app.'), findsOneWidget);

    // flutter_animate kicks off each `.animate()` with a zero-duration
    // Timer on initState. Give the just-built Onboarding page one more
    // pump so that timer fires and clears before teardown, then unmount
    // the whole tree so nothing is left running.
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
