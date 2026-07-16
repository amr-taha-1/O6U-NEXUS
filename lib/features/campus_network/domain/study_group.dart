import 'package:freezed_annotation/freezed_annotation.dart';

import 'campus_member.dart';

part 'study_group.freezed.dart';

enum MeetingType { online, offline }

extension MeetingTypeX on MeetingType {
  String get label => this == MeetingType.online ? 'Online' : 'Offline';
}

/// A student-created study session tied to a real course. [courseCode]
/// isn't re-validated against the bylaw here — a study group can exist for
/// any course a student names, including ones outside the Information
/// Systems catalog (mutual/elective courses another major owns).
@freezed
abstract class StudyGroup with _$StudyGroup {
  const factory StudyGroup({
    required String id,
    required String courseCode,
    required String courseName,
    required String location,
    required DateTime meetingTime,
    required int maxStudents,
    required MeetingType meetingType,
    required CampusMember organizer,
    required List<CampusMember> members,
  }) = _StudyGroup;

  const StudyGroup._();

  int get availableSpots => maxStudents - members.length;
  bool get isFull => availableSpots <= 0;
}
