import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/json_asset_loader.dart';
import '../domain/catalog_course.dart';

const _assetPath = 'assets/data/bylaw_information_systems.json';

const _categoryByJsonValue = <String, CourseCategory>{
  'general_education': CourseCategory.generalEducation,
  'basic_science': CourseCategory.basicScience,
  'major_mandatory': CourseCategory.majorMandatory,
  'general_major': CourseCategory.generalMajor,
  'mutual': CourseCategory.mutual,
  'elective': CourseCategory.elective,
};

/// Reads the Information Systems curriculum (the signed-in student's major)
/// from the department bylaw, `assets/data/bylaw_information_systems.json`
/// — a temporary local data source until October 6 University provides an
/// official API. See docs/Architecture.md "Real data".
class CurriculumRepository {
  const CurriculumRepository();

  Future<List<CatalogCourse>> getCatalog() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    final rows = json['courses'] as List<dynamic>;
    return [
      for (final row in rows.cast<Map<String, dynamic>>())
        CatalogCourse(
          code: row['code'] as String,
          name: row['name'] as String,
          creditHours: row['creditHours'] as int,
          yearLevel: row['yearLevel'] as int,
          category: _categoryByJsonValue[row['category'] as String]!,
          prerequisites: (row['prerequisites'] as List<dynamic>).cast<String>(),
        ),
    ];
  }

  /// Article 40 of the bylaw: the minimum completed credit hours before a
  /// student may register the graduation project (`FRM416`).
  Future<int> getMinCreditHoursForGraduationProject() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    return json['minCreditHoursForGraduationProject'] as int;
  }
}

final curriculumRepositoryProvider = Provider<CurriculumRepository>((ref) => const CurriculumRepository());

final curriculumProvider = FutureProvider<List<CatalogCourse>>((ref) {
  return ref.watch(curriculumRepositoryProvider).getCatalog();
});

final minCreditHoursForGraduationProjectProvider = FutureProvider<int>((ref) {
  return ref.watch(curriculumRepositoryProvider).getMinCreditHoursForGraduationProject();
});
