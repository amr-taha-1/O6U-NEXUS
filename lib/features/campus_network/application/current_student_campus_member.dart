import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/student_repository.dart';
import '../domain/campus_member.dart';

/// The signed-in student's own Campus Network identity, built live from the
/// real [Student] record — name, faculty, level are real. Social/reputation
/// stats (XP, coins, followers, points…) start at an honest, low baseline
/// rather than a plausible-looking number: this build has no social
/// backend, so the real student genuinely hasn't posted, helped, or
/// volunteered *through this app* yet. See `campus_member_repository.dart`
/// for why every other member is seed data.
final currentStudentAsCampusMemberProvider = FutureProvider<CampusMember>((ref) async {
  final student = await ref.watch(currentStudentProvider.future);
  return CampusMember(
    id: 'me-${student.id}',
    fullName: student.name,
    faculty: student.faculty,
    department: student.major,
    level: student.level,
    skills: const [],
    programmingLanguages: const [],
    certificates: const [],
    projects: const [],
    volunteerHours: 0,
    followers: 0,
    following: 0,
    xp: 0,
    campusCoins: 0,
    academicPoints: (student.cumulativeGpa / 4 * 500).round(),
    communityPoints: 0,
    leadershipPoints: 0,
    innovationPoints: 0,
  );
});
