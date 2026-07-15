import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/json_asset_loader.dart';
import '../domain/student.dart';

const _assetPath = 'assets/data/student.json';

/// Reads the signed-in student's profile from `assets/data/student.json` —
/// a real O6U transcript, used as a temporary local data source until the
/// university provides an official API (see docs/Architecture.md). Every
/// screen reads this the same way it would read a real REST response:
/// through [currentStudentProvider], as a `Future`.
class StudentRepository {
  const StudentRepository();

  Future<Student> getCurrentStudent() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    return Student(
      id: json['id'] as String,
      name: json['name'] as String,
      faculty: json['faculty'] as String,
      major: json['major'] as String,
      academicAdvisor: json['academicAdvisor'] as String,
      nationality: json['nationality'] as String,
      level: json['level'] as int,
      university: json['university'] as String,
      cumulativeGpa: (json['cumulativeGpa'] as num).toDouble(),
      gpaDelta: (json['gpaDelta'] as num).toDouble(),
      creditHoursCompleted: json['creditHoursCompleted'] as int,
      creditHoursTotal: json['creditHoursTotal'] as int,
      expectedGraduation: json['expectedGraduation'] as String?,
      walletBalanceEgp: (json['walletBalanceEgp'] as num).toDouble(),
    );
  }
}

final studentRepositoryProvider = Provider<StudentRepository>((ref) => const StudentRepository());

final currentStudentProvider = FutureProvider<Student>((ref) {
  return ref.watch(studentRepositoryProvider).getCurrentStudent();
});
