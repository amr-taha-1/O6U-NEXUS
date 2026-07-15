import 'package:flutter/widgets.dart';

import '../../../core/theme/theme.dart';

/// A darker red than [AppColors.danger], reserved for F/WF — distinguishes
/// "failed the course" from D/D+ ("passed, but barely") at a glance.
const Color kFailDeepRed = Color(0xFF7F1D1D);

/// Maps a transcript grade to its display color, per the grading-scale
/// legend: A/A- green, B+/B/B- blue, C+/C/C- orange (amber), D/D+ red,
/// F/WF deep red, W grey, PASS green, NOD neutral. The app is dark-first
/// with a real light-theme too, so this reads [AppColors] live rather than
/// baking in a fixed hex — "NOD = black" from a print-transcript's white
/// background becomes "NOD = plain ink" here: neutral, unlike W's dimmed
/// grey, but still legible on a dark surface.
Color gradeColor(AppColors colors, String grade) {
  final normalized = grade.trim().toUpperCase();
  switch (normalized) {
    case 'A':
    case 'A-':
    case 'PASS':
      return colors.success;
    case 'B+':
    case 'B':
    case 'B-':
      return colors.info;
    case 'C+':
    case 'C':
    case 'C-':
      return colors.warning;
    case 'D':
    case 'D+':
      return colors.danger;
    case 'F':
    case 'WF':
      return kFailDeepRed;
    case 'W':
      return colors.textDim;
    case 'NOD':
      return colors.textPrimary;
    default:
      return colors.textMuted;
  }
}

/// Whether [grade] counts toward GPA at all (W/WF/PASS/NOD don't carry
/// quality points the way lettered grades do).
bool gradeCountsTowardGpa(String grade) {
  const excluded = {'W', 'WF', 'PASS', 'NOD'};
  return !excluded.contains(grade.trim().toUpperCase());
}
