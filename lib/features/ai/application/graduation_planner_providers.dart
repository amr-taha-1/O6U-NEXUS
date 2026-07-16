import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/domain/graduation_step.dart';
import '../../degree_progress/data/degree_progress_repository.dart';

/// Nexus's own read of the same real `DegreeProgress` record Academics'
/// "Graduation Progress" screen uses (`degreeProgressProvider`) — four
/// real requirement categories plus a final real-hours-remaining step.
/// Previously this was a fully independent, static 6-step plan (Level
/// 1–4/Summer/"Graduation Aug 2027 · 96%") that didn't derive from any real
/// data and diverged from the real record; it now reads the same source of
/// truth, just narrated in Nexus's voice.
final aiGraduationStepsProvider = FutureProvider<List<GraduationStep>>((ref) async {
  final progress = await ref.watch(degreeProgressProvider.future);
  final c = AppColors.dark;

  final steps = <GraduationStep>[
    for (final category in progress.categories)
      GraduationStep(
        title: category.name,
        subtitle: '${category.completedHours} of ${category.requiredHours} hours',
        statusLabel: category.remainingHours <= 0 ? 'Done' : '${category.remainingHours} left',
        status: category.remainingHours <= 0 ? GraduationStepStatus.done : GraduationStepStatus.now,
        accent: category.remainingHours <= 0 ? c.success : c.accent,
      ),
  ];

  steps.add(
    GraduationStep(
      title: 'Graduation',
      subtitle: '${progress.graduationHoursCompleted} of ${progress.graduationHoursRequired} hours overall',
      statusLabel: '${(progress.overallProgress * 100).round()}%',
      status: GraduationStepStatus.forecast,
      accent: c.info,
    ),
  );

  return steps;
});
