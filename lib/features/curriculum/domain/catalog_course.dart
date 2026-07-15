import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_course.freezed.dart';

/// Where a course sits in the department bylaw — drives grouping in the
/// Course Catalog screen. See docs/Architecture.md "Real data".
enum CourseCategory {
  generalEducation,
  basicScience,
  majorMandatory,
  /// Required of every major in the faculty (e.g. Operating Systems).
  generalMajor,
  /// Shared between two or more majors, per the bylaw's "Mutual Courses" table.
  mutual,
  elective,
}

/// A sentinel prerequisite: not a course code, but Article 40 of the bylaw
/// (the university-wide credit-hour threshold for registering a graduation
/// project) — see [CatalogCourse.requiresArticle40].
const articlefortyPrerequisite = 'ARTICLE_40';

/// One row of the official department bylaw
/// (`assets/data/bylaw_information_systems.json`) — the single source of
/// truth for prerequisites, credit hours, and curriculum structure. Nothing
/// in the curriculum engine hardcodes a prerequisite chain.
@freezed
abstract class CatalogCourse with _$CatalogCourse {
  const factory CatalogCourse({
    required String code,
    required String name,
    required int creditHours,
    required int yearLevel,
    required CourseCategory category,
    required List<String> prerequisites,
  }) = _CatalogCourse;

  const CatalogCourse._();

  bool get requiresArticle40 => prerequisites.contains(articlefortyPrerequisite);

  /// Prerequisite course codes, excluding the [articlefortyPrerequisite] sentinel.
  List<String> get prerequisiteCourseCodes => [for (final p in prerequisites) if (p != articlefortyPrerequisite) p];
}
