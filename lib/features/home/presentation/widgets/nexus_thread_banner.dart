import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/home_providers.dart';

/// The Nexus thread — a hairline that only swells into a card when it has
/// something actionable. Dismissing it (either button) hides it for the
/// rest of the session. See docs/reference/o6u-nexus-ios.tsx SPECS.today
/// pin #1.
class NexusThreadBanner extends ConsumerWidget {
  const NexusThreadBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(nexusThreadVisibleProvider);
    final colors = context.colors;
    final text = context.textStyles;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 2,
            margin: EdgeInsets.only(bottom: visible ? 12 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [colors.ink.withValues(alpha: 0), colors.accent, colors.info, colors.ink.withValues(alpha: 0)],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).fadeIn(duration: 1700.ms).fadeOut(delay: 1700.ms, duration: 1700.ms),
          if (visible)
            AppCard(
              tier: AppCardTier.raised,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(color: AppColors.tint(colors.accentDeep, 0.9), borderRadius: AppRadius.smRadius),
                    alignment: Alignment.center,
                    child: Icon(CupertinoIcons.sparkles, size: 15, color: colors.onAccent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You have a 3-hour gap after CS402.', style: text.bodyEmphasized),
                        const SizedBox(height: 2),
                        Text(
                          "Library Room 4 is free until 15:00. It's your best window to revise before Thursday's quiz.",
                          style: text.callout,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            AppButton(
                              label: 'Book the room',
                              onPressed: () => ref.read(nexusThreadVisibleProvider.notifier).dismiss(),
                            ),
                            const SizedBox(width: 8),
                            AppButton(
                              label: 'Not today',
                              variant: AppButtonVariant.secondary,
                              onPressed: () => ref.read(nexusThreadVisibleProvider.notifier).dismiss(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: AppMotion.entrance).slideY(begin: 0.08, end: 0),
        ],
      ),
    );
  }
}
