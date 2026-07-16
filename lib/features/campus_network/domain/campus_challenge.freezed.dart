// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CampusChallenge {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ChallengeCadence get cadence => throw _privateConstructorUsedError;
  int get targetCount => throw _privateConstructorUsedError;
  int get rewardXp => throw _privateConstructorUsedError;
  int get rewardCoins => throw _privateConstructorUsedError;

  /// Create a copy of CampusChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusChallengeCopyWith<CampusChallenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusChallengeCopyWith<$Res> {
  factory $CampusChallengeCopyWith(
    CampusChallenge value,
    $Res Function(CampusChallenge) then,
  ) = _$CampusChallengeCopyWithImpl<$Res, CampusChallenge>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    ChallengeCadence cadence,
    int targetCount,
    int rewardXp,
    int rewardCoins,
  });
}

/// @nodoc
class _$CampusChallengeCopyWithImpl<$Res, $Val extends CampusChallenge>
    implements $CampusChallengeCopyWith<$Res> {
  _$CampusChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? cadence = null,
    Object? targetCount = null,
    Object? rewardXp = null,
    Object? rewardCoins = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            cadence: null == cadence
                ? _value.cadence
                : cadence // ignore: cast_nullable_to_non_nullable
                      as ChallengeCadence,
            targetCount: null == targetCount
                ? _value.targetCount
                : targetCount // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardXp: null == rewardXp
                ? _value.rewardXp
                : rewardXp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardCoins: null == rewardCoins
                ? _value.rewardCoins
                : rewardCoins // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampusChallengeImplCopyWith<$Res>
    implements $CampusChallengeCopyWith<$Res> {
  factory _$$CampusChallengeImplCopyWith(
    _$CampusChallengeImpl value,
    $Res Function(_$CampusChallengeImpl) then,
  ) = __$$CampusChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    ChallengeCadence cadence,
    int targetCount,
    int rewardXp,
    int rewardCoins,
  });
}

/// @nodoc
class __$$CampusChallengeImplCopyWithImpl<$Res>
    extends _$CampusChallengeCopyWithImpl<$Res, _$CampusChallengeImpl>
    implements _$$CampusChallengeImplCopyWith<$Res> {
  __$$CampusChallengeImplCopyWithImpl(
    _$CampusChallengeImpl _value,
    $Res Function(_$CampusChallengeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? cadence = null,
    Object? targetCount = null,
    Object? rewardXp = null,
    Object? rewardCoins = null,
  }) {
    return _then(
      _$CampusChallengeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        cadence: null == cadence
            ? _value.cadence
            : cadence // ignore: cast_nullable_to_non_nullable
                  as ChallengeCadence,
        targetCount: null == targetCount
            ? _value.targetCount
            : targetCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardXp: null == rewardXp
            ? _value.rewardXp
            : rewardXp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardCoins: null == rewardCoins
            ? _value.rewardCoins
            : rewardCoins // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CampusChallengeImpl implements _CampusChallenge {
  const _$CampusChallengeImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.cadence,
    required this.targetCount,
    required this.rewardXp,
    required this.rewardCoins,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final ChallengeCadence cadence;
  @override
  final int targetCount;
  @override
  final int rewardXp;
  @override
  final int rewardCoins;

  @override
  String toString() {
    return 'CampusChallenge(id: $id, title: $title, description: $description, cadence: $cadence, targetCount: $targetCount, rewardXp: $rewardXp, rewardCoins: $rewardCoins)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cadence, cadence) || other.cadence == cadence) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.rewardXp, rewardXp) ||
                other.rewardXp == rewardXp) &&
            (identical(other.rewardCoins, rewardCoins) ||
                other.rewardCoins == rewardCoins));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    cadence,
    targetCount,
    rewardXp,
    rewardCoins,
  );

  /// Create a copy of CampusChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusChallengeImplCopyWith<_$CampusChallengeImpl> get copyWith =>
      __$$CampusChallengeImplCopyWithImpl<_$CampusChallengeImpl>(
        this,
        _$identity,
      );
}

abstract class _CampusChallenge implements CampusChallenge {
  const factory _CampusChallenge({
    required final String id,
    required final String title,
    required final String description,
    required final ChallengeCadence cadence,
    required final int targetCount,
    required final int rewardXp,
    required final int rewardCoins,
  }) = _$CampusChallengeImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  ChallengeCadence get cadence;
  @override
  int get targetCount;
  @override
  int get rewardXp;
  @override
  int get rewardCoins;

  /// Create a copy of CampusChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusChallengeImplCopyWith<_$CampusChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
