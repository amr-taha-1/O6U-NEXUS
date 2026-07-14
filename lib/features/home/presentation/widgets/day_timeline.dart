import 'package:flutter/widgets.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/schedule_item.dart';

/// The day as a timeline, not a list — gaps render as first-class items,
/// because gaps are where the AI acts.
class DayTimeline extends StatelessWidget {
  const DayTimeline({super.key, required this.items});

  final List<ScheduleItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 44,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        items[i].time,
                        textAlign: TextAlign.right,
                        style: text.monoMicro.copyWith(fontSize: 12, color: colors.textDim),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: items[i].isAiPlaced ? null : items[i].accent,
                            border: items[i].isAiPlaced ? Border.all(color: items[i].accent, width: 1.5) : null,
                          ),
                        ),
                      ),
                      if (i < items.length - 1) Expanded(child: Container(width: 1, color: colors.hairline)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AppCard(
                        padding: const EdgeInsets.all(12),
                        dashed: items[i].isAiPlaced,
                        child: Row(
                          children: [
                            Icon(items[i].icon, size: 16, color: items[i].accent),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(items[i].title, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                                  const SizedBox(height: 1),
                                  Text(
                                    items[i].meta,
                                    style: text.footnote.copyWith(color: items[i].isAiPlaced ? colors.success : colors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
