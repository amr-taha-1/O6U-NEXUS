import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/schedule/application/schedule_providers.dart';
import '../../../../features/schedule/domain/schedule_session.dart';

/// The real weekly Summer-term schedule (`assets/data/schedule.json`) —
/// filtered to the student's own registered courses. Lecture vs. Lab is the
/// department's own rule for reading an instructor's title (see
/// `SessionType` doc comment): each gets a distinct icon and color, never
/// interchangeable. See docs/Architecture.md "Real data".
class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyAsync = ref.watch(weeklyScheduleProvider);
    final nextAsync = ref.watch(nextSessionProvider);
    final minutesUntilAsync = ref.watch(minutesUntilNextSessionProvider);

    return AppPushScaffold(
      title: 'Schedule',
      body: weeklyAsync.when(
        data: (byDay) => _ScheduleBody(
          byDay: byDay,
          next: nextAsync.valueOrNull,
          minutesUntilNext: minutesUntilAsync.valueOrNull,
        ),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Column(
            children: [
              SkeletonBox(height: 90, borderRadius: BorderRadius.all(Radius.circular(18))),
              SizedBox(height: 12),
              SkeletonListTile(isFirst: true),
              SkeletonListTile(),
            ],
          ),
        ),
        error: (error, stackTrace) => StatusPlaceholder.error(message: 'Couldn\'t load your schedule: $error'),
      ),
    );
  }
}

class _ScheduleBody extends StatelessWidget {
  const _ScheduleBody({required this.byDay, required this.next, required this.minutesUntilNext});
  final Map<Weekday, List<ScheduleSession>> byDay;
  final ScheduleSession? next;
  final int? minutesUntilNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (next != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: _NextClassCard(session: next!, minutesUntil: minutesUntilNext),
          ),
        const SectionHeader('This week'),
        for (final day in weekdayOrder)
          if (byDay[day]!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: _DaySection(day: day, sessions: byDay[day]!),
            ),
      ],
    );
  }
}

class _NextClassCard extends StatelessWidget {
  const _NextClassCard({required this.session, required this.minutesUntil});
  final ScheduleSession session;
  final int? minutesUntil;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final style = _typeStyle(colors, session.type);

    return AppCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.tint(style.color, 0.22), colors.surface],
      ),
      onTap: () => context.push(AppRoutes.courseDetailsPath(session.courseCode)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(style.icon, size: 22, color: style.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('NEXT ${style.label.toUpperCase()}', style: text.caption2.copyWith(color: style.color, letterSpacing: 0.7)),
                const SizedBox(height: 3),
                Text(session.courseName, style: text.title3.copyWith(fontSize: 18)),
                const SizedBox(height: 2),
                Text(
                  '${session.day.label} · ${session.timeRangeLabel} · Room ${session.room}',
                  style: text.subhead.copyWith(fontSize: 13),
                ),
                if (session.instructor != null) ...[
                  const SizedBox(height: 1),
                  Text(session.instructor!, style: text.footnote.copyWith(color: colors.textDim, fontSize: 12.5)),
                ],
                if (minutesUntil != null) ...[
                  const SizedBox(height: 6),
                  Text(_untilLabel(minutesUntil!), style: text.footnote.copyWith(color: colors.textDim)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _untilLabel(int minutes) {
    if (minutes < 60) return 'In $minutes min';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours < 24) return 'In ${hours}h ${mins}m';
    final days = hours ~/ 24;
    return 'In $days ${days == 1 ? 'day' : 'days'}';
  }
}

class _DaySection extends StatelessWidget {
  const _DaySection({required this.day, required this.sessions});
  final Weekday day;
  final List<ScheduleSession> sessions;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day.label, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
          const SizedBox(height: 8),
          for (final session in sessions) Padding(padding: const EdgeInsets.only(bottom: 8), child: _SessionCard(session: session)),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final ScheduleSession session;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final style = _typeStyle(colors, session.type);

    return AppCard(
      padding: const EdgeInsets.all(13),
      onTap: () => context.push(AppRoutes.courseDetailsPath(session.courseCode)),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: AppColors.tint(style.color, 0.16), borderRadius: AppRadius.smRadius),
            alignment: Alignment.center,
            child: Icon(style.icon, size: 16, color: style.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(session.courseName, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                const SizedBox(height: 1),
                Text(
                  '${session.courseCode} · ${session.timeRangeLabel} · Room ${session.room}',
                  style: text.footnote,
                ),
                if (session.instructor != null) ...[
                  const SizedBox(height: 1),
                  Text(session.instructor!, style: text.footnote.copyWith(color: colors.textDim)),
                ],
              ],
            ),
          ),
          TagChip(label: style.label, color: style.color),
        ],
      ),
    );
  }
}

class _TypeStyle {
  const _TypeStyle({required this.label, required this.icon, required this.color});
  final String label;
  final IconData icon;
  final Color color;
}

_TypeStyle _typeStyle(AppColors colors, SessionType type) => switch (type) {
  SessionType.lecture => _TypeStyle(label: 'Lecture', icon: CupertinoIcons.book, color: colors.info),
  SessionType.lab => _TypeStyle(label: 'Lab', icon: CupertinoIcons.lab_flask, color: colors.warning),
};
