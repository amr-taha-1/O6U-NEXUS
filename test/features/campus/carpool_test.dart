import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/core/theme/theme.dart';
import 'package:o6u_nexus/features/campus/application/current_student_ride_participant.dart';
import 'package:o6u_nexus/features/campus/data/carpool_repository.dart';
import 'package:o6u_nexus/features/campus/domain/ride.dart';
import 'package:o6u_nexus/features/campus/presentation/screens/carpool_screen.dart';
import 'package:o6u_nexus/features/campus/presentation/screens/ride_details_screen.dart';
import 'package:o6u_nexus/shared/data/student_repository.dart';
import 'package:o6u_nexus/shared/domain/student.dart';

/// Feature 3 (University Verified Carpool) — see docs/Architecture.md
/// "Testing" for why every real-data test in a file shares one
/// [ProviderContainer] resolved once in [setUpAll]. Carpool only needs the
/// real [Student] record (for the signed-in student's own ride card); ride
/// listings themselves are seed data with no asset load — see
/// `carpool_repository.dart`.
///
/// Every already-resolved `FutureProvider` value a test needs is read here
/// in [setUpAll] and stashed in a plain variable — never re-awaited inside a
/// `testWidgets` body. `setUpAll` runs in real time, outside the `FakeAsync`
/// zone `testWidgets` wraps its body in; re-awaiting a Future that was
/// *completed* in real time from inside that fake-time zone deadlocks
/// `flutter_test`'s pump machinery instead of resolving immediately as a
/// plain synchronous value would.
late ProviderContainer _container;
late Student _student;

void main() {
  setUpAll(() async {
    _container = ProviderContainer();
    _student = await _container.read(currentStudentProvider.future);
    await _container.read(currentStudentAsRideParticipantProvider.future);
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

  test('rides are split correctly by direction and every ride has an available-seats count', () {
    final toCampus = _container.read(carpoolRidesProvider(RideDirection.toCampus));
    final fromCampus = _container.read(carpoolRidesProvider(RideDirection.fromCampus));
    expect(toCampus, isNotEmpty);
    expect(fromCampus, isNotEmpty);
    expect(toCampus.every((r) => r.direction == RideDirection.toCampus), isTrue);
    expect(fromCampus.every((r) => r.direction == RideDirection.fromCampus), isTrue);
    for (final ride in [...toCampus, ...fromCampus]) {
      expect(ride.availableSeats, ride.maxPassengers - ride.bookedSeats);
    }
  });

  testWidgets("CarpoolScreen renders the real student's own verified card and ranked ride listings", (tester) async {
    await pumpReady(tester, const CarpoolScreen());
    expect(find.text('Carpool'), findsWidgets);
    expect(find.text(_student.name), findsOneWidget);
    expect(find.textContaining('% Match'), findsWidgets);
  });

  testWidgets('RideDetailsScreen renders driver verification, masked ID, trust score, and safety preferences', (tester) async {
    final ride = _container.read(carpoolRepositoryProvider).getRides().first;
    await pumpReady(tester, RideDetailsScreen(rideId: ride.id));
    expect(find.text(ride.driver.fullName), findsOneWidget);
    expect(find.text(ride.driver.maskedStudentId), findsOneWidget);
    expect(find.textContaining('/100'), findsOneWidget);
    expect(find.text('Request to join'), findsOneWidget);
  });
}
