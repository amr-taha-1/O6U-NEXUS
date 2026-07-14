import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/schedule_item.dart';
import '../../application/academics_providers.dart';

/// The week, with the room changes already applied. Ports the reference's
/// `Schedule` component (SPECS.schedule) — the week strip pins today, and
/// free hours are drawn as blocks Nexus already filled.
class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final days = ref.watch(weekStripProvider);
    final rows = ref.watch(weekScheduleProvider);

    return AppPushScaffold(
      title: 'Schedule',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Row(
              children: [
                for (var i = 0; i < days.length; i++) ...[
                  Expanded(child: _WeekDayTile(day: days[i])),
                  if (i < days.length - 1) const SizedBox(width: 6),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(children: [for (final row in rows) _ScheduleRow(item: row)]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              dashed: true,
              child: Row(
                children: [
                  Icon(CupertinoIcons.calendar, size: 16, color: colors.info),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Two rooms changed this week. Your timetable updated itself.',
                      style: text.subhead.copyWith(fontSize: 13.5),
                    ),
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

class _WeekDayTile extends StatelessWidget {
  const _WeekDayTile({required this.day});
  final WeekDay day;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final on = day.isToday;
    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: on ? colors.accentDeep : colors.surface,
        borderRadius: AppRadius.mdRadius,
        border: on ? null : Border.all(color: colors.hairline, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.label,
            style: text.caption1.copyWith(color: on ? colors.onAccent.withValues(alpha: 0.75) : colors.textDim, fontSize: 11),
          ),
          const SizedBox(height: 3),
          Text(
            '${day.date}',
            style: text.monoSmall.copyWith(color: on ? colors.onAccent : colors.textPrimary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.item});
  final ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 46,
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(item.time, textAlign: TextAlign.right, style: text.monoMicro.copyWith(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 12),
            Container(width: 3, decoration: BoxDecoration(color: item.accent, borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 12),
            Expanded(
              child: AppCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.title, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(item.meta, style: text.subhead.copyWith(fontSize: 13)),
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
