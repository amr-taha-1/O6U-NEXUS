// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TranscriptCourse {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  int? get creditHours => throw _privateConstructorUsedError;
  double? get points => throw _privateConstructorUsedError;

  /// Create a copy of TranscriptCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranscriptCourseCopyWith<TranscriptCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranscriptCourseCopyWith<$Res> {
  factory $TranscriptCourseCopyWith(
    TranscriptCourse value,
    $Res Function(TranscriptCourse) then,
  ) = _$TranscriptCourseCopyWithImpl<$Res, TranscriptCourse>;
  @useResult
  $Res call({
    String code,
    String name,
    String grade,
    int? creditHours,
    double? points,
  });
}

/// @nodoc
class _$TranscriptCourseCopyWithImpl<$Res, $Val extends TranscriptCourse>
    implements $TranscriptCourseCopyWith<$Res> {
  _$TranscriptCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranscriptCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? grade = null,
    Object? creditHours = freezed,
    Object? points = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as String,
            creditHours: freezed == creditHours
                ? _value.creditHours
                : creditHours // ignore: cast_nullable_to_non_nullable
                      as int?,
            points: freezed == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TranscriptCourseImplCopyWith<$Res>
    implements $TranscriptCourseCopyWith<$Res> {
  factory _$$TranscriptCourseImplCopyWith(
    _$TranscriptCourseImpl value,
    $Res Function(_$TranscriptCourseImpl) then,
  ) = __$$TranscriptCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String grade,
    int? creditHours,
    double? points,
  });
}

/// @nodoc
class __$$TranscriptCourseImplCopyWithImpl<$Res>
    extends _$TranscriptCourseCopyWithImpl<$Res, _$TranscriptCourseImpl>
    implements _$$TranscriptCourseImplCopyWith<$Res> {
  __$$TranscriptCourseImplCopyWithImpl(
    _$TranscriptCourseImpl _value,
    $Res Function(_$TranscriptCourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TranscriptCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? grade = null,
    Object? creditHours = freezed,
    Object? points = freezed,
  }) {
    return _then(
      _$TranscriptCourseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as String,
        creditHours: freezed == creditHours
            ? _value.creditHours
            : creditHours // ignore: cast_nullable_to_non_nullable
                  as int?,
        points: freezed == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$TranscriptCourseImpl implements _TranscriptCourse {
  const _$TranscriptCourseImpl({
    required this.code,
    required this.name,
    required this.grade,
    this.creditHours,
    this.points,
  });

  @override
  final String code;
  @override
  final String name;
  @override
  final String grade;
  @override
  final int? creditHours;
  @override
  final double? points;

  @override
  String toString() {
    return 'TranscriptCourse(code: $code, name: $name, grade: $grade, creditHours: $creditHours, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranscriptCourseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.creditHours, creditHours) ||
                other.creditHours == creditHours) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, code, name, grade, creditHours, points);

  /// Create a copy of TranscriptCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranscriptCourseImplCopyWith<_$TranscriptCourseImpl> get copyWith =>
      __$$TranscriptCourseImplCopyWithImpl<_$TranscriptCourseImpl>(
        this,
        _$identity,
      );
}

abstract class _TranscriptCourse implements TranscriptCourse {
  const factory _TranscriptCourse({
    required final String code,
    required final String name,
    required final String grade,
    final int? creditHours,
    final double? points,
  }) = _$TranscriptCourseImpl;

  @override
  String get code;
  @override
  String get name;
  @override
  String get grade;
  @override
  int? get creditHours;
  @override
  double? get points;

  /// Create a copy of TranscriptCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranscriptCourseImplCopyWith<_$TranscriptCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
