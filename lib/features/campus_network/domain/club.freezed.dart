// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClubEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubEventCopyWith<ClubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubEventCopyWith<$Res> {
  factory $ClubEventCopyWith(ClubEvent value, $Res Function(ClubEvent) then) =
      _$ClubEventCopyWithImpl<$Res, ClubEvent>;
  @useResult
  $Res call({String id, String title, DateTime dateTime, String location});
}

/// @nodoc
class _$ClubEventCopyWithImpl<$Res, $Val extends ClubEvent>
    implements $ClubEventCopyWith<$Res> {
  _$ClubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? dateTime = null,
    Object? location = null,
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
            dateTime: null == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubEventImplCopyWith<$Res>
    implements $ClubEventCopyWith<$Res> {
  factory _$$ClubEventImplCopyWith(
    _$ClubEventImpl value,
    $Res Function(_$ClubEventImpl) then,
  ) = __$$ClubEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, DateTime dateTime, String location});
}

/// @nodoc
class __$$ClubEventImplCopyWithImpl<$Res>
    extends _$ClubEventCopyWithImpl<$Res, _$ClubEventImpl>
    implements _$$ClubEventImplCopyWith<$Res> {
  __$$ClubEventImplCopyWithImpl(
    _$ClubEventImpl _value,
    $Res Function(_$ClubEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? dateTime = null,
    Object? location = null,
  }) {
    return _then(
      _$ClubEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        dateTime: null == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClubEventImpl implements _ClubEvent {
  const _$ClubEventImpl({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime dateTime;
  @override
  final String location;

  @override
  String toString() {
    return 'ClubEvent(id: $id, title: $title, dateTime: $dateTime, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, dateTime, location);

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubEventImplCopyWith<_$ClubEventImpl> get copyWith =>
      __$$ClubEventImplCopyWithImpl<_$ClubEventImpl>(this, _$identity);
}

abstract class _ClubEvent implements ClubEvent {
  const factory _ClubEvent({
    required final String id,
    required final String title,
    required final DateTime dateTime,
    required final String location,
  }) = _$ClubEventImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get dateTime;
  @override
  String get location;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubEventImplCopyWith<_$ClubEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Club {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get shortName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  List<String> get announcements => throw _privateConstructorUsedError;
  List<ClubEvent> get events => throw _privateConstructorUsedError;
  List<String> get galleryAssetPaths => throw _privateConstructorUsedError;

  /// Create a copy of Club
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubCopyWith<Club> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubCopyWith<$Res> {
  factory $ClubCopyWith(Club value, $Res Function(Club) then) =
      _$ClubCopyWithImpl<$Res, Club>;
  @useResult
  $Res call({
    String id,
    String name,
    String shortName,
    String description,
    int memberCount,
    List<String> announcements,
    List<ClubEvent> events,
    List<String> galleryAssetPaths,
  });
}

/// @nodoc
class _$ClubCopyWithImpl<$Res, $Val extends Club>
    implements $ClubCopyWith<$Res> {
  _$ClubCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Club
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = null,
    Object? description = null,
    Object? memberCount = null,
    Object? announcements = null,
    Object? events = null,
    Object? galleryAssetPaths = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            shortName: null == shortName
                ? _value.shortName
                : shortName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            announcements: null == announcements
                ? _value.announcements
                : announcements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            events: null == events
                ? _value.events
                : events // ignore: cast_nullable_to_non_nullable
                      as List<ClubEvent>,
            galleryAssetPaths: null == galleryAssetPaths
                ? _value.galleryAssetPaths
                : galleryAssetPaths // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubImplCopyWith<$Res> implements $ClubCopyWith<$Res> {
  factory _$$ClubImplCopyWith(
    _$ClubImpl value,
    $Res Function(_$ClubImpl) then,
  ) = __$$ClubImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String shortName,
    String description,
    int memberCount,
    List<String> announcements,
    List<ClubEvent> events,
    List<String> galleryAssetPaths,
  });
}

/// @nodoc
class __$$ClubImplCopyWithImpl<$Res>
    extends _$ClubCopyWithImpl<$Res, _$ClubImpl>
    implements _$$ClubImplCopyWith<$Res> {
  __$$ClubImplCopyWithImpl(_$ClubImpl _value, $Res Function(_$ClubImpl) _then)
    : super(_value, _then);

  /// Create a copy of Club
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = null,
    Object? description = null,
    Object? memberCount = null,
    Object? announcements = null,
    Object? events = null,
    Object? galleryAssetPaths = null,
  }) {
    return _then(
      _$ClubImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        shortName: null == shortName
            ? _value.shortName
            : shortName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        announcements: null == announcements
            ? _value._announcements
            : announcements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        events: null == events
            ? _value._events
            : events // ignore: cast_nullable_to_non_nullable
                  as List<ClubEvent>,
        galleryAssetPaths: null == galleryAssetPaths
            ? _value._galleryAssetPaths
            : galleryAssetPaths // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$ClubImpl implements _Club {
  const _$ClubImpl({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.memberCount,
    required final List<String> announcements,
    required final List<ClubEvent> events,
    required final List<String> galleryAssetPaths,
  }) : _announcements = announcements,
       _events = events,
       _galleryAssetPaths = galleryAssetPaths;

  @override
  final String id;
  @override
  final String name;
  @override
  final String shortName;
  @override
  final String description;
  @override
  final int memberCount;
  final List<String> _announcements;
  @override
  List<String> get announcements {
    if (_announcements is EqualUnmodifiableListView) return _announcements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_announcements);
  }

  final List<ClubEvent> _events;
  @override
  List<ClubEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<String> _galleryAssetPaths;
  @override
  List<String> get galleryAssetPaths {
    if (_galleryAssetPaths is EqualUnmodifiableListView)
      return _galleryAssetPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryAssetPaths);
  }

  @override
  String toString() {
    return 'Club(id: $id, name: $name, shortName: $shortName, description: $description, memberCount: $memberCount, announcements: $announcements, events: $events, galleryAssetPaths: $galleryAssetPaths)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            const DeepCollectionEquality().equals(
              other._announcements,
              _announcements,
            ) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(
              other._galleryAssetPaths,
              _galleryAssetPaths,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    shortName,
    description,
    memberCount,
    const DeepCollectionEquality().hash(_announcements),
    const DeepCollectionEquality().hash(_events),
    const DeepCollectionEquality().hash(_galleryAssetPaths),
  );

  /// Create a copy of Club
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubImplCopyWith<_$ClubImpl> get copyWith =>
      __$$ClubImplCopyWithImpl<_$ClubImpl>(this, _$identity);
}

abstract class _Club implements Club {
  const factory _Club({
    required final String id,
    required final String name,
    required final String shortName,
    required final String description,
    required final int memberCount,
    required final List<String> announcements,
    required final List<ClubEvent> events,
    required final List<String> galleryAssetPaths,
  }) = _$ClubImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get shortName;
  @override
  String get description;
  @override
  int get memberCount;
  @override
  List<String> get announcements;
  @override
  List<ClubEvent> get events;
  @override
  List<String> get galleryAssetPaths;

  /// Create a copy of Club
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubImplCopyWith<_$ClubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
