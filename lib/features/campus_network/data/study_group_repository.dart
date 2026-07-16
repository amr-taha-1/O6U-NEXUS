import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_member.dart';
import '../domain/study_group.dart';
import 'campus_member_repository.dart';

/// Seed Study Groups — fictional content, same convention as
/// `campus_member_repository.dart`. Course codes reused here (ISM413,
/// ISE326A) are the student's own real registered courses
/// (`assets/data/schedule.json`), so a study group for "my own class" reads
/// naturally, but the group listing itself is demo content.
class StudyGroupRepository {
  const StudyGroupRepository(this._members);
  final List<CampusMember> _members;

  CampusMember _m(String id) => _members.firstWhere((m) => m.id == id);

  List<StudyGroup> getGroups() {
    final today = DateTime.now();
    DateTime at(int dayOffset, int hour, int minute) {
      final day = today.add(Duration(days: dayOffset));
      return DateTime(day.year, day.month, day.day, hour, minute);
    }

    return [
      StudyGroup(
        id: 'sg-1',
        courseCode: 'ISM413',
        courseName: 'Database Management Systems 2',
        location: 'Library, Study Room 3',
        meetingTime: at(1, 17, 0),
        maxStudents: 6,
        meetingType: MeetingType.offline,
        organizer: _m('cm-mostafa'),
        members: [_m('cm-mostafa'), _m('cm-kareem')],
      ),
      StudyGroup(
        id: 'sg-2',
        courseCode: 'ISE326A',
        courseName: 'Geographic Information System',
        location: 'Discord — O6U CS Study Server',
        meetingTime: at(2, 20, 0),
        maxStudents: 8,
        meetingType: MeetingType.online,
        organizer: _m('cm-yasmin'),
        members: [_m('cm-yasmin')],
      ),
      StudyGroup(
        id: 'sg-3',
        courseCode: 'ISM424',
        courseName: 'Knowledge Management',
        location: 'Faculty Building, Room 6117',
        meetingTime: at(3, 13, 30),
        maxStudents: 5,
        meetingType: MeetingType.offline,
        organizer: _m('cm-kareem'),
        members: [_m('cm-kareem'), _m('cm-nour'), _m('cm-salma'), _m('cm-mostafa'), _m('cm-yasmin')],
      ),
    ];
  }
}

final studyGroupRepositoryProvider = Provider<StudyGroupRepository>(
  (ref) => StudyGroupRepository(ref.watch(campusMembersProvider)),
);

final studyGroupsProvider = Provider<List<StudyGroup>>((ref) => ref.watch(studyGroupRepositoryProvider).getGroups());

final studyGroupByIdProvider = Provider.family<StudyGroup?, String>((ref, id) {
  for (final group in ref.watch(studyGroupsProvider)) {
    if (group.id == id) return group;
  }
  return null;
});
