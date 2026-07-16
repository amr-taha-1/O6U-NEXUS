import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/campus_feed_controller.dart';
import '../../data/campus_post_repository.dart';
import '../../domain/campus_post.dart';
import '../widgets/post_card.dart';

/// A post plus its comment thread (replies nested one level via
/// [CampusComment.parentCommentId]). Adding a new top-level comment is a
/// simulated action — see `campus_post_repository.dart`'s doc comment for
/// why comments are read-only seed content in this build.
class PostDetailsScreen extends ConsumerWidget {
  const PostDetailsScreen({super.key, required this.postId});
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(campusPostByIdProvider(postId));
    final comments = ref.watch(campusCommentsProvider(postId));

    return AppPushScaffold(
      title: 'Post',
      body: post == null
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: StatusPlaceholder.empty(icon: CupertinoIcons.text_bubble, title: 'Post not found', message: 'This post may have been removed.'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: PostCard(post: post, onOpen: () {}),
                ),
                const SectionHeader('Comments'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: comments.isEmpty
                      ? const StatusPlaceholder.empty(icon: CupertinoIcons.bubble_left, title: 'No comments yet', message: 'Be the first to reply.')
                      : Column(
                          children: [for (final comment in comments) _CommentTile(comment: comment)],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
                  child: AppTextField(
                    icon: CupertinoIcons.pencil,
                    hintText: 'Write a comment…',
                    trailing: GestureDetector(
                      onTap: () => AppSnackbar.show(context, message: 'Comment posted · simulated, no backend in this build.'),
                      child: Icon(CupertinoIcons.paperplane_fill, size: 18, color: context.colors.accent),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});
  final CampusComment comment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: comment.parentCommentId != null ? 24 : 0),
      child: AppCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: Text(comment.author.fullName, style: text.bodyEmphasized.copyWith(fontSize: 13.5))),
                Icon(CupertinoIcons.heart, size: 13, color: colors.textDim),
                const SizedBox(width: 3),
                Text('${comment.likeCount}', style: text.footnote.copyWith(color: colors.textMuted)),
              ],
            ),
            const SizedBox(height: 3),
            Text(comment.body, style: text.body.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
