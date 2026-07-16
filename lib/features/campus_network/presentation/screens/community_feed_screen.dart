import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/campus_feed_controller.dart';
import '../../application/community_filter.dart';
import '../widgets/post_card.dart';

/// Campus Community — posts, questions, polls, study notes, project
/// updates, and achievements from across O6U. See `campus_post_repository.dart`
/// for why the post content itself is seed/demo data.
class CommunityFeedScreen extends ConsumerWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final feed = ref.watch(campusFeedControllerProvider);
    final hashtagFilter = ref.watch(communityHashtagFilterProvider);

    final allHashtags = <String>{};
    for (final post in feed.posts) {
      allHashtags.addAll(post.hashtags);
    }

    final visiblePosts = [
      for (final post in feed.posts)
        if (hashtagFilter == null || post.hashtags.contains(hashtagFilter)) post,
    ];

    return AppPushScaffold(
      title: 'Campus Community',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (allHashtags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  for (final tag in allHashtags)
                    GestureDetector(
                      onTap: () => ref.read(communityHashtagFilterProvider.notifier).state = hashtagFilter == tag ? null : tag,
                      child: TagChip(label: tag, color: colors.accent, filled: hashtagFilter == tag, selected: hashtagFilter == tag),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 10, AppSpacing.screenMargin, 0),
            child: AppButton(
              label: 'Create a post',
              icon: CupertinoIcons.add,
              variant: AppButtonVariant.secondary,
              expand: true,
              onPressed: () => context.push(AppRoutes.campusNetworkCreatePost),
            ),
          ),
          const SectionHeader('Feed'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: visiblePosts.isEmpty
                ? const StatusPlaceholder.empty(
                    icon: CupertinoIcons.text_bubble,
                    title: 'Nothing here yet',
                    message: 'No posts match this hashtag.',
                  )
                : Column(
                    children: [for (final post in visiblePosts) Padding(padding: const EdgeInsets.only(bottom: 10), child: PostCard(post: post))],
                  ),
          ),
        ],
      ),
    );
  }
}
