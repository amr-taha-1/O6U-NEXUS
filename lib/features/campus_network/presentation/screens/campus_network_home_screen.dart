import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../schedule/application/schedule_providers.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../../shared/domain/student.dart';
import '../../application/campus_economy.dart';
import '../../application/campus_intelligence_feed_provider.dart';
import '../../domain/smart_feed_item.dart';

/// "Campus OS" — the Campus Network module's own home screen (deliberately
/// separate from the app-wide Home tab, which stays untouched per this
/// phase's "do not modify existing features" constraint). Greeting, today's
/// classes, missions, streak/XP/coins, and a personalized smart feed —
/// everything sourced from real providers except where explicitly labelled
/// otherwise. Weather is intentionally omitted: it needs a real weather API
/// key this build has no credentials for (see the closing report's Skipped
/// list) rather than a fabricated forecast.
class CampusNetworkHomeScreen extends ConsumerWidget {
  const CampusNetworkHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(currentStudentProvider);
    final todaysSessionsAsync = ref.watch(todaysSessionsProvider);
    final minutesUntilAsync = ref.watch(minutesUntilNextSessionProvider);
    final nextSessionAsync = ref.watch(nextSessionProvider);
    final feedAsync = ref.watch(campusIntelligenceFeedProvider);
    final xp = ref.watch(campusXpProvider);
    final coins = ref.watch(campusCoinsBalanceProvider);
    final streak = ref.watch(campusStreakProvider);

    final colors = context.colors;
    final text = context.textStyles;
    final greeting = _greetingForHour(DateTime.now().hour);

    return LargeTitleScaffold(
      title: 'Campus Network',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Text(
              studentAsync.when(
                data: (student) => '$greeting, ${student.firstName} 👋',
                loading: () => '$greeting 👋',
                error: (error, stackTrace) => '$greeting 👋',
              ),
              style: text.title2,
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Row(
              children: [
                Expanded(child: _StatTile(icon: CupertinoIcons.flame_fill, label: 'Streak', value: '$streak day${streak == 1 ? '' : 's'}', color: colors.due)),
                const SizedBox(width: 8),
                Expanded(child: _StatTile(icon: CupertinoIcons.bolt_fill, label: 'XP', value: '$xp', color: colors.accent)),
                const SizedBox(width: 8),
                Expanded(child: _StatTile(icon: CupertinoIcons.money_dollar_circle_fill, label: 'Coins', value: '$coins', color: colors.warning)),
              ],
            ),
          ),
          if (nextSessionAsync.valueOrNull != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 14, AppSpacing.screenMargin, 0),
              child: AppCard(
                onTap: () => context.push(AppRoutes.academicsSchedule),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.timer, size: 18, color: colors.info),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Next: ${nextSessionAsync.value!.courseName}', style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                          Text(_untilLabel(minutesUntilAsync.valueOrNull), style: text.footnote.copyWith(color: colors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SectionHeader("Today's classes"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: todaysSessionsAsync.when(
              data: (sessions) => sessions.isEmpty
                  ? Text('No classes today.', style: text.footnote.copyWith(color: colors.textDim))
                  : Column(
                      children: [
                        for (final session in sessions)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.circle_fill, size: 6, color: colors.accent),
                                const SizedBox(width: 8),
                                Expanded(child: Text('${session.courseName} · ${session.timeRangeLabel}', style: text.footnote)),
                              ],
                            ),
                          ),
                      ],
                    ),
              loading: () => const SkeletonBox(height: 16),
              error: (error, stackTrace) => Text('Couldn\'t load today\'s classes.', style: text.footnote.copyWith(color: colors.textDim)),
            ),
          ),
          const SectionHeader('For you'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: feedAsync.when(
              data: (items) => items.isEmpty
                  ? const StatusPlaceholder.empty(icon: CupertinoIcons.sparkles, title: 'All caught up', message: 'Nothing new to surface right now.')
                  : Column(
                      children: [for (final item in items) Padding(padding: const EdgeInsets.only(bottom: 8), child: _FeedItemCard(item: item))],
                    ),
              loading: () => const SkeletonListTile(isFirst: true),
              error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your feed: $error'),
            ),
          ),
          const SectionHeader('Explore Campus Network'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.chat_bubble_2,
                    iconColor: colors.info,
                    title: 'Campus Community',
                    subtitle: 'Posts, questions, study notes, polls',
                    onTap: () => context.push(AppRoutes.campusNetworkFeed),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.person_crop_circle,
                    iconColor: colors.accent,
                    title: 'My Profile & Portfolio',
                    subtitle: 'Skills, projects, certificates, reputation',
                    onTap: () => context.push(AppRoutes.campusNetworkMemberPath('me')),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.rectangle_stack_person_crop,
                    iconColor: colors.success,
                    title: 'Study Groups',
                    subtitle: 'Join a session for one of your courses',
                    onTap: () => context.push(AppRoutes.campusNetworkStudyGroups),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.person_3,
                    iconColor: colors.warning,
                    title: 'Clubs',
                    subtitle: 'IEEE, GDG, ICPC, Rotaract, Student Union',
                    onTap: () => context.push(AppRoutes.campusNetworkClubs),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.flag_fill,
                    iconColor: colors.due,
                    title: 'Challenges',
                    subtitle: 'Daily, weekly, and semester missions',
                    onTap: () => context.push(AppRoutes.campusNetworkChallenges),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.chart_bar_fill,
                    iconColor: colors.accent,
                    title: 'Leaderboards',
                    subtitle: 'Top GPA, developers, volunteers, and more',
                    onTap: () => context.push(AppRoutes.campusNetworkLeaderboards),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.play_rectangle,
                    iconColor: colors.info,
                    title: 'Campus Shorts',
                    subtitle: 'Short educational videos from students',
                    onTap: () => context.push(AppRoutes.campusNetworkVideos),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.waveform_path_ecg,
                    iconColor: colors.success,
                    title: 'Campus DNA',
                    subtitle: 'Your real strongest/weakest subjects and GPA trend',
                    onTap: () => context.push(AppRoutes.campusNetworkDna),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.cart,
                    iconColor: colors.warning,
                    title: 'Academic Marketplace',
                    subtitle: 'Books, calculators, lab kits, and more',
                    onTap: () => context.push(AppRoutes.campusBookExchange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _greetingForHour(int hour) {
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

String _untilLabel(int? minutes) {
  if (minutes == null) return '';
  if (minutes < 60) return 'In $minutes min';
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  if (hours < 24) return 'In ${hours}h ${mins}m';
  final days = hours ~/ 24;
  return 'In $days ${days == 1 ? 'day' : 'days'}';
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 4),
          Text(value, style: text.bodyEmphasized.copyWith(fontSize: 15)),
          Text(label, style: text.footnote.copyWith(fontSize: 11, color: context.colors.textMuted)),
        ],
      ),
    );
  }
}

class _FeedItemCard extends StatelessWidget {
  const _FeedItemCard({required this.item});
  final SmartFeedItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppCard(
      padding: const EdgeInsets.all(13),
      onTap: () => context.push(item.route),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.14), borderRadius: AppRadius.smRadius),
            alignment: Alignment.center,
            child: Icon(_iconFor(item.kind), size: 15, color: colors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title, style: text.bodyEmphasized.copyWith(fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(item.subtitle, style: text.footnote.copyWith(color: colors.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(CupertinoIcons.chevron_forward, size: 13, color: colors.textDim),
        ],
      ),
    );
  }
}

IconData _iconFor(SmartFeedItemKind kind) => switch (kind) {
      SmartFeedItemKind.upcomingClass => CupertinoIcons.calendar,
      SmartFeedItemKind.recommendedStudyGroup => CupertinoIcons.person_2,
      SmartFeedItemKind.nearbyCarpool => CupertinoIcons.car_detailed,
      SmartFeedItemKind.trendingPost => CupertinoIcons.flame,
      SmartFeedItemKind.upcomingClubEvent => CupertinoIcons.calendar_badge_plus,
      SmartFeedItemKind.degreeProgressNudge => CupertinoIcons.flag,
      SmartFeedItemKind.recommendedCourse => CupertinoIcons.book,
    };
