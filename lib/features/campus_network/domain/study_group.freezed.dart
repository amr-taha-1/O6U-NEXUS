// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StudyGroup {
  String get id => throw _privateConstructorUsedError;
  String get courseCode => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get meetingTime => throw _privateConstructorUsedError;
  int get maxStudents => throw _privateConstructorUsedError;
  MeetingType get meetingType => throw _privateConstructorUsedError;
  CampusMember get organizer => throw _privateConstructorUsedError;
  List<CampusMember> get members => throw _privateConstructorUsedError;

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyGroupCopyWith<StudyGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyGroupCopyWith<$Res> {
  factory $StudyGroupCopyWith(
    StudyGroup value,
    $Res Function(StudyGroup) then,
  ) = _$StudyGroupCopyWithImpl<$Res, StudyGroup>;
  @useResult
  $Res call({
    String id,
    String courseCode,
    String courseName,
    String location,
    DateTime meetingTime,
    int maxStudents,
    MeetingType meetingType,
    CampusMember organizer,
    List<CampusMember> members,
  });

  $CampusMemberCopyWith<$Res> get organizer;
}

/// @nodoc
class _$StudyGroupCopyWithImpl<$Res, $Val extends StudyGroup>
    implements $StudyGroupCopyWith<$Res> {
  _$StudyGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseCode = null,
    Object? courseName = null,
    Object? location = null,
    Object? meetingTime = null,
    Object? maxStudents = null,
    Object? meetingType = null,
    Object? organizer = null,
    Object? members = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseCode: null == courseCode
                ? _value.courseCode
                : courseCode // ignore: cast_nullable_to_non_nullable
                      as String,
            courseName: null == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            meetingTime: null == meetingTime
                ? _value.meetingTime
                : meetingTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            maxStudents: null == maxStudents
                ? _value.maxStudents
                : maxStudents // ignore: cast_nullable_to_non_nullable
                      as int,
            meetingType: null == meetingType
                ? _value.meetingType
                : meetingType // ignore: cast_nullable_to_non_nullable
                      as MeetingType,
            organizer: null == organizer
                ? _value.organizer
                : organizer // ignore: cast_nullable_to_non_nullable
                      as CampusMember,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<CampusMember>,
          )
          as $Val,
    );
  }

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CampusMemberCopyWith<$Res> get organizer {
    return $CampusMemberCopyWith<$Res>(_value.organizer, (value) {
      return _then(_value.copyWith(organizer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudyGroupImplCopyWith<$Res>
    implements $StudyGroupCopyWith<$Res> {
  factory _$$StudyGroupImplCopyWith(
    _$StudyGroupImpl value,
    $Res Function(_$StudyGroupImpl) then,
  ) = __$$StudyGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseCode,
    String courseName,
    String location,
    DateTime meetingTime,
    int maxStudents,
    MeetingType meetingType,
    CampusMember organizer,
    List<CampusMember> members,
  });

  @override
  $CampusMemberCopyWith<$Res> get organizer;
}

/// @nodoc
class __$$StudyGroupImplCopyWithImpl<$Res>
    extends _$StudyGroupCopyWithImpl<$Res, _$StudyGroupImpl>
    implements _$$StudyGroupImplCopyWith<$Res> {
  __$$StudyGroupImplCopyWithImpl(
    _$StudyGroupImpl _value,
    $Res Function(_$StudyGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseCode = null,
    Object? courseName = null,
    Object? location = null,
    Object? meetingTime = null,
    Object? maxStudents = null,
    Object? meetingType = null,
    Object? organizer = null,
    Object? members = null,
  }) {
    return _then(
      _$StudyGroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseCode: null == courseCode
            ? _value.courseCode
            : courseCode // ignore: cast_nullable_to_non_nullable
                  as String,
        courseName: null == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        meetingTime: null == meetingTime
            ? _value.meetingTime
            : meetingTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        maxStudents: null == maxStudents
            ? _value.maxStudents
            : maxStudents // ignore: cast_nullable_to_non_nullable
                  as int,
        meetingType: null == meetingType
            ? _value.meetingType
            : meetingType // ignore: cast_nullable_to_non_nullable
                  as MeetingType,
        organizer: null == organizer
            ? _value.organizer
            : organizer // ignore: cast_nullable_to_non_nullable
                  as CampusMember,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<CampusMember>,
      ),
    );
  }
}

/// @nodoc

class _$StudyGroupImpl extends _StudyGroup {
  const _$StudyGroupImpl({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.location,
    required this.meetingTime,
    required this.maxStudents,
    required this.meetingType,
    required this.organizer,
    required final List<CampusMember> members,
  }) : _members = members,
       super._();

  @override
  final String id;
  @override
  final String courseCode;
  @override
  final String courseName;
  @override
  final String location;
  @override
  final DateTime meetingTime;
  @override
  final int maxStudents;
  @override
  final MeetingType meetingType;
  @override
  final CampusMember organizer;
  final List<CampusMember> _members;
  @override
  List<CampusMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'StudyGroup(id: $id, courseCode: $courseCode, courseName: $courseName, location: $location, meetingTime: $meetingTime, maxStudents: $maxStudents, meetingType: $meetingType, organizer: $organizer, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.meetingTime, meetingTime) ||
                other.meetingTime == meetingTime) &&
            (identical(other.maxStudents, maxStudents) ||
                other.maxStudents == maxStudents) &&
            (identical(other.meetingType, meetingType) ||
                other.meetingType == meetingType) &&
            (identical(other.organizer, organizer) ||
                other.organizer == organizer) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseCode,
    courseName,
    location,
    meetingTime,
    maxStudents,
    meetingType,
    organizer,
    const DeepCollectionEquality().hash(_members),
  );

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyGroupImplCopyWith<_$StudyGroupImpl> get copyWith =>
      __$$StudyGroupImplCopyWithImpl<_$StudyGroupImpl>(this, _$identity);
}

abstract class _StudyGroup extends StudyGroup {
  const factory _StudyGroup({
    required final String id,
    required final String courseCode,
    required final String courseName,
    required final String location,
    required final DateTime meetingTime,
    required final int maxStudents,
    required final MeetingType meetingType,
    required final CampusMember organizer,
    required final List<CampusMember> members,
  }) = _$StudyGroupImpl;
  const _StudyGroup._() : super._();

  @override
  String get id;
  @override
  String get courseCode;
  @override
  String get courseName;
  @override
  String get location;
  @override
  DateTime get meetingTime;
  @override
  int get maxStudents;
  @override
  MeetingType get meetingType;
  @override
  CampusMember get organizer;
  @override
  List<CampusMember> get members;

  /// Create a copy of StudyGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyGroupImplCopyWith<_$StudyGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
