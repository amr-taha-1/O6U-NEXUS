import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/campus_feed_controller.dart';
import '../../domain/campus_post.dart';

/// One Campus Community post — like/comment/bookmark/share, hashtags. Used
/// on the Community feed, a member's profile, and (filtered) a club page.
class PostCard extends ConsumerWidget {
  const PostCard({super.key, required this.post, this.onOpen});
  final CampusPost post;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final feed = ref.watch(campusFeedControllerProvider);
    final liked = feed.likedPostIds.contains(post.id);
    final bookmarked = feed.bookmarkedPostIds.contains(post.id);

    return AppCard(
      onTap: onOpen ?? () => context.push(AppRoutes.campusNetworkPostPath(post.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(CupertinoIcons.person_alt, size: 15, color: colors.accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(post.author.fullName, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                    Text('${post.author.department} · ${_relativeTime(post.createdAt)}', style: text.footnote.copyWith(color: colors.textMuted)),
                  ],
                ),
              ),
              TagChip(label: post.type.label, color: colors.info),
            ],
          ),
          const SizedBox(height: 10),
          Text(post.body, style: text.body.copyWith(fontSize: 14.5), maxLines: 5, overflow: TextOverflow.ellipsis),
          if (post.attachmentName != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(color: AppColors.tint(colors.textPrimary, 0.06), borderRadius: AppRadius.smRadius),
              child: Row(
                children: [
                  Icon(CupertinoIcons.doc_text, size: 14, color: colors.textDim),
                  const SizedBox(width: 8),
                  Expanded(child: Text(post.attachmentName!, style: text.footnote, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ],
          if (post.pollOptions != null) ...[
            const SizedBox(height: 8),
            for (final option in post.pollOptions!) _PollBar(option: option, total: post.pollOptions!.fold(0, (sum, o) => sum + o.voteCount)),
          ],
          if (post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 9),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final tag in post.hashtags) TagChip(label: tag, color: colors.accent)],
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              _ActionIcon(
                icon: liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: liked ? colors.danger : colors.textDim,
                label: '${post.likeCount}',
                onTap: () => ref.read(campusFeedControllerProvider.notifier).toggleLike(post.id),
              ),
              const SizedBox(width: 18),
              _ActionIcon(
                icon: CupertinoIcons.bubble_left,
                color: colors.textDim,
                label: '${post.commentCount}',
                onTap: onOpen ?? () => context.push(AppRoutes.campusNetworkPostPath(post.id)),
              ),
              const SizedBox(width: 18),
              _ActionIcon(
                icon: CupertinoIcons.arrowshape_turn_up_right,
                color: colors.textDim,
                label: '${post.shareCount}',
                onTap: () => AppSnackbar.show(context, message: 'Shared · simulated, no backend in this build.'),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => ref.read(campusFeedControllerProvider.notifier).toggleBookmark(post.id),
                child: Icon(
                  bookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                  size: 17,
                  color: bookmarked ? colors.accent : colors.textDim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PollBar extends StatelessWidget {
  const _PollBar({required this.option, required this.total});
  final PollOption option;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final fraction = total == 0 ? 0.0 : option.voteCount / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(option.label, style: text.footnote.copyWith(fontWeight: FontWeight.w500)),
              Text('${(fraction * 100).round()}%', style: text.footnote.copyWith(color: colors.textMuted)),
            ],
          ),
          const SizedBox(height: 3),
          AppProgressBar(value: fraction, color: colors.accent, height: 5),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, required this.color, required this.label, required this.onTap});
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 5),
          Text(label, style: context.textStyles.footnote.copyWith(color: color)),
        ],
      ),
    );
  }
}

String _relativeTime(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inMinutes < 60) return '${diff.inMinutes}m';
  if (diff.inHours < 24) return '${diff.inHours}h';
  return '${diff.inDays}d';
}
