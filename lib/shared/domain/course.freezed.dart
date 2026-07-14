// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Course {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  int get attendancePercent => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  int get creditHours => throw _privateConstructorUsedError;
  String get nextSession => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call({
    String code,
    String name,
    String instructor,
    int attendancePercent,
    String grade,
    int creditHours,
    String nextSession,
    String room,
  });
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? instructor = null,
    Object? attendancePercent = null,
    Object? grade = null,
    Object? creditHours = null,
    Object? nextSession = null,
    Object? room = null,
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
            instructor: null == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String,
            attendancePercent: null == attendancePercent
                ? _value.attendancePercent
                : attendancePercent // ignore: cast_nullable_to_non_nullable
                      as int,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as String,
            creditHours: null == creditHours
                ? _value.creditHours
                : creditHours // ignore: cast_nullable_to_non_nullable
                      as int,
            nextSession: null == nextSession
                ? _value.nextSession
                : nextSession // ignore: cast_nullable_to_non_nullable
                      as String,
            room: null == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
    _$CourseImpl value,
    $Res Function(_$CourseImpl) then,
  ) = __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String instructor,
    int attendancePercent,
    String grade,
    int creditHours,
    String nextSession,
    String room,
  });
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
    _$CourseImpl _value,
    $Res Function(_$CourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? instructor = null,
    Object? attendancePercent = null,
    Object? grade = null,
    Object? creditHours = null,
    Object? nextSession = null,
    Object? room = null,
  }) {
    return _then(
      _$CourseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        instructor: null == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String,
        attendancePercent: null == attendancePercent
            ? _value.attendancePercent
            : attendancePercent // ignore: cast_nullable_to_non_nullable
                  as int,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as String,
        creditHours: null == creditHours
            ? _value.creditHours
            : creditHours // ignore: cast_nullable_to_non_nullable
                  as int,
        nextSession: null == nextSession
            ? _value.nextSession
            : nextSession // ignore: cast_nullable_to_non_nullable
                  as String,
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CourseImpl extends _Course {
  const _$CourseImpl({
    required this.code,
    required this.name,
    required this.instructor,
    required this.attendancePercent,
    required this.grade,
    required this.creditHours,
    required this.nextSession,
    required this.room,
  }) : super._();

  @override
  final String code;
  @override
  final String name;
  @override
  final String instructor;
  @override
  final int attendancePercent;
  @override
  final String grade;
  @override
  final int creditHours;
  @override
  final String nextSession;
  @override
  final String room;

  @override
  String toString() {
    return 'Course(code: $code, name: $name, instructor: $instructor, attendancePercent: $attendancePercent, grade: $grade, creditHours: $creditHours, nextSession: $nextSession, room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.attendancePercent, attendancePercent) ||
                other.attendancePercent == attendancePercent) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.creditHours, creditHours) ||
                other.creditHours == creditHours) &&
            (identical(other.nextSession, nextSession) ||
                other.nextSession == nextSession) &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    instructor,
    attendancePercent,
    grade,
    creditHours,
    nextSession,
    room,
  );

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);
}

abstract class _Course extends Course {
  const factory _Course({
    required final String code,
    required final String name,
    required final String instructor,
    required final int attendancePercent,
    required final String grade,
    required final int creditHours,
    required final String nextSession,
    required final String room,
  }) = _$CourseImpl;
  const _Course._() : super._();

  @override
  String get code;
  @override
  String get name;
  @override
  String get instructor;
  @override
  int get attendancePercent;
  @override
  String get grade;
  @override
  int get creditHours;
  @override
  String get nextSession;
  @override
  String get room;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
