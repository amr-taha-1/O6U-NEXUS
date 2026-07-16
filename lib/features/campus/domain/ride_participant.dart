import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_participant.freezed.dart';

/// A verified O6U account attached to a carpool ride — either a driver or
/// (once booking is wired to a real backend) a passenger. Every account is
/// tied to the student's real university profile; [studentId] is the full
/// ID and is never rendered directly anywhere in the UI — only
/// [maskedStudentId] is, per the "never expose the full Student ID"
/// requirement.
@freezed
abstract class RideParticipant with _$RideParticipant {
  const factory RideParticipant({
    required String id,
    required String fullName,
    required String faculty,
    required String department,
    required int level,
    required String studentId,
    required bool verified,
    required int completedRides,
    required double averageRating,
    required int cancellations,
    required int reportsReceived,
  }) = _RideParticipant;

  const RideParticipant._();

  String get maskedStudentId {
    final tail = studentId.length >= 4 ? studentId.substring(studentId.length - 4) : studentId;
    return 'Student ID ending with: ****$tail';
  }
}
