// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Ride {
  String get id => throw _privateConstructorUsedError;
  RideParticipant get driver => throw _privateConstructorUsedError;
  RideDirection get direction => throw _privateConstructorUsedError;

  /// The one end of the trip the student actually picks — a pickup point
  /// for [RideDirection.toCampus], a drop-off point for
  /// [RideDirection.fromCampus]. The other end is always O6U.
  String get pickupOrDropoffLabel => throw _privateConstructorUsedError;

  /// Straight-line distance in km between [pickupOrDropoffLabel] and
  /// campus — seed/demo data (no real geocoding backend exists yet), used
  /// only to rank matches, never shown as a guaranteed real distance.
  double get distanceKm => throw _privateConstructorUsedError;
  DateTime get departureTime => throw _privateConstructorUsedError;
  int get maxPassengers => throw _privateConstructorUsedError;
  int get bookedSeats => throw _privateConstructorUsedError;
  GenderPreference get genderPreference => throw _privateConstructorUsedError;
  int get arrivalToleranceMinutes => throw _privateConstructorUsedError;
  bool get allowsMusic => throw _privateConstructorUsedError;
  bool get allowsSmoking => throw _privateConstructorUsedError;
  bool get hasAc => throw _privateConstructorUsedError;
  String? get pickupInstructions => throw _privateConstructorUsedError;
  String? get carModel => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RideCopyWith<Ride> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RideCopyWith<$Res> {
  factory $RideCopyWith(Ride value, $Res Function(Ride) then) =
      _$RideCopyWithImpl<$Res, Ride>;
  @useResult
  $Res call({
    String id,
    RideParticipant driver,
    RideDirection direction,
    String pickupOrDropoffLabel,
    double distanceKm,
    DateTime departureTime,
    int maxPassengers,
    int bookedSeats,
    GenderPreference genderPreference,
    int arrivalToleranceMinutes,
    bool allowsMusic,
    bool allowsSmoking,
    bool hasAc,
    String? pickupInstructions,
    String? carModel,
    String? notes,
  });

  $RideParticipantCopyWith<$Res> get driver;
}

/// @nodoc
class _$RideCopyWithImpl<$Res, $Val extends Ride>
    implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? direction = null,
    Object? pickupOrDropoffLabel = null,
    Object? distanceKm = null,
    Object? departureTime = null,
    Object? maxPassengers = null,
    Object? bookedSeats = null,
    Object? genderPreference = null,
    Object? arrivalToleranceMinutes = null,
    Object? allowsMusic = null,
    Object? allowsSmoking = null,
    Object? hasAc = null,
    Object? pickupInstructions = freezed,
    Object? carModel = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            driver: null == driver
                ? _value.driver
                : driver // ignore: cast_nullable_to_non_nullable
                      as RideParticipant,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as RideDirection,
            pickupOrDropoffLabel: null == pickupOrDropoffLabel
                ? _value.pickupOrDropoffLabel
                : pickupOrDropoffLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            departureTime: null == departureTime
                ? _value.departureTime
                : departureTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            maxPassengers: null == maxPassengers
                ? _value.maxPassengers
                : maxPassengers // ignore: cast_nullable_to_non_nullable
                      as int,
            bookedSeats: null == bookedSeats
                ? _value.bookedSeats
                : bookedSeats // ignore: cast_nullable_to_non_nullable
                      as int,
            genderPreference: null == genderPreference
                ? _value.genderPreference
                : genderPreference // ignore: cast_nullable_to_non_nullable
                      as GenderPreference,
            arrivalToleranceMinutes: null == arrivalToleranceMinutes
                ? _value.arrivalToleranceMinutes
                : arrivalToleranceMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            allowsMusic: null == allowsMusic
                ? _value.allowsMusic
                : allowsMusic // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowsSmoking: null == allowsSmoking
                ? _value.allowsSmoking
                : allowsSmoking // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasAc: null == hasAc
                ? _value.hasAc
                : hasAc // ignore: cast_nullable_to_non_nullable
                      as bool,
            pickupInstructions: freezed == pickupInstructions
                ? _value.pickupInstructions
                : pickupInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            carModel: freezed == carModel
                ? _value.carModel
                : carModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RideParticipantCopyWith<$Res> get driver {
    return $RideParticipantCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RideImplCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$$RideImplCopyWith(
    _$RideImpl value,
    $Res Function(_$RideImpl) then,
  ) = __$$RideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    RideParticipant driver,
    RideDirection direction,
    String pickupOrDropoffLabel,
    double distanceKm,
    DateTime departureTime,
    int maxPassengers,
    int bookedSeats,
    GenderPreference genderPreference,
    int arrivalToleranceMinutes,
    bool allowsMusic,
    bool allowsSmoking,
    bool hasAc,
    String? pickupInstructions,
    String? carModel,
    String? notes,
  });

  @override
  $RideParticipantCopyWith<$Res> get driver;
}

/// @nodoc
class __$$RideImplCopyWithImpl<$Res>
    extends _$RideCopyWithImpl<$Res, _$RideImpl>
    implements _$$RideImplCopyWith<$Res> {
  __$$RideImplCopyWithImpl(_$RideImpl _value, $Res Function(_$RideImpl) _then)
    : super(_value, _then);

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? direction = null,
    Object? pickupOrDropoffLabel = null,
    Object? distanceKm = null,
    Object? departureTime = null,
    Object? maxPassengers = null,
    Object? bookedSeats = null,
    Object? genderPreference = null,
    Object? arrivalToleranceMinutes = null,
    Object? allowsMusic = null,
    Object? allowsSmoking = null,
    Object? hasAc = null,
    Object? pickupInstructions = freezed,
    Object? carModel = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$RideImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        driver: null == driver
            ? _value.driver
            : driver // ignore: cast_nullable_to_non_nullable
                  as RideParticipant,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as RideDirection,
        pickupOrDropoffLabel: null == pickupOrDropoffLabel
            ? _value.pickupOrDropoffLabel
            : pickupOrDropoffLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        departureTime: null == departureTime
            ? _value.departureTime
            : departureTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        maxPassengers: null == maxPassengers
            ? _value.maxPassengers
            : maxPassengers // ignore: cast_nullable_to_non_nullable
                  as int,
        bookedSeats: null == bookedSeats
            ? _value.bookedSeats
            : bookedSeats // ignore: cast_nullable_to_non_nullable
                  as int,
        genderPreference: null == genderPreference
            ? _value.genderPreference
            : genderPreference // ignore: cast_nullable_to_non_nullable
                  as GenderPreference,
        arrivalToleranceMinutes: null == arrivalToleranceMinutes
            ? _value.arrivalToleranceMinutes
            : arrivalToleranceMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        allowsMusic: null == allowsMusic
            ? _value.allowsMusic
            : allowsMusic // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowsSmoking: null == allowsSmoking
            ? _value.allowsSmoking
            : allowsSmoking // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasAc: null == hasAc
            ? _value.hasAc
            : hasAc // ignore: cast_nullable_to_non_nullable
                  as bool,
        pickupInstructions: freezed == pickupInstructions
            ? _value.pickupInstructions
            : pickupInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        carModel: freezed == carModel
            ? _value.carModel
            : carModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RideImpl extends _Ride {
  const _$RideImpl({
    required this.id,
    required this.driver,
    required this.direction,
    required this.pickupOrDropoffLabel,
    required this.distanceKm,
    required this.departureTime,
    required this.maxPassengers,
    required this.bookedSeats,
    required this.genderPreference,
    required this.arrivalToleranceMinutes,
    required this.allowsMusic,
    required this.allowsSmoking,
    required this.hasAc,
    this.pickupInstructions,
    this.carModel,
    this.notes,
  }) : super._();

  @override
  final String id;
  @override
  final RideParticipant driver;
  @override
  final RideDirection direction;

  /// The one end of the trip the student actually picks — a pickup point
  /// for [RideDirection.toCampus], a drop-off point for
  /// [RideDirection.fromCampus]. The other end is always O6U.
  @override
  final String pickupOrDropoffLabel;

  /// Straight-line distance in km between [pickupOrDropoffLabel] and
  /// campus — seed/demo data (no real geocoding backend exists yet), used
  /// only to rank matches, never shown as a guaranteed real distance.
  @override
  final double distanceKm;
  @override
  final DateTime departureTime;
  @override
  final int maxPassengers;
  @override
  final int bookedSeats;
  @override
  final GenderPreference genderPreference;
  @override
  final int arrivalToleranceMinutes;
  @override
  final bool allowsMusic;
  @override
  final bool allowsSmoking;
  @override
  final bool hasAc;
  @override
  final String? pickupInstructions;
  @override
  final String? carModel;
  @override
  final String? notes;

  @override
  String toString() {
    return 'Ride(id: $id, driver: $driver, direction: $direction, pickupOrDropoffLabel: $pickupOrDropoffLabel, distanceKm: $distanceKm, departureTime: $departureTime, maxPassengers: $maxPassengers, bookedSeats: $bookedSeats, genderPreference: $genderPreference, arrivalToleranceMinutes: $arrivalToleranceMinutes, allowsMusic: $allowsMusic, allowsSmoking: $allowsSmoking, hasAc: $hasAc, pickupInstructions: $pickupInstructions, carModel: $carModel, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.pickupOrDropoffLabel, pickupOrDropoffLabel) ||
                other.pickupOrDropoffLabel == pickupOrDropoffLabel) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.maxPassengers, maxPassengers) ||
                other.maxPassengers == maxPassengers) &&
            (identical(other.bookedSeats, bookedSeats) ||
                other.bookedSeats == bookedSeats) &&
            (identical(other.genderPreference, genderPreference) ||
                other.genderPreference == genderPreference) &&
            (identical(
                  other.arrivalToleranceMinutes,
                  arrivalToleranceMinutes,
                ) ||
                other.arrivalToleranceMinutes == arrivalToleranceMinutes) &&
            (identical(other.allowsMusic, allowsMusic) ||
                other.allowsMusic == allowsMusic) &&
            (identical(other.allowsSmoking, allowsSmoking) ||
                other.allowsSmoking == allowsSmoking) &&
            (identical(other.hasAc, hasAc) || other.hasAc == hasAc) &&
            (identical(other.pickupInstructions, pickupInstructions) ||
                other.pickupInstructions == pickupInstructions) &&
            (identical(other.carModel, carModel) ||
                other.carModel == carModel) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    driver,
    direction,
    pickupOrDropoffLabel,
    distanceKm,
    departureTime,
    maxPassengers,
    bookedSeats,
    genderPreference,
    arrivalToleranceMinutes,
    allowsMusic,
    allowsSmoking,
    hasAc,
    pickupInstructions,
    carModel,
    notes,
  );

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RideImplCopyWith<_$RideImpl> get copyWith =>
      __$$RideImplCopyWithImpl<_$RideImpl>(this, _$identity);
}

abstract class _Ride extends Ride {
  const factory _Ride({
    required final String id,
    required final RideParticipant driver,
    required final RideDirection direction,
    required final String pickupOrDropoffLabel,
    required final double distanceKm,
    required final DateTime departureTime,
    required final int maxPassengers,
    required final int bookedSeats,
    required final GenderPreference genderPreference,
    required final int arrivalToleranceMinutes,
    required final bool allowsMusic,
    required final bool allowsSmoking,
    required final bool hasAc,
    final String? pickupInstructions,
    final String? carModel,
    final String? notes,
  }) = _$RideImpl;
  const _Ride._() : super._();

  @override
  String get id;
  @override
  RideParticipant get driver;
  @override
  RideDirection get direction;

  /// The one end of the trip the student actually picks — a pickup point
  /// for [RideDirection.toCampus], a drop-off point for
  /// [RideDirection.fromCampus]. The other end is always O6U.
  @override
  String get pickupOrDropoffLabel;

  /// Straight-line distance in km between [pickupOrDropoffLabel] and
  /// campus — seed/demo data (no real geocoding backend exists yet), used
  /// only to rank matches, never shown as a guaranteed real distance.
  @override
  double get distanceKm;
  @override
  DateTime get departureTime;
  @override
  int get maxPassengers;
  @override
  int get bookedSeats;
  @override
  GenderPreference get genderPreference;
  @override
  int get arrivalToleranceMinutes;
  @override
  bool get allowsMusic;
  @override
  bool get allowsSmoking;
  @override
  bool get hasAc;
  @override
  String? get pickupInstructions;
  @override
  String? get carModel;
  @override
  String? get notes;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RideImplCopyWith<_$RideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
