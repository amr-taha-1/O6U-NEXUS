// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Semester {
  String get label => throw _privateConstructorUsedError;
  double get gpa => throw _privateConstructorUsedError;
  int get creditHours => throw _privateConstructorUsedError;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterCopyWith<Semester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterCopyWith<$Res> {
  factory $SemesterCopyWith(Semester value, $Res Function(Semester) then) =
      _$SemesterCopyWithImpl<$Res, Semester>;
  @useResult
  $Res call({String label, double gpa, int creditHours});
}

/// @nodoc
class _$SemesterCopyWithImpl<$Res, $Val extends Semester>
    implements $SemesterCopyWith<$Res> {
  _$SemesterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? gpa = null,
    Object? creditHours = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            gpa: null == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double,
            creditHours: null == creditHours
                ? _value.creditHours
                : creditHours // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SemesterImplCopyWith<$Res>
    implements $SemesterCopyWith<$Res> {
  factory _$$SemesterImplCopyWith(
    _$SemesterImpl value,
    $Res Function(_$SemesterImpl) then,
  ) = __$$SemesterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double gpa, int creditHours});
}

/// @nodoc
class __$$SemesterImplCopyWithImpl<$Res>
    extends _$SemesterCopyWithImpl<$Res, _$SemesterImpl>
    implements _$$SemesterImplCopyWith<$Res> {
  __$$SemesterImplCopyWithImpl(
    _$SemesterImpl _value,
    $Res Function(_$SemesterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? gpa = null,
    Object? creditHours = null,
  }) {
    return _then(
      _$SemesterImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        gpa: null == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double,
        creditHours: null == creditHours
            ? _value.creditHours
            : creditHours // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SemesterImpl implements _Semester {
  const _$SemesterImpl({
    required this.label,
    required this.gpa,
    required this.creditHours,
  });

  @override
  final String label;
  @override
  final double gpa;
  @override
  final int creditHours;

  @override
  String toString() {
    return 'Semester(label: $label, gpa: $gpa, creditHours: $creditHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.creditHours, creditHours) ||
                other.creditHours == creditHours));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, gpa, creditHours);

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterImplCopyWith<_$SemesterImpl> get copyWith =>
      __$$SemesterImplCopyWithImpl<_$SemesterImpl>(this, _$identity);
}

abstract class _Semester implements Semester {
  const factory _Semester({
    required final String label,
    required final double gpa,
    required final int creditHours,
  }) = _$SemesterImpl;

  @override
  String get label;
  @override
  double get gpa;
  @override
  int get creditHours;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterImplCopyWith<_$SemesterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
