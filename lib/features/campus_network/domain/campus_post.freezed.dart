// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PollOption {
  String get label => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollOptionCopyWith<PollOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionCopyWith<$Res> {
  factory $PollOptionCopyWith(
    PollOption value,
    $Res Function(PollOption) then,
  ) = _$PollOptionCopyWithImpl<$Res, PollOption>;
  @useResult
  $Res call({String label, int voteCount});
}

/// @nodoc
class _$PollOptionCopyWithImpl<$Res, $Val extends PollOption>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? voteCount = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            voteCount: null == voteCount
                ? _value.voteCount
                : voteCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollOptionImplCopyWith<$Res>
    implements $PollOptionCopyWith<$Res> {
  factory _$$PollOptionImplCopyWith(
    _$PollOptionImpl value,
    $Res Function(_$PollOptionImpl) then,
  ) = __$$PollOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int voteCount});
}

/// @nodoc
class __$$PollOptionImplCopyWithImpl<$Res>
    extends _$PollOptionCopyWithImpl<$Res, _$PollOptionImpl>
    implements _$$PollOptionImplCopyWith<$Res> {
  __$$PollOptionImplCopyWithImpl(
    _$PollOptionImpl _value,
    $Res Function(_$PollOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? voteCount = null}) {
    return _then(
      _$PollOptionImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        voteCount: null == voteCount
            ? _value.voteCount
            : voteCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PollOptionImpl implements _PollOption {
  const _$PollOptionImpl({required this.label, required this.voteCount});

  @override
  final String label;
  @override
  final int voteCount;

  @override
  String toString() {
    return 'PollOption(label: $label, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, voteCount);

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      __$$PollOptionImplCopyWithImpl<_$PollOptionImpl>(this, _$identity);
}

abstract class _PollOption implements PollOption {
  const factory _PollOption({
    required final String label,
    required final int voteCount,
  }) = _$PollOptionImpl;

  @override
  String get label;
  @override
  int get voteCount;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CampusPost {
  String get id => throw _privateConstructorUsedError;
  CampusMember get author => throw _privateConstructorUsedError;
  CampusPostType get type => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  List<String> get mentions => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  int get bookmarkCount => throw _privateConstructorUsedError;
  int get shareCount => throw _privateConstructorUsedError;
  String? get attachmentName => throw _privateConstructorUsedError;
  List<PollOption>? get pollOptions => throw _privateConstructorUsedError;

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusPostCopyWith<CampusPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusPostCopyWith<$Res> {
  factory $CampusPostCopyWith(
    CampusPost value,
    $Res Function(CampusPost) then,
  ) = _$CampusPostCopyWithImpl<$Res, CampusPost>;
  @useResult
  $Res call({
    String id,
    CampusMember author,
    CampusPostType type,
    String body,
    List<String> hashtags,
    List<String> mentions,
    DateTime createdAt,
    int likeCount,
    int commentCount,
    int bookmarkCount,
    int shareCount,
    String? attachmentName,
    List<PollOption>? pollOptions,
  });

  $CampusMemberCopyWith<$Res> get author;
}

/// @nodoc
class _$CampusPostCopyWithImpl<$Res, $Val extends CampusPost>
    implements $CampusPostCopyWith<$Res> {
  _$CampusPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? type = null,
    Object? body = null,
    Object? hashtags = null,
    Object? mentions = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? shareCount = null,
    Object? attachmentName = freezed,
    Object? pollOptions = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as CampusMember,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CampusPostType,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            hashtags: null == hashtags
                ? _value.hashtags
                : hashtags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mentions: null == mentions
                ? _value.mentions
                : mentions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            bookmarkCount: null == bookmarkCount
                ? _value.bookmarkCount
                : bookmarkCount // ignore: cast_nullable_to_non_nullable
                      as int,
            shareCount: null == shareCount
                ? _value.shareCount
                : shareCount // ignore: cast_nullable_to_non_nullable
                      as int,
            attachmentName: freezed == attachmentName
                ? _value.attachmentName
                : attachmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            pollOptions: freezed == pollOptions
                ? _value.pollOptions
                : pollOptions // ignore: cast_nullable_to_non_nullable
                      as List<PollOption>?,
          )
          as $Val,
    );
  }

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CampusMemberCopyWith<$Res> get author {
    return $CampusMemberCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CampusPostImplCopyWith<$Res>
    implements $CampusPostCopyWith<$Res> {
  factory _$$CampusPostImplCopyWith(
    _$CampusPostImpl value,
    $Res Function(_$CampusPostImpl) then,
  ) = __$$CampusPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    CampusMember author,
    CampusPostType type,
    String body,
    List<String> hashtags,
    List<String> mentions,
    DateTime createdAt,
    int likeCount,
    int commentCount,
    int bookmarkCount,
    int shareCount,
    String? attachmentName,
    List<PollOption>? pollOptions,
  });

  @override
  $CampusMemberCopyWith<$Res> get author;
}

/// @nodoc
class __$$CampusPostImplCopyWithImpl<$Res>
    extends _$CampusPostCopyWithImpl<$Res, _$CampusPostImpl>
    implements _$$CampusPostImplCopyWith<$Res> {
  __$$CampusPostImplCopyWithImpl(
    _$CampusPostImpl _value,
    $Res Function(_$CampusPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? author = null,
    Object? type = null,
    Object? body = null,
    Object? hashtags = null,
    Object? mentions = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? bookmarkCount = null,
    Object? shareCount = null,
    Object? attachmentName = freezed,
    Object? pollOptions = freezed,
  }) {
    return _then(
      _$CampusPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as CampusMember,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CampusPostType,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        hashtags: null == hashtags
            ? _value._hashtags
            : hashtags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mentions: null == mentions
            ? _value._mentions
            : mentions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        bookmarkCount: null == bookmarkCount
            ? _value.bookmarkCount
            : bookmarkCount // ignore: cast_nullable_to_non_nullable
                  as int,
        shareCount: null == shareCount
            ? _value.shareCount
            : shareCount // ignore: cast_nullable_to_non_nullable
                  as int,
        attachmentName: freezed == attachmentName
            ? _value.attachmentName
            : attachmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        pollOptions: freezed == pollOptions
            ? _value._pollOptions
            : pollOptions // ignore: cast_nullable_to_non_nullable
                  as List<PollOption>?,
      ),
    );
  }
}

/// @nodoc

class _$CampusPostImpl implements _CampusPost {
  const _$CampusPostImpl({
    required this.id,
    required this.author,
    required this.type,
    required this.body,
    required final List<String> hashtags,
    required final List<String> mentions,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.bookmarkCount,
    required this.shareCount,
    this.attachmentName,
    final List<PollOption>? pollOptions,
  }) : _hashtags = hashtags,
       _mentions = mentions,
       _pollOptions = pollOptions;

  @override
  final String id;
  @override
  final CampusMember author;
  @override
  final CampusPostType type;
  @override
  final String body;
  final List<String> _hashtags;
  @override
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  final List<String> _mentions;
  @override
  List<String> get mentions {
    if (_mentions is EqualUnmodifiableListView) return _mentions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mentions);
  }

  @override
  final DateTime createdAt;
  @override
  final int likeCount;
  @override
  final int commentCount;
  @override
  final int bookmarkCount;
  @override
  final int shareCount;
  @override
  final String? attachmentName;
  final List<PollOption>? _pollOptions;
  @override
  List<PollOption>? get pollOptions {
    final value = _pollOptions;
    if (value == null) return null;
    if (_pollOptions is EqualUnmodifiableListView) return _pollOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CampusPost(id: $id, author: $author, type: $type, body: $body, hashtags: $hashtags, mentions: $mentions, createdAt: $createdAt, likeCount: $likeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, shareCount: $shareCount, attachmentName: $attachmentName, pollOptions: $pollOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            const DeepCollectionEquality().equals(other._mentions, _mentions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.bookmarkCount, bookmarkCount) ||
                other.bookmarkCount == bookmarkCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.attachmentName, attachmentName) ||
                other.attachmentName == attachmentName) &&
            const DeepCollectionEquality().equals(
              other._pollOptions,
              _pollOptions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    author,
    type,
    body,
    const DeepCollectionEquality().hash(_hashtags),
    const DeepCollectionEquality().hash(_mentions),
    createdAt,
    likeCount,
    commentCount,
    bookmarkCount,
    shareCount,
    attachmentName,
    const DeepCollectionEquality().hash(_pollOptions),
  );

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusPostImplCopyWith<_$CampusPostImpl> get copyWith =>
      __$$CampusPostImplCopyWithImpl<_$CampusPostImpl>(this, _$identity);
}

abstract class _CampusPost implements CampusPost {
  const factory _CampusPost({
    required final String id,
    required final CampusMember author,
    required final CampusPostType type,
    required final String body,
    required final List<String> hashtags,
    required final List<String> mentions,
    required final DateTime createdAt,
    required final int likeCount,
    required final int commentCount,
    required final int bookmarkCount,
    required final int shareCount,
    final String? attachmentName,
    final List<PollOption>? pollOptions,
  }) = _$CampusPostImpl;

  @override
  String get id;
  @override
  CampusMember get author;
  @override
  CampusPostType get type;
  @override
  String get body;
  @override
  List<String> get hashtags;
  @override
  List<String> get mentions;
  @override
  DateTime get createdAt;
  @override
  int get likeCount;
  @override
  int get commentCount;
  @override
  int get bookmarkCount;
  @override
  int get shareCount;
  @override
  String? get attachmentName;
  @override
  List<PollOption>? get pollOptions;

  /// Create a copy of CampusPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusPostImplCopyWith<_$CampusPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CampusComment {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  CampusMember get author => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  String? get parentCommentId => throw _privateConstructorUsedError;

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusCommentCopyWith<CampusComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusCommentCopyWith<$Res> {
  factory $CampusCommentCopyWith(
    CampusComment value,
    $Res Function(CampusComment) then,
  ) = _$CampusCommentCopyWithImpl<$Res, CampusComment>;
  @useResult
  $Res call({
    String id,
    String postId,
    CampusMember author,
    String body,
    DateTime createdAt,
    int likeCount,
    String? parentCommentId,
  });

  $CampusMemberCopyWith<$Res> get author;
}

/// @nodoc
class _$CampusCommentCopyWithImpl<$Res, $Val extends CampusComment>
    implements $CampusCommentCopyWith<$Res> {
  _$CampusCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? author = null,
    Object? body = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? parentCommentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            postId: null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as CampusMember,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            parentCommentId: freezed == parentCommentId
                ? _value.parentCommentId
                : parentCommentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CampusMemberCopyWith<$Res> get author {
    return $CampusMemberCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CampusCommentImplCopyWith<$Res>
    implements $CampusCommentCopyWith<$Res> {
  factory _$$CampusCommentImplCopyWith(
    _$CampusCommentImpl value,
    $Res Function(_$CampusCommentImpl) then,
  ) = __$$CampusCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String postId,
    CampusMember author,
    String body,
    DateTime createdAt,
    int likeCount,
    String? parentCommentId,
  });

  @override
  $CampusMemberCopyWith<$Res> get author;
}

/// @nodoc
class __$$CampusCommentImplCopyWithImpl<$Res>
    extends _$CampusCommentCopyWithImpl<$Res, _$CampusCommentImpl>
    implements _$$CampusCommentImplCopyWith<$Res> {
  __$$CampusCommentImplCopyWithImpl(
    _$CampusCommentImpl _value,
    $Res Function(_$CampusCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? author = null,
    Object? body = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? parentCommentId = freezed,
  }) {
    return _then(
      _$CampusCommentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        postId: null == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as CampusMember,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        parentCommentId: freezed == parentCommentId
            ? _value.parentCommentId
            : parentCommentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CampusCommentImpl implements _CampusComment {
  const _$CampusCommentImpl({
    required this.id,
    required this.postId,
    required this.author,
    required this.body,
    required this.createdAt,
    required this.likeCount,
    this.parentCommentId,
  });

  @override
  final String id;
  @override
  final String postId;
  @override
  final CampusMember author;
  @override
  final String body;
  @override
  final DateTime createdAt;
  @override
  final int likeCount;
  @override
  final String? parentCommentId;

  @override
  String toString() {
    return 'CampusComment(id: $id, postId: $postId, author: $author, body: $body, createdAt: $createdAt, likeCount: $likeCount, parentCommentId: $parentCommentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    postId,
    author,
    body,
    createdAt,
    likeCount,
    parentCommentId,
  );

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusCommentImplCopyWith<_$CampusCommentImpl> get copyWith =>
      __$$CampusCommentImplCopyWithImpl<_$CampusCommentImpl>(this, _$identity);
}

abstract class _CampusComment implements CampusComment {
  const factory _CampusComment({
    required final String id,
    required final String postId,
    required final CampusMember author,
    required final String body,
    required final DateTime createdAt,
    required final int likeCount,
    final String? parentCommentId,
  }) = _$CampusCommentImpl;

  @override
  String get id;
  @override
  String get postId;
  @override
  CampusMember get author;
  @override
  String get body;
  @override
  DateTime get createdAt;
  @override
  int get likeCount;
  @override
  String? get parentCommentId;

  /// Create a copy of CampusComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusCommentImplCopyWith<_$CampusCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
