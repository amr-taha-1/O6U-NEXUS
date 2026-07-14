import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/graduation_step.dart';

/// Nexus's own build of the six-step path to graduation — a separate,
/// independently-built provider from Academics' "Graduation Progress" record
/// (see graduation_planner_screen.dart's doc comment for why). Reuses the
/// shared [GraduationStep] shape but not Academics' provider or fixture
/// instance; a little duplication here is expected.
final aiGraduationStepsProvider = Provider<List<GraduationStep>>((ref) {
  final c = AppColors.dark;
  return [
    GraduationStep(
      title: 'Level 1',
      subtitle: '30 hrs',
      statusLabel: 'Done',
      status: GraduationStepStatus.done,
      accent: c.success,
    ),
    GraduationStep(
      title: 'Level 2',
      subtitle: '32 hrs',
      statusLabel: 'Done',
      status: GraduationStepStatus.done,
      accent: c.success,
    ),
    GraduationStep(
      title: 'Level 3',
      subtitle: '30 hrs',
      statusLabel: 'Done',
      status: GraduationStepStatus.done,
      accent: c.success,
    ),
    GraduationStep(
      title: 'Level 4',
      subtitle: '18 hrs',
      statusLabel: 'Now',
      status: GraduationStepStatus.now,
      accent: c.accent,
    ),
    GraduationStep(
      title: 'Summer',
      subtitle: '6 hrs',
      statusLabel: 'Advised',
      status: GraduationStepStatus.advised,
      accent: c.warning,
    ),
    GraduationStep(
      title: 'Graduation',
      subtitle: 'Aug 2027',
      statusLabel: '96%',
      status: GraduationStepStatus.forecast,
      accent: c.info,
    ),
  ];
});
