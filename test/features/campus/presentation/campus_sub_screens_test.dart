import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/campus/presentation/screens/book_exchange_screen.dart';
import 'package:o6u_nexus/features/campus/presentation/screens/freelance_screen.dart';
import 'package:o6u_nexus/features/campus/presentation/screens/internships_screen.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(theme: AppTheme.dark(), home: child),
  );
}

void main() {
  testWidgets('BookExchangeScreen renders its title and listings', (tester) async {
    await tester.pumpWidget(_wrap(const BookExchangeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Book Exchange'), findsWidgets);
    expect(find.text('Data Structures & Algorithms'), findsOneWidget);
  });

  testWidgets('InternshipsScreen renders its title and listings', (tester) async {
    await tester.pumpWidget(_wrap(const InternshipsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Internships'), findsWidgets);
    expect(find.text('Software Engineering Intern'), findsOneWidget);
  });

  testWidgets('FreelanceScreen renders its title and listings', (tester) async {
    await tester.pumpWidget(_wrap(const FreelanceScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Freelance'), findsWidgets);
    expect(find.text('Logo design for student startup'), findsOneWidget);
  });
}
