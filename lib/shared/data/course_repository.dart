import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/course.dart';
import '../domain/semester.dart';

/// In-memory dummy repository backing every Academics screen (Portal,
/// Schedule, Grades, Attendance, Transcript, course-details sheet) and the
/// Home dashboard, so all of them agree on the same five courses.
class CourseRepository {
  const CourseRepository();

  List<Course> getCurrentCourses() => const [
        Course(
          code: 'CS402',
          name: 'Data Structures',
          instructor: 'Dr. Hesham',
          attendancePercent: 96,
          grade: 'A-',
          creditHours: 3,
          nextSession: 'Today · 10:30 · Hall B2',
          room: 'Hall B2',
        ),
        Course(
          code: 'MA201',
          name: 'Linear Algebra',
          instructor: 'Eng. Omar',
          attendancePercent: 68,
          grade: 'C+',
          creditHours: 3,
          nextSession: 'Tue · 09:00 · Hall A4',
          room: 'Hall A4',
        ),
        Course(
          code: 'CS310',
          name: 'Databases',
          instructor: 'Dr. Nourhan',
          attendancePercent: 100,
          grade: 'A',
          creditHours: 3,
          nextSession: 'Wed · 12:30 · Lab 2',
          room: 'Lab 2',
        ),
        Course(
          code: 'PH101',
          name: 'Physics II',
          instructor: 'Dr. Karim',
          attendancePercent: 74,
          grade: 'B',
          creditHours: 2,
          nextSession: 'Thu · 11:00 · Hall C1',
          room: 'Hall C1',
        ),
        Course(
          code: 'EN102',
          name: 'Technical Writing',
          instructor: 'Dr. Nadia',
          attendancePercent: 88,
          grade: 'B+',
          creditHours: 2,
          nextSession: 'Sun · 09:00 · Hall D3',
          room: 'Hall D3',
        ),
      ];

  List<Semester> getSemesters() => const [
        Semester(label: 'Level 1 · Fall', gpa: 2.62, creditHours: 15),
        Semester(label: 'Level 1 · Spring', gpa: 2.80, creditHours: 15),
        Semester(label: 'Level 2 · Fall', gpa: 2.68, creditHours: 16),
        Semester(label: 'Level 2 · Spring', gpa: 2.88, creditHours: 16),
        Semester(label: 'Level 3 · Fall', gpa: 2.94, creditHours: 17),
        Semester(label: 'Level 3 · Spring', gpa: 3.12, creditHours: 17),
      ];
}

final courseRepositoryProvider = Provider<CourseRepository>((ref) => const CourseRepository());

final coursesProvider = Provider<List<Course>>((ref) => ref.watch(courseRepositoryProvider).getCurrentCourses());

final semestersProvider = Provider<List<Semester>>((ref) => ref.watch(courseRepositoryProvider).getSemesters());

final courseByCodeProvider = Provider.family<Course?, String>((ref, code) {
  final courses = ref.watch(coursesProvider);
  for (final c in courses) {
    if (c.code == code) return c;
  }
  return null;
});
