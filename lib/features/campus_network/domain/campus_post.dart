import 'package:freezed_annotation/freezed_annotation.dart';

import 'campus_member.dart';

part 'campus_post.freezed.dart';

/// What a Campus Community post is fundamentally made of — an image/document
/// *post* carries a caption plus an attachment name, not real uploaded
/// bytes (see `campus_post_repository.dart` for why: no storage backend,
/// no `image_picker` in this build).
enum CampusPostType { text, image, document, question, poll, note, projectUpdate, achievement }

extension CampusPostTypeX on CampusPostType {
  String get label => switch (this) {
        CampusPostType.text => 'Post',
        CampusPostType.image => 'Photo',
        CampusPostType.document => 'Document',
        CampusPostType.question => 'Question',
        CampusPostType.poll => 'Poll',
        CampusPostType.note => 'Study Note',
        CampusPostType.projectUpdate => 'Project Update',
        CampusPostType.achievement => 'Achievement',
      };
}

@freezed
abstract class PollOption with _$PollOption {
  const factory PollOption({required String label, required int voteCount}) = _PollOption;
}

/// One Campus Community post. Hashtags and mentions are parsed once at
/// creation time (`#Database`, `@name`) rather than re-parsed from [body]
/// on every render.
@freezed
abstract class CampusPost with _$CampusPost {
  const factory CampusPost({
    required String id,
    required CampusMember author,
    required CampusPostType type,
    required String body,
    required List<String> hashtags,
    required List<String> mentions,
    required DateTime createdAt,
    required int likeCount,
    required int commentCount,
    required int bookmarkCount,
    required int shareCount,
    String? attachmentName,
    List<PollOption>? pollOptions,
  }) = _CampusPost;
}

/// A comment or reply (via [parentCommentId]) on a [CampusPost].
@freezed
abstract class CampusComment with _$CampusComment {
  const factory CampusComment({
    required String id,
    required String postId,
    required CampusMember author,
    required String body,
    required DateTime createdAt,
    required int likeCount,
    String? parentCommentId,
  }) = _CampusComment;
}
