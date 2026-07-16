import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/ride.dart';
import '../domain/ride_participant.dart';

/// Seed carpool listings — fictional, feature-demonstration data in the
/// same spirit as [CampusRepository]'s Market/Book Exchange/Internships
/// fixtures: there is no real O6U carpool backend or real classmate data to
/// be faithful to, so this is authored sample content, not a claim about
/// real students. Only the signed-in student's *own* ride participant card
/// (`currentStudentAsRideParticipantProvider`) uses real data. Ready to be
/// swapped for a real repository implementation without touching any
/// screen — see docs/Architecture.md "Real data".
class CarpoolRepository {
  const CarpoolRepository();

  List<Ride> getRides() {
    final today = DateTime.now();
    DateTime at(int hour, int minute, {int dayOffset = 0}) {
      final day = today.add(Duration(days: dayOffset));
      return DateTime(day.year, day.month, day.day, hour, minute);
    }

    const drivers = [
      RideParticipant(
        id: 'drv-yasmin',
        fullName: 'Yasmin Adel',
        faculty: 'Faculty of Engineering',
        department: 'Mechatronics',
        level: 4,
        studentId: '22014521',
        verified: true,
        completedRides: 62,
        averageRating: 4.9,
        cancellations: 1,
        reportsReceived: 0,
      ),
      RideParticipant(
        id: 'drv-kareem',
        fullName: 'Kareem Nabil',
        faculty: 'Faculty of Computer Science and Information Systems',
        department: 'Computer Science',
        level: 3,
        studentId: '23009981',
        verified: true,
        completedRides: 14,
        averageRating: 4.6,
        cancellations: 2,
        reportsReceived: 0,
      ),
      RideParticipant(
        id: 'drv-nour',
        fullName: 'Nour Hassan',
        faculty: 'Faculty of Business Administration',
        department: 'Marketing',
        level: 2,
        studentId: '24003317',
        verified: true,
        completedRides: 3,
        averageRating: 4.2,
        cancellations: 0,
        reportsReceived: 0,
      ),
      RideParticipant(
        id: 'drv-mostafa',
        fullName: 'Mostafa Reda',
        faculty: 'Faculty of Computer Science and Information Systems',
        department: 'Information Systems',
        level: 4,
        studentId: '21017740',
        verified: true,
        completedRides: 108,
        averageRating: 4.95,
        cancellations: 1,
        reportsReceived: 0,
      ),
      RideParticipant(
        id: 'drv-salma',
        fullName: 'Salma Tarek',
        faculty: 'Faculty of Pharmacy',
        department: 'Clinical Pharmacy',
        level: 3,
        studentId: '22011203',
        verified: true,
        completedRides: 27,
        averageRating: 3.9,
        cancellations: 4,
        reportsReceived: 1,
      ),
    ];

    return [
      Ride(
        id: 'ride-1',
        driver: drivers[0],
        direction: RideDirection.toCampus,
        pickupOrDropoffLabel: 'Sheikh Zayed, Zayed 2000',
        distanceKm: 6.5,
        departureTime: at(7, 15),
        maxPassengers: 3,
        bookedSeats: 1,
        genderPreference: GenderPreference.femaleOnly,
        arrivalToleranceMinutes: 10,
        allowsMusic: true,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Hyundai Elantra',
        pickupInstructions: 'Meet at the Zayed 2000 main gate, not inside the compound.',
      ),
      Ride(
        id: 'ride-2',
        driver: drivers[1],
        direction: RideDirection.toCampus,
        pickupOrDropoffLabel: '6 October, Central Axis',
        distanceKm: 3.2,
        departureTime: at(8, 0),
        maxPassengers: 4,
        bookedSeats: 3,
        genderPreference: GenderPreference.noPreference,
        arrivalToleranceMinutes: 15,
        allowsMusic: true,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Chevrolet Aveo',
      ),
      Ride(
        id: 'ride-3',
        driver: drivers[3],
        direction: RideDirection.toCampus,
        pickupOrDropoffLabel: 'Sheikh Zayed, Beverly Hills',
        distanceKm: 8.1,
        departureTime: at(7, 45),
        maxPassengers: 3,
        bookedSeats: 0,
        genderPreference: GenderPreference.noPreference,
        arrivalToleranceMinutes: 5,
        allowsMusic: false,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Toyota Corolla',
        pickupInstructions: 'Waiting by Beverly Hills Gate 3 — please be on time, I leave exactly on schedule.',
      ),
      Ride(
        id: 'ride-4',
        driver: drivers[4],
        direction: RideDirection.toCampus,
        pickupOrDropoffLabel: 'Sheikh Zayed, Green Square',
        distanceKm: 12.4,
        departureTime: at(9, 30),
        maxPassengers: 4,
        bookedSeats: 4,
        genderPreference: GenderPreference.noPreference,
        arrivalToleranceMinutes: 20,
        allowsMusic: true,
        allowsSmoking: true,
        hasAc: false,
      ),
      Ride(
        id: 'ride-5',
        driver: drivers[0],
        direction: RideDirection.fromCampus,
        pickupOrDropoffLabel: 'Sheikh Zayed, Zayed 2000',
        distanceKm: 6.5,
        departureTime: at(15, 30),
        maxPassengers: 3,
        bookedSeats: 0,
        genderPreference: GenderPreference.femaleOnly,
        arrivalToleranceMinutes: 10,
        allowsMusic: true,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Hyundai Elantra',
      ),
      Ride(
        id: 'ride-6',
        driver: drivers[2],
        direction: RideDirection.fromCampus,
        pickupOrDropoffLabel: '6 October, Sun Capital',
        distanceKm: 4.0,
        departureTime: at(14, 0),
        maxPassengers: 2,
        bookedSeats: 1,
        genderPreference: GenderPreference.noPreference,
        arrivalToleranceMinutes: 15,
        allowsMusic: true,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Kia Rio',
      ),
      Ride(
        id: 'ride-7',
        driver: drivers[3],
        direction: RideDirection.fromCampus,
        pickupOrDropoffLabel: 'Sheikh Zayed, Beverly Hills',
        distanceKm: 8.1,
        departureTime: at(16, 15),
        maxPassengers: 3,
        bookedSeats: 1,
        genderPreference: GenderPreference.noPreference,
        arrivalToleranceMinutes: 5,
        allowsMusic: false,
        allowsSmoking: false,
        hasAc: true,
        carModel: 'Toyota Corolla',
      ),
    ];
  }
}

final carpoolRepositoryProvider = Provider<CarpoolRepository>((ref) => const CarpoolRepository());

final carpoolRidesProvider = Provider.family<List<Ride>, RideDirection>((ref, direction) {
  final rides = ref.watch(carpoolRepositoryProvider).getRides();
  return [for (final ride in rides) if (ride.direction == direction) ride];
});

final carpoolRideByIdProvider = Provider.family<Ride?, String>((ref, id) {
  final rides = ref.watch(carpoolRepositoryProvider).getRides();
  for (final ride in rides) {
    if (ride.id == id) return ride;
  }
  return null;
});
