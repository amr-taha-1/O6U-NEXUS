import 'package:flutter/cupertino.dart';

import '../theme/theme.dart';

/// The collapsing large-title scaffold used by every top-level tab (Home,
/// Academics, AI, Campus, Profile) — ports the reference's `Nav` component,
/// which is exactly what [CupertinoSliverNavigationBar] already does
/// natively, so we lean on it instead of hand-rolling scroll-linked opacity.
class LargeTitleScaffold extends StatelessWidget {
  const LargeTitleScaffold({
    super.key,
    required this.title,
    required this.body,
    this.trailing,
    this.bottomPadding = 100,
  });

  final String title;
  final Widget body;
  final Widget? trailing;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(color: colors.ink),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(title, style: context.textStyles.largeTitle),
            middle: Text(title, style: context.textStyles.headline),
            automaticallyImplyLeading: false,
            backgroundColor: colors.ink.withValues(alpha: 0.74),
            border: null,
            trailing: trailing,
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.only(bottom: bottomPadding), child: body),
          ),
        ],
      ),
    );
  }
}

/// A back-button + centered-title top bar for pushed sub-screens (Schedule,
/// Grades, Attendance, …) — the reference's `Push` component.
class AppPushScaffold extends StatelessWidget {
  const AppPushScaffold({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return CupertinoPageScaffold(
      backgroundColor: colors.ink,
      navigationBar: CupertinoNavigationBar(
        middle: Text(title, style: context.textStyles.headline),
        backgroundColor: colors.ink.withValues(alpha: 0.8),
        border: Border(bottom: BorderSide(color: colors.hairline, width: 0.5)),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 110),
          children: [body],
        ),
      ),
    );
  }
}
