import 'package:flutter/widgets.dart';

import '../../../../core/theme/theme.dart';
import '../../application/trust_score.dart';

/// Renders a [TrustScore]'s badges as a wrap of emoji + label pills — the
/// 🟢/⭐/🚘/🎓/🏆 set called out in the feature request.
class TrustBadgeRow extends StatelessWidget {
  const TrustBadgeRow({super.key, required this.badges, this.spacing = 6});
  final List<TrustBadge> badges;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();
    final colors = context.colors;
    final text = context.textStyles;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        for (final badge in badges)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.12), borderRadius: AppRadius.smRadius),
            child: Text('${badge.emoji} ${badge.label}', style: text.caption1.copyWith(fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}

/// The "98/100 Excellent" trust-score readout.
class TrustScoreBadge extends StatelessWidget {
  const TrustScoreBadge({super.key, required this.score});
  final TrustScore score;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final color = score.score >= 75 ? colors.success : (score.score >= 50 ? colors.accent : colors.warning);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${score.score}', style: text.title3.copyWith(color: color, fontSize: 17)),
        Text('/100', style: text.footnote.copyWith(color: colors.textDim)),
        const SizedBox(width: 6),
        Text(score.label, style: text.footnote.copyWith(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
