import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/home_providers.dart';

/// The hero card: live countdown, room, and a change badge that appears the
/// moment the registrar pushes an update.
class NextUpCard extends ConsumerWidget {
  const NextUpCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final countdown = ref.watch(nextClassCountdownProvider);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NEXT UP', style: text.caption2.copyWith(color: colors.accent, fontSize: 12, fontWeight: FontWeight.w700)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.tint(colors.warning, 0.14), borderRadius: AppRadius.smRadius),
                  child: Text(
                    'Room changed · 2m ago',
                    style: text.caption1.copyWith(color: colors.warning, fontWeight: FontWeight.w600, fontSize: 11),
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).fadeIn(duration: 1200.ms).fadeOut(delay: 1200.ms, duration: 1200.ms),
              ],
            ),
            const SizedBox(height: 10),
            Text('Data Structures', style: text.title1.copyWith(fontSize: 26, letterSpacing: -0.5)),
            const SizedBox(height: 3),
            Text('CS402 · Dr. Hesham · Hall B2', style: text.body.copyWith(color: colors.textMuted, fontSize: 15)),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('10:30', style: text.monoLarge),
                const SizedBox(width: 8),
                Text(countdown, style: text.headline.copyWith(color: colors.info, fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
