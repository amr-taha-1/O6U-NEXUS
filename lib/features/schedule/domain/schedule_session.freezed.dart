// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScheduleSession {
  String get courseCode => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  SessionType get type => throw _privateConstructorUsedError;
  Weekday get day => throw _privateConstructorUsedError;

  /// Minutes since midnight.
  int get startMinutes => throw _privateConstructorUsedError;
  int get endMinutes => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;
  String? get instructor => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleSessionCopyWith<ScheduleSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleSessionCopyWith<$Res> {
  factory $ScheduleSessionCopyWith(
    ScheduleSession value,
    $Res Function(ScheduleSession) then,
  ) = _$ScheduleSessionCopyWithImpl<$Res, ScheduleSession>;
  @useResult
  $Res call({
    String courseCode,
    String courseName,
    SessionType type,
    Weekday day,
    int startMinutes,
    int endMinutes,
    String room,
    String? instructor,
  });
}

/// @nodoc
class _$ScheduleSessionCopyWithImpl<$Res, $Val extends ScheduleSession>
    implements $ScheduleSessionCopyWith<$Res> {
  _$ScheduleSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? courseName = null,
    Object? type = null,
    Object? day = null,
    Object? startMinutes = null,
    Object? endMinutes = null,
    Object? room = null,
    Object? instructor = freezed,
  }) {
    return _then(
      _value.copyWith(
            courseCode: null == courseCode
                ? _value.courseCode
                : courseCode // ignore: cast_nullable_to_non_nullable
                      as String,
            courseName: null == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SessionType,
            day: null == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                      as Weekday,
            startMinutes: null == startMinutes
                ? _value.startMinutes
                : startMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            endMinutes: null == endMinutes
                ? _value.endMinutes
                : endMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            room: null == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                      as String,
            instructor: freezed == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleSessionImplCopyWith<$Res>
    implements $ScheduleSessionCopyWith<$Res> {
  factory _$$ScheduleSessionImplCopyWith(
    _$ScheduleSessionImpl value,
    $Res Function(_$ScheduleSessionImpl) then,
  ) = __$$ScheduleSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String courseCode,
    String courseName,
    SessionType type,
    Weekday day,
    int startMinutes,
    int endMinutes,
    String room,
    String? instructor,
  });
}

/// @nodoc
class __$$ScheduleSessionImplCopyWithImpl<$Res>
    extends _$ScheduleSessionCopyWithImpl<$Res, _$ScheduleSessionImpl>
    implements _$$ScheduleSessionImplCopyWith<$Res> {
  __$$ScheduleSessionImplCopyWithImpl(
    _$ScheduleSessionImpl _value,
    $Res Function(_$ScheduleSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? courseName = null,
    Object? type = null,
    Object? day = null,
    Object? startMinutes = null,
    Object? endMinutes = null,
    Object? room = null,
    Object? instructor = freezed,
  }) {
    return _then(
      _$ScheduleSessionImpl(
        courseCode: null == courseCode
            ? _value.courseCode
            : courseCode // ignore: cast_nullable_to_non_nullable
                  as String,
        courseName: null == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SessionType,
        day: null == day
            ? _value.day
            : day // ignore: cast_nullable_to_non_nullable
                  as Weekday,
        startMinutes: null == startMinutes
            ? _value.startMinutes
            : startMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        endMinutes: null == endMinutes
            ? _value.endMinutes
            : endMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        instructor: freezed == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ScheduleSessionImpl extends _ScheduleSession {
  const _$ScheduleSessionImpl({
    required this.courseCode,
    required this.courseName,
    required this.type,
    required this.day,
    required this.startMinutes,
    required this.endMinutes,
    required this.room,
    this.instructor,
  }) : super._();

  @override
  final String courseCode;
  @override
  final String courseName;
  @override
  final SessionType type;
  @override
  final Weekday day;

  /// Minutes since midnight.
  @override
  final int startMinutes;
  @override
  final int endMinutes;
  @override
  final String room;
  @override
  final String? instructor;

  @override
  String toString() {
    return 'ScheduleSession(courseCode: $courseCode, courseName: $courseName, type: $type, day: $day, startMinutes: $startMinutes, endMinutes: $endMinutes, room: $room, instructor: $instructor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleSessionImpl &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.startMinutes, startMinutes) ||
                other.startMinutes == startMinutes) &&
            (identical(other.endMinutes, endMinutes) ||
                other.endMinutes == endMinutes) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    courseCode,
    courseName,
    type,
    day,
    startMinutes,
    endMinutes,
    room,
    instructor,
  );

  /// Create a copy of ScheduleSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleSessionImplCopyWith<_$ScheduleSessionImpl> get copyWith =>
      __$$ScheduleSessionImplCopyWithImpl<_$ScheduleSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _ScheduleSession extends ScheduleSession {
  const factory _ScheduleSession({
    required final String courseCode,
    required final String courseName,
    required final SessionType type,
    required final Weekday day,
    required final int startMinutes,
    required final int endMinutes,
    required final String room,
    final String? instructor,
  }) = _$ScheduleSessionImpl;
  const _ScheduleSession._() : super._();

  @override
  String get courseCode;
  @override
  String get courseName;
  @override
  SessionType get type;
  @override
  Weekday get day;

  /// Minutes since midnight.
  @override
  int get startMinutes;
  @override
  int get endMinutes;
  @override
  String get room;
  @override
  String? get instructor;

  /// Create a copy of ScheduleSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleSessionImplCopyWith<_$ScheduleSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
