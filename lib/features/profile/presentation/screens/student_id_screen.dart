import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/student_repository.dart';
import '../widgets/id_pattern.dart';
import '../widgets/profile_id_card.dart';

/// The full-screen digital ID — "the one screen that must render with no
/// network. It opens the turnstile." (docs/reference/o6u-nexus-ios.tsx,
/// SPECS.me). No loading state: the card is drawn straight from the
/// already-resident [currentStudentProvider].
class StudentIdScreen extends ConsumerWidget {
  const StudentIdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final student = ref.watch(currentStudentProvider);

    return AppPushScaffold(
      title: 'Student ID',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            ProfileIdCard(student: student, footnote: 'Opens the turnstile at every gate · works offline'),
            const SizedBox(height: AppSpacing.xxxl),
            Icon(CupertinoIcons.antenna_radiowaves_left_right, size: 28, color: colors.textDim),
            const SizedBox(height: AppSpacing.sm),
            Text('Hold near reader', style: text.headline),
            const SizedBox(height: 4),
            Text(
              'No connection required — this ID renders entirely from your device.',
              style: text.footnote,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            const IdPattern(size: 150),
          ],
        ),
      ),
    );
  }
}
