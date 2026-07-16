import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/campus_member_repository.dart';
import '../data/club_repository.dart';
import '../domain/campus_member.dart';
import 'campus_reputation.dart';

enum LeaderboardCategory { topGpa, topDevelopers, topDesigners, topVolunteers, topCommunity, topMentors, topAiStudents, topContributors, topClubs }

extension LeaderboardCategoryX on LeaderboardCategory {
  String get label => switch (this) {
        LeaderboardCategory.topGpa => 'Top GPA',
        LeaderboardCategory.topDevelopers => 'Top Developers',
        LeaderboardCategory.topDesigners => 'Top Designers',
        LeaderboardCategory.topVolunteers => 'Top Volunteers',
        LeaderboardCategory.topCommunity => 'Top Community Members',
        LeaderboardCategory.topMentors => 'Top Mentors',
        LeaderboardCategory.topAiStudents => 'Top AI Students',
        LeaderboardCategory.topContributors => 'Top Contributors',
        LeaderboardCategory.topClubs => 'Top Clubs',
      };
}

class LeaderboardEntry {
  const LeaderboardEntry({required this.rank, required this.member, required this.scoreLabel});
  final int rank;
  final CampusMember member;
  final String scoreLabel;
}

/// Every leaderboard is a *sort*, not a stored ranking — same discipline as
/// `curriculum_engine.dart`'s eligibility list. "Top Developers"/"Top
/// Designers"/"Top AI Students" rank by skill-tag membership + XP (the only
/// real proxy this build has for domain specialization, since there's no
/// per-skill endorsement system); "Top GPA" is the one leaderboard that
/// *would* need real classmates' GPAs to be genuine, and since no other
/// student's real GPA exists in this app, it ranks by [CampusMember]
/// academic reputation instead — a clearly-labelled proxy, not a claim
/// about real grades.
List<LeaderboardEntry> leaderboardFor(LeaderboardCategory category, List<CampusMember> members) {
  List<CampusMember> filtered = members;
  int Function(CampusMember) metric = (m) => m.xp;
  String Function(CampusMember) label = (m) => '${m.xp} XP';

  switch (category) {
    case LeaderboardCategory.topGpa:
      metric = (m) => computeReputation(m).academic;
      label = (m) => '${computeReputation(m).academic}/100 academic';
    case LeaderboardCategory.topDevelopers:
      filtered = [for (final m in members) if (m.programmingLanguages.isNotEmpty) m];
      metric = (m) => m.xp;
      label = (m) => '${m.programmingLanguages.length} languages · ${m.xp} XP';
    case LeaderboardCategory.topDesigners:
      filtered = [for (final m in members) if (m.skills.any((s) => s.toLowerCase().contains('design'))) m];
      label = (m) => '${m.xp} XP';
    case LeaderboardCategory.topVolunteers:
      metric = (m) => m.volunteerHours;
      label = (m) => '${m.volunteerHours} hrs volunteered';
    case LeaderboardCategory.topCommunity:
      metric = (m) => computeReputation(m).community;
      label = (m) => '${computeReputation(m).community}/100 community';
    case LeaderboardCategory.topMentors:
      metric = (m) => computeCampusLevel(m.xp).level;
      label = (m) => 'Level ${computeCampusLevel(m.xp).level}';
    case LeaderboardCategory.topAiStudents:
      filtered = [for (final m in members) if (m.skills.any((s) => s.toLowerCase().contains('ai') || s.toLowerCase().contains('data'))) m];
      label = (m) => '${m.xp} XP';
    case LeaderboardCategory.topContributors:
      metric = (m) => computeReputation(m).overall;
      label = (m) => '${computeReputation(m).overall}/100 overall';
    case LeaderboardCategory.topClubs:
      return const [];
  }

  final sorted = [...filtered]..sort((a, b) {
      final byMetric = metric(b).compareTo(metric(a));
      return byMetric != 0 ? byMetric : a.id.compareTo(b.id);
    });

  return [for (var i = 0; i < sorted.length; i++) LeaderboardEntry(rank: i + 1, member: sorted[i], scoreLabel: label(sorted[i]))];
}

final leaderboardProvider = Provider.family<List<LeaderboardEntry>, LeaderboardCategory>((ref, category) {
  return leaderboardFor(category, ref.watch(campusMembersProvider));
});

class ClubLeaderboardEntry {
  const ClubLeaderboardEntry({required this.rank, required this.name, required this.memberCount});
  final int rank;
  final String name;
  final int memberCount;
}

final clubLeaderboardProvider = Provider<List<ClubLeaderboardEntry>>((ref) {
  final clubs = [...ref.watch(clubsProvider)]..sort((a, b) => b.memberCount.compareTo(a.memberCount));
  return [for (var i = 0; i < clubs.length; i++) ClubLeaderboardEntry(rank: i + 1, name: clubs[i].name, memberCount: clubs[i].memberCount)];
});
