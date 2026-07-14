import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Uppercase section label (the reference's `Section` component). Every list
/// grouping on every screen uses this — never an ad hoc `Text`.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.label, {super.key, this.topPadding = 22});

  final String label;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, topPadding, AppSpacing.screenMargin, 10),
      child: Text(label.toUpperCase(), style: context.textStyles.caption2),
    );
  }
}
