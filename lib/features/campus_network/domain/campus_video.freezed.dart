// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CampusVideo {
  String get id => throw _privateConstructorUsedError;
  CampusMember get creator => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  VideoTopic get topic => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  int get shareCount => throw _privateConstructorUsedError;
  int get saveCount => throw _privateConstructorUsedError;

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusVideoCopyWith<CampusVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusVideoCopyWith<$Res> {
  factory $CampusVideoCopyWith(
    CampusVideo value,
    $Res Function(CampusVideo) then,
  ) = _$CampusVideoCopyWithImpl<$Res, CampusVideo>;
  @useResult
  $Res call({
    String id,
    CampusMember creator,
    String title,
    VideoTopic topic,
    int durationSeconds,
    int likeCount,
    int commentCount,
    int shareCount,
    int saveCount,
  });

  $CampusMemberCopyWith<$Res> get creator;
}

/// @nodoc
class _$CampusVideoCopyWithImpl<$Res, $Val extends CampusVideo>
    implements $CampusVideoCopyWith<$Res> {
  _$CampusVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creator = null,
    Object? title = null,
    Object? topic = null,
    Object? durationSeconds = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? saveCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            creator: null == creator
                ? _value.creator
                : creator // ignore: cast_nullable_to_non_nullable
                      as CampusMember,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as VideoTopic,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            shareCount: null == shareCount
                ? _value.shareCount
                : shareCount // ignore: cast_nullable_to_non_nullable
                      as int,
            saveCount: null == saveCount
                ? _value.saveCount
                : saveCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CampusMemberCopyWith<$Res> get creator {
    return $CampusMemberCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CampusVideoImplCopyWith<$Res>
    implements $CampusVideoCopyWith<$Res> {
  factory _$$CampusVideoImplCopyWith(
    _$CampusVideoImpl value,
    $Res Function(_$CampusVideoImpl) then,
  ) = __$$CampusVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    CampusMember creator,
    String title,
    VideoTopic topic,
    int durationSeconds,
    int likeCount,
    int commentCount,
    int shareCount,
    int saveCount,
  });

  @override
  $CampusMemberCopyWith<$Res> get creator;
}

/// @nodoc
class __$$CampusVideoImplCopyWithImpl<$Res>
    extends _$CampusVideoCopyWithImpl<$Res, _$CampusVideoImpl>
    implements _$$CampusVideoImplCopyWith<$Res> {
  __$$CampusVideoImplCopyWithImpl(
    _$CampusVideoImpl _value,
    $Res Function(_$CampusVideoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creator = null,
    Object? title = null,
    Object? topic = null,
    Object? durationSeconds = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? saveCount = null,
  }) {
    return _then(
      _$CampusVideoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        creator: null == creator
            ? _value.creator
            : creator // ignore: cast_nullable_to_non_nullable
                  as CampusMember,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as VideoTopic,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        shareCount: null == shareCount
            ? _value.shareCount
            : shareCount // ignore: cast_nullable_to_non_nullable
                  as int,
        saveCount: null == saveCount
            ? _value.saveCount
            : saveCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CampusVideoImpl implements _CampusVideo {
  const _$CampusVideoImpl({
    required this.id,
    required this.creator,
    required this.title,
    required this.topic,
    required this.durationSeconds,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.saveCount,
  });

  @override
  final String id;
  @override
  final CampusMember creator;
  @override
  final String title;
  @override
  final VideoTopic topic;
  @override
  final int durationSeconds;
  @override
  final int likeCount;
  @override
  final int commentCount;
  @override
  final int shareCount;
  @override
  final int saveCount;

  @override
  String toString() {
    return 'CampusVideo(id: $id, creator: $creator, title: $title, topic: $topic, durationSeconds: $durationSeconds, likeCount: $likeCount, commentCount: $commentCount, shareCount: $shareCount, saveCount: $saveCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusVideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    creator,
    title,
    topic,
    durationSeconds,
    likeCount,
    commentCount,
    shareCount,
    saveCount,
  );

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusVideoImplCopyWith<_$CampusVideoImpl> get copyWith =>
      __$$CampusVideoImplCopyWithImpl<_$CampusVideoImpl>(this, _$identity);
}

abstract class _CampusVideo implements CampusVideo {
  const factory _CampusVideo({
    required final String id,
    required final CampusMember creator,
    required final String title,
    required final VideoTopic topic,
    required final int durationSeconds,
    required final int likeCount,
    required final int commentCount,
    required final int shareCount,
    required final int saveCount,
  }) = _$CampusVideoImpl;

  @override
  String get id;
  @override
  CampusMember get creator;
  @override
  String get title;
  @override
  VideoTopic get topic;
  @override
  int get durationSeconds;
  @override
  int get likeCount;
  @override
  int get commentCount;
  @override
  int get shareCount;
  @override
  int get saveCount;

  /// Create a copy of CampusVideo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusVideoImplCopyWith<_$CampusVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
