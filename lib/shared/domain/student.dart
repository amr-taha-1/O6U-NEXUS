import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

/// The signed-in student's profile. Backed by `assets/data/student.json`
/// (a real O6U transcript) via `StudentRepository` — a temporary local data
/// source until October 6 University provides an official API. See
/// docs/Architecture.md: swapping the repository implementation later is a
/// one-file change; this model and every screen that reads it stay the same.
@freezed
abstract class Student with _$Student {
  const factory Student({
    required String id,
    required String name,
    required String faculty,
    required String major,
    required String academicAdvisor,
    required String nationality,
    required int level,
    required String university,
    required double cumulativeGpa,
    required double gpaDelta,
    required int creditHoursCompleted,
    required int creditHoursTotal,

    /// Null when not yet known — a real projected graduation date isn't
    /// something to guess at from a partial transcript. See PROJECT_RULES.md
    /// §5: no fabricated data.
    String? expectedGraduation,
    required double walletBalanceEgp,
  }) = _Student;
}

extension StudentX on Student {
  int get creditHoursRemaining => creditHoursTotal - creditHoursCompleted;
  double get degreeProgress => creditHoursCompleted / creditHoursTotal;

  /// First name only, for greetings ("Welcome back Amr").
  String get firstName => name.split(' ').first;
}
