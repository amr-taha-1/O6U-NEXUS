import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/campus_video_repository.dart';
import '../../domain/campus_video.dart';

/// Short educational videos — the "TikTok/Reels for O6U" section. See
/// [CampusVideo]'s doc comment: no real playback in this build (no native
/// video dependency), so tapping a card is a simulated "Play" action, same
/// pattern as "Export official PDF." Everything else — the feed, topics,
/// engagement counts, save/follow — is real, working UI.
class CampusVideosScreen extends ConsumerWidget {
  const CampusVideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(campusVideosProvider);
    final colors = context.colors;
    final text = context.textStyles;

    return AppPushScaffold(
      title: 'Campus Shorts',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        child: Column(
          children: [
            for (final video in videos)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => AppSnackbar.show(context, message: 'Playback unavailable in this build — no video-player dependency.'),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 74,
                        decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), borderRadius: AppRadius.mdRadius),
                        alignment: Alignment.center,
                        child: Icon(CupertinoIcons.play_fill, size: 20, color: colors.accent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(video.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                            const SizedBox(height: 2),
                            Text('${video.creator.fullName} · ${video.durationSeconds}s', style: text.footnote.copyWith(color: colors.textMuted)),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 10,
                              children: [
                                _MiniStat(icon: CupertinoIcons.heart, value: video.likeCount),
                                _MiniStat(icon: CupertinoIcons.bubble_left, value: video.commentCount),
                                _MiniStat(icon: CupertinoIcons.bookmark, value: video.saveCount),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TagChip(label: video.topic.label, color: colors.info),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.icon, required this.value});
  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: colors.textDim),
        const SizedBox(width: 3),
        Text('$value', style: context.textStyles.caption1.copyWith(color: colors.textMuted)),
      ],
    );
  }
}
