import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/campus_post_repository.dart';
import '../domain/campus_post.dart';

/// Live like/bookmark state layered on top of the seed post fixtures —
/// session-scoped (same convention as `carpool_favorites.dart`). Toggling a
/// like adjusts the displayed count by exactly ±1 so numbers stay
/// consistent with whether *this* session has liked a post.
class CampusFeedState {
  const CampusFeedState({required this.posts, required this.likedPostIds, required this.bookmarkedPostIds});
  final List<CampusPost> posts;
  final Set<String> likedPostIds;
  final Set<String> bookmarkedPostIds;
}

class CampusFeedController extends Notifier<CampusFeedState> {
  @override
  CampusFeedState build() => CampusFeedState(posts: ref.watch(campusPostsProvider), likedPostIds: const {}, bookmarkedPostIds: const {});

  void toggleLike(String postId) {
    final alreadyLiked = state.likedPostIds.contains(postId);
    final newLiked = {...state.likedPostIds};
    alreadyLiked ? newLiked.remove(postId) : newLiked.add(postId);
    state = CampusFeedState(
      posts: [
        for (final post in state.posts)
          if (post.id == postId) post.copyWith(likeCount: post.likeCount + (alreadyLiked ? -1 : 1)) else post,
      ],
      likedPostIds: newLiked,
      bookmarkedPostIds: state.bookmarkedPostIds,
    );
  }

  void toggleBookmark(String postId) {
    final alreadyBookmarked = state.bookmarkedPostIds.contains(postId);
    final newBookmarked = {...state.bookmarkedPostIds};
    alreadyBookmarked ? newBookmarked.remove(postId) : newBookmarked.add(postId);
    state = CampusFeedState(
      posts: [
        for (final post in state.posts)
          if (post.id == postId) post.copyWith(bookmarkCount: post.bookmarkCount + (alreadyBookmarked ? -1 : 1)) else post,
      ],
      likedPostIds: state.likedPostIds,
      bookmarkedPostIds: newBookmarked,
    );
  }
}

final campusFeedControllerProvider = NotifierProvider<CampusFeedController, CampusFeedState>(CampusFeedController.new);

final campusPostByIdProvider = Provider.family<CampusPost?, String>((ref, id) {
  for (final post in ref.watch(campusFeedControllerProvider).posts) {
    if (post.id == id) return post;
  }
  return null;
});
