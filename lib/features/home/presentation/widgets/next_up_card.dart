import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../schedule/application/schedule_providers.dart';

/// The hero card: the real next class from the real schedule
/// (`nextSessionProvider`/`minutesUntilNextSessionProvider`), the same
/// source Academics and Schedule already use — see docs/Architecture.md
/// "Real data".
class NextUpCard extends ConsumerWidget {
  const NextUpCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final nextAsync = ref.watch(nextSessionProvider);
    final minutesUntilAsync = ref.watch(minutesUntilNextSessionProvider);
    final next = nextAsync.valueOrNull;

    if (next == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        child: AppCard(
          child: Text(
            nextAsync.isLoading ? 'Loading your schedule…' : 'No upcoming classes on your real schedule.',
            style: text.body.copyWith(color: colors.textMuted),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: AppCard(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.tint(colors.accentDeep, 0.28),
            AppColors.tint(colors.infoDeep, 0.12),
            colors.surface,
          ],
          stops: const [0, 0.6, 1],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NEXT UP', style: text.caption2.copyWith(color: colors.accent, fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text(next.courseName, style: text.title1.copyWith(fontSize: 26, letterSpacing: -0.5)),
            const SizedBox(height: 3),
            Text(
              '${next.courseCode}${next.instructor != null ? ' · ${next.instructor}' : ''} · Room ${next.room}',
              style: text.body.copyWith(color: colors.textMuted, fontSize: 15),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(next.startLabel, style: text.monoLarge),
                const SizedBox(width: 8),
                Text(_untilLabel(minutesUntilAsync.valueOrNull), style: text.headline.copyWith(color: colors.info, fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _untilLabel(int? minutes) {
  if (minutes == null) return '';
  if (minutes <= 0) return 'now';
  if (minutes < 60) return 'in ${minutes}m';
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  if (hours < 24) return 'in ${hours}h ${mins}m';
  final days = hours ~/ 24;
  return 'in $days ${days == 1 ? 'day' : 'days'}';
}
