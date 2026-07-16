import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/datetime_format.dart';
import '../../data/club_repository.dart';
import '../../data/campus_post_repository.dart';
import '../widgets/post_card.dart';

/// One club's page: announcements, upcoming events, member count, and its
/// own filtered slice of the Campus Community feed (posts tagged with the
/// club's hashtag, e.g. `#IEEE`).
class ClubDetailsScreen extends ConsumerWidget {
  const ClubDetailsScreen({super.key, required this.clubId});
  final String clubId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = ref.watch(clubByIdProvider(clubId));
    if (club == null) {
      return const AppPushScaffold(
        title: 'Club',
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: StatusPlaceholder.empty(icon: CupertinoIcons.person_3, title: 'Club not found', message: 'This club may no longer exist.'),
        ),
      );
    }

    final colors = context.colors;
    final text = context.textStyles;
    final hashtag = '#${club.shortName.replaceAll(' ', '')}';
    final clubPosts = [for (final post in ref.watch(campusPostsProvider)) if (post.hashtags.contains(hashtag)) post];

    return AppPushScaffold(
      title: club.shortName,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(club.name, style: text.title3),
                  const SizedBox(height: 4),
                  Text(club.description, style: text.footnote),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(CupertinoIcons.person_2, size: 14, color: colors.textDim),
                      const SizedBox(width: 6),
                      Text('${club.memberCount} members', style: text.footnote.copyWith(color: colors.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (club.announcements.isNotEmpty) ...[
            const SectionHeader('Announcements'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < club.announcements.length; i++)
                      Container(
                        constraints: const BoxConstraints(minHeight: 48),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(border: i == 0 ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.speaker_1, size: 14, color: colors.warning),
                            const SizedBox(width: 10),
                            Expanded(child: Text(club.announcements[i], style: text.body.copyWith(fontSize: 14))),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
          if (club.events.isNotEmpty) ...[
            const SectionHeader('Events'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                children: [
                  for (final event in club.events)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), borderRadius: AppRadius.smRadius),
                              alignment: Alignment.center,
                              child: Icon(CupertinoIcons.calendar, size: 16, color: colors.accent),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(event.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                                  Text(
                                    '${formatShortDate(event.dateTime)} · ${formatTimeOfDay(event.dateTime)} · ${event.location}',
                                    style: text.footnote.copyWith(color: colors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SectionHeader('Posts'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: clubPosts.isEmpty
                ? StatusPlaceholder.empty(icon: CupertinoIcons.text_bubble, title: 'No posts yet', message: 'Nothing tagged $hashtag yet.')
                : Column(children: [for (final post in clubPosts) Padding(padding: const EdgeInsets.only(bottom: 10), child: PostCard(post: post))]),
          ),
        ],
      ),
    );
  }
}
