import 'package:freezed_annotation/freezed_annotation.dart';

import 'ride_participant.dart';

part 'ride.freezed.dart';

/// Which leg of the campus commute this ride covers. One endpoint of every
/// O6U carpool ride is always October 6 University itself — see
/// [Ride.originLabel]/[Ride.destinationLabel] — the student only ever picks
/// the *other* end, per the "Campus Only" rule.
enum RideDirection { toCampus, fromCampus }

extension RideDirectionX on RideDirection {
  String get label => switch (this) {
        RideDirection.toCampus => 'To Campus',
        RideDirection.fromCampus => 'From Campus',
      };
}

enum GenderPreference { noPreference, maleOnly, femaleOnly }

extension GenderPreferenceX on GenderPreference {
  String get label => switch (this) {
        GenderPreference.noPreference => 'No Preference',
        GenderPreference.maleOnly => 'Male Only',
        GenderPreference.femaleOnly => 'Female Only',
      };
}

/// One O6U-exclusive carpool offer. Every field the driver actually
/// configures for the ride lives here (seats, safety preferences, car
/// comfort); everything about *who* the driver is lives on [driver]
/// ([RideParticipant]), which is where verification and trust live so they
/// aren't duplicated per ride.
@freezed
abstract class Ride with _$Ride {
  const factory Ride({
    required String id,
    required RideParticipant driver,
    required RideDirection direction,
    /// The one end of the trip the student actually picks — a pickup point
    /// for [RideDirection.toCampus], a drop-off point for
    /// [RideDirection.fromCampus]. The other end is always O6U.
    required String pickupOrDropoffLabel,
    /// Straight-line distance in km between [pickupOrDropoffLabel] and
    /// campus — seed/demo data (no real geocoding backend exists yet), used
    /// only to rank matches, never shown as a guaranteed real distance.
    required double distanceKm,
    required DateTime departureTime,
    required int maxPassengers,
    required int bookedSeats,
    required GenderPreference genderPreference,
    required int arrivalToleranceMinutes,
    required bool allowsMusic,
    required bool allowsSmoking,
    required bool hasAc,
    String? pickupInstructions,
    String? carModel,
    String? notes,
  }) = _Ride;

  const Ride._();

  String get originLabel => direction == RideDirection.toCampus ? pickupOrDropoffLabel : 'October 6 University';
  String get destinationLabel => direction == RideDirection.toCampus ? 'October 6 University' : pickupOrDropoffLabel;
  int get availableSeats => maxPassengers - bookedSeats;
  bool get isFull => availableSeats <= 0;

  /// Hand-rolled, not `intl.DateFormat` — see `ScheduleSession.timeRangeLabel`
  /// for the same convention and why (no locale-data initialization needed).
  String get departureTimeLabel {
    final h = departureTime.hour;
    final m = departureTime.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:${m.toString().padLeft(2, '0')} $period';
  }

  static const _weekdayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  String get departureDayLabel => _weekdayNames[departureTime.weekday - 1];
}
