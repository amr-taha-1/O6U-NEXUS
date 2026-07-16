import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/student_repository.dart';
import '../domain/ride_participant.dart';

/// The signed-in student's own carpool identity — built live from the real
/// [Student] record (name, faculty, level are real; O6U Nexus has no major
/// field distinct from major, so "department" reuses [Student.major], the
/// same substitution the rest of the app makes). Ride stats start at an
/// honest zero: this build has no carpool booking backend, so the real
/// student genuinely has no completed rides yet — that's reported as fact,
/// not filled in with a plausible-looking number.
final currentStudentAsRideParticipantProvider = FutureProvider<RideParticipant>((ref) async {
  final student = await ref.watch(currentStudentProvider.future);
  return RideParticipant(
    id: 'me-${student.id}',
    fullName: student.name,
    faculty: student.faculty,
    department: student.major,
    level: student.level,
    studentId: student.id,
    verified: true,
    completedRides: 0,
    averageRating: 0,
    cancellations: 0,
    reportsReceived: 0,
  );
});
