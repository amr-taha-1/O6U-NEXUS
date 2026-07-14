import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

/// The signed-in student's profile. Dummy data only — see
/// `shared/data/student_repository.dart`.
@freezed
abstract class Student with _$Student {
  const factory Student({
    required String id,
    required String name,
    required String major,
    required int level,
    required String university,
    required double cumulativeGpa,
    required double gpaDelta,
    required int creditHoursCompleted,
    required int creditHoursTotal,
    required String expectedGraduation,
    required double walletBalanceEgp,
  }) = _Student;
}

extension StudentX on Student {
  int get creditHoursRemaining => creditHoursTotal - creditHoursCompleted;
  double get degreeProgress => creditHoursCompleted / creditHoursTotal;
}
