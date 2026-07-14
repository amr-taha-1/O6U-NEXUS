import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/student.dart';

/// In-memory dummy repository. Swapping this for a real API later is a
/// one-file change — see docs/Architecture.md.
class StudentRepository {
  const StudentRepository();

  Student getCurrentStudent() {
    return const Student(
      id: '20211456',
      name: 'Ahmed Kamal',
      major: 'Computer Science',
      level: 4,
      university: 'October 6 University',
      cumulativeGpa: 3.12,
      gpaDelta: 0.18,
      creditHoursCompleted: 96,
      creditHoursTotal: 120,
      expectedGraduation: 'August 2027',
      walletBalanceEgp: 142,
    );
  }

  /// The last six semesters' GPA, for the Portal hero sparkline.
  List<double> getGpaTrend() => const [2.62, 2.71, 2.68, 2.88, 2.94, 3.12];
}

final studentRepositoryProvider = Provider<StudentRepository>((ref) => const StudentRepository());

final currentStudentProvider = Provider<Student>((ref) {
  return ref.watch(studentRepositoryProvider).getCurrentStudent();
});

final gpaTrendProvider = Provider<List<double>>((ref) {
  return ref.watch(studentRepositoryProvider).getGpaTrend();
});
