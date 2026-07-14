import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show showLicensePage;

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// App mark, version, and the legal/credit rows a student would expect at
/// the bottom of Settings.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppPushScaffold(
      title: 'About',
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          const AppMark(size: 64),
          const SizedBox(height: AppSpacing.md),
          Text('O6U Nexus', style: text.title2),
          const SizedBox(height: 4),
          Text('Version 1.0.0', style: text.footnote),
          const SizedBox(height: AppSpacing.xxl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.globe,
                    iconColor: colors.info,
                    title: 'O6U website',
                    subtitle: 'o6u.edu.eg',
                    onTap: () => AppSnackbar.show(context, message: 'Simulated — no backend yet'),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.doc_text,
                    iconColor: colors.textMuted,
                    title: 'Terms of Service',
                    subtitle: 'Last updated 2026',
                    onTap: () => AppSnackbar.show(context, message: 'Simulated — no backend yet'),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.chevron_left_slash_chevron_right,
                    iconColor: colors.accent,
                    title: 'Open-source licenses',
                    subtitle: 'Packages used to build this app',
                    onTap: () => showLicensePage(
                      context: context,
                      applicationName: 'O6U Nexus',
                      applicationVersion: '1.0.0',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Text(
              'Built for October 6 University students.',
              style: text.footnote,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
