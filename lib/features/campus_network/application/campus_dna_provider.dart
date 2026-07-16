import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../curriculum/data/curriculum_repository.dart';
import '../../curriculum/domain/catalog_course.dart';
import '../../transcript/application/transcript_enrichment.dart';
import '../../transcript/data/transcript_repository.dart';

/// "Campus DNA" — but honest about what this app can and can't actually
/// know about a student's learning habits. There is no activity-tracking
/// system anywhere in O6U Nexus (no session logs, no time-of-day usage
/// data), so "best study time," "preferred learning style," and
/// "productivity trends" have no real data source and are deliberately
/// **not** modeled here at all — not even as null placeholders that invite
/// a future fake value. What *is* real and computed live: strongest/
/// weakest course category (grade-points-per-credit-hour, averaged per
/// bylaw [CourseCategory], from the real transcript) and the real
/// semester-over-semester GPA trend (reusing [semesterGpaTrendProvider]).
class CampusDnaInsight {
  const CampusDnaInsight({
    this.strongestCategory,
    this.strongestCategoryAvgGpa,
    this.weakestCategory,
    this.weakestCategoryAvgGpa,
    required this.gpaTrend,
    this.trendDirection,
  });

  final CourseCategory? strongestCategory;
  final double? strongestCategoryAvgGpa;
  final CourseCategory? weakestCategory;
  final double? weakestCategoryAvgGpa;
  final List<double> gpaTrend;
  final String? trendDirection;
}

final campusDnaProvider = FutureProvider<CampusDnaInsight>((ref) async {
  final semesters = await ref.watch(enrichedTranscriptProvider.future);
  final catalog = await ref.watch(curriculumProvider.future);
  final trend = await ref.watch(semesterGpaTrendProvider.future);

  final catalogByCode = {for (final course in catalog) course.code: course};
  final gradePointsByCategory = <CourseCategory, List<double>>{};

  for (final semester in semesters) {
    for (final course in semester.courses) {
      final catalogCourse = catalogByCode[course.code];
      final hours = course.creditHours;
      final points = course.points;
      if (catalogCourse == null || hours == null || hours == 0 || points == null) continue;
      gradePointsByCategory.putIfAbsent(catalogCourse.category, () => []).add(points / hours);
    }
  }

  CourseCategory? strongest;
  CourseCategory? weakest;
  double? strongestAvg;
  double? weakestAvg;
  for (final entry in gradePointsByCategory.entries) {
    final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
    if (strongestAvg == null || avg > strongestAvg) {
      strongestAvg = avg;
      strongest = entry.key;
    }
    if (weakestAvg == null || avg < weakestAvg) {
      weakestAvg = avg;
      weakest = entry.key;
    }
  }

  String? trendDirection;
  if (trend.length >= 2) {
    final delta = trend.last - trend[trend.length - 2];
    trendDirection = delta > 0.05 ? 'Improving' : (delta < -0.05 ? 'Declining' : 'Stable');
  }

  return CampusDnaInsight(
    strongestCategory: strongest,
    strongestCategoryAvgGpa: strongestAvg,
    weakestCategory: weakest,
    weakestCategoryAvgGpa: weakestAvg,
    gpaTrend: trend,
    trendDirection: trendDirection,
  );
});
