import 'package:flutter_test/flutter_test.dart';

import 'package:o6u_nexus/features/campus_network/application/campus_reputation.dart';
import 'package:o6u_nexus/features/campus_network/application/leaderboard_providers.dart';
import 'package:o6u_nexus/features/campus_network/domain/campus_member.dart';

const _member = CampusMember(
  id: 'm1',
  fullName: 'Test Member',
  faculty: 'Faculty of Testing',
  department: 'QA',
  level: 3,
  skills: ['Design'],
  programmingLanguages: ['Dart'],
  certificates: [],
  projects: [],
  volunteerHours: 45,
  followers: 10,
  following: 5,
  xp: 450,
  campusCoins: 100,
  academicPoints: 400,
  communityPoints: 450,
  leadershipPoints: 100,
  innovationPoints: 50,
);

void main() {
  group('computeCampusLevel', () {
    test('xp 0 is level 1 with 0 progress', () {
      final level = computeCampusLevel(0);
      expect(level.level, 1);
      expect(level.xpIntoLevel, 0);
    });

    test('higher xp yields a higher level, deterministically from the curve', () {
      final low = computeCampusLevel(100);
      final high = computeCampusLevel(20000);
      expect(high.level, greaterThan(low.level));
    });
  });

  group('computeReputation', () {
    test('normalizes raw points to 0-100 and computes a consistent overall', () {
      final reputation = computeReputation(_member);
      expect(reputation.academic, inInclusiveRange(0, 100));
      expect(reputation.community, inInclusiveRange(0, 100));
      expect(reputation.overall, (reputation.academic + reputation.community + reputation.leadership + reputation.innovation) ~/ 4);
    });
  });

  group('computeCampusBadges', () {
    test('a member with 40+ volunteer hours earns the Helper badge', () {
      final badges = computeCampusBadges(_member, computeReputation(_member));
      expect(badges, contains(CampusBadgeType.helper));
    });

    test('a member with no qualifying stats earns no badges', () {
      const quiet = CampusMember(
        id: 'm2',
        fullName: 'Quiet Member',
        faculty: 'Faculty',
        department: 'Dept',
        level: 1,
        skills: [],
        programmingLanguages: [],
        certificates: [],
        projects: [],
        volunteerHours: 0,
        followers: 0,
        following: 0,
        xp: 0,
        campusCoins: 0,
        academicPoints: 0,
        communityPoints: 0,
        leadershipPoints: 0,
        innovationPoints: 0,
      );
      expect(computeCampusBadges(quiet, computeReputation(quiet)), isEmpty);
    });
  });

  group('rankOf', () {
    test('ranks a member correctly within a group by XP, highest first', () {
      const a = CampusMember(
        id: 'a', fullName: 'A', faculty: 'F', department: 'D', level: 1,
        skills: [], programmingLanguages: [], certificates: [], projects: [],
        volunteerHours: 0, followers: 0, following: 0, xp: 100, campusCoins: 0,
        academicPoints: 0, communityPoints: 0, leadershipPoints: 0, innovationPoints: 0,
      );
      const b = CampusMember(
        id: 'b', fullName: 'B', faculty: 'F', department: 'D', level: 1,
        skills: [], programmingLanguages: [], certificates: [], projects: [],
        volunteerHours: 0, followers: 0, following: 0, xp: 500, campusCoins: 0,
        academicPoints: 0, communityPoints: 0, leadershipPoints: 0, innovationPoints: 0,
      );
      final group = [a, b];
      expect(rankOf(b, group), 1);
      expect(rankOf(a, group), 2);
    });
  });

  group('leaderboardFor', () {
    test('Top Volunteers ranks strictly by volunteer hours', () {
      const low = CampusMember(
        id: 'low', fullName: 'Low', faculty: 'F', department: 'D', level: 1,
        skills: [], programmingLanguages: [], certificates: [], projects: [],
        volunteerHours: 5, followers: 0, following: 0, xp: 0, campusCoins: 0,
        academicPoints: 0, communityPoints: 0, leadershipPoints: 0, innovationPoints: 0,
      );
      const high = CampusMember(
        id: 'high', fullName: 'High', faculty: 'F', department: 'D', level: 1,
        skills: [], programmingLanguages: [], certificates: [], projects: [],
        volunteerHours: 90, followers: 0, following: 0, xp: 0, campusCoins: 0,
        academicPoints: 0, communityPoints: 0, leadershipPoints: 0, innovationPoints: 0,
      );
      final entries = leaderboardFor(LeaderboardCategory.topVolunteers, [low, high]);
      expect(entries.first.member.id, 'high');
      expect(entries.first.rank, 1);
    });
  });
}
