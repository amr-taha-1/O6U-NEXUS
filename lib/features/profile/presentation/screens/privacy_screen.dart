import 'package:flutter/cupertino.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class _DataCategory {
  const _DataCategory(this.icon, this.color, this.title, this.body);
  final IconData icon;
  final Color Function(AppColors) color;
  final String title;
  final String body;
}

final _categories = [
  _DataCategory(
    CupertinoIcons.doc_text,
    (c) => c.info,
    'Transcript & grades',
    'Read-only. Nexus uses it to answer questions like "why is my GPA dropping" — it never edits a grade.',
  ),
  _DataCategory(
    CupertinoIcons.qrcode_viewfinder,
    (c) => c.success,
    'Attendance',
    'Read-only. Used to warn you before a course drops below the university\'s 75% threshold.',
  ),
  _DataCategory(
    CupertinoIcons.sparkles,
    (c) => c.accent,
    'Nexus conversations',
    'Never seen by any lecturer or administrator. The university only ever receives anonymised, aggregated numbers — never a transcript of what you asked.',
  ),
  _DataCategory(
    CupertinoIcons.lock_shield,
    (c) => c.warning,
    'Password',
    'Never stored on this device or by Nexus. Signing in returns a short-lived Secure-Enclave token instead.',
  ),
];

/// "What O6U can access" — the hub's privacy card, expanded into a full
/// screen, in the words a student would use (docs/reference/o6u-nexus-ios.tsx
/// SPECS.me: "Privacy is written in the interface").
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppPushScaffold(
      title: 'Privacy',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 4),
            child: Text(
              'Every piece of your record that Nexus touches, and exactly what it\'s used for.',
              style: text.callout,
            ),
          ),
          const SectionHeader('What O6U can access'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final category in _categories)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AppCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Icon(category.icon, size: 18, color: category.color(colors)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category.title, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                                const SizedBox(height: 5),
                                Text(category.body, style: text.footnote.copyWith(fontSize: 13.5, height: 1.45)),
                              ],
                            ),
                          ),
                        ],
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
