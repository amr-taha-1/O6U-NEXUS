import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// iOS-native segmented control (Campus tab's Market / Lost & Found / Groups
/// / Events switcher). Not `CupertinoSlidingSegmentedControl` because that
/// widget requires a generic value type per segment; this app always
/// switches on a plain index.
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colors.textPrimary.withValues(alpha: 0.06),
        borderRadius: AppRadius.mdRadius,
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: AppMotion.fast,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selectedIndex ? colors.textPrimary.withValues(alpha: 0.13) : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    labels[i],
                    style: (i == selectedIndex ? text.footnote.copyWith(fontWeight: FontWeight.w600) : text.footnote)
                        .copyWith(color: i == selectedIndex ? colors.textPrimary : colors.textMuted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
