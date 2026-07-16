import '../domain/campus_member.dart';

enum CampusBadgeType { risingStar, topContributor, mentor, innovator, leader, scholar, helper, streakKeeper }

extension CampusBadgeTypeX on CampusBadgeType {
  String get emoji => switch (this) {
        CampusBadgeType.risingStar => '🌟',
        CampusBadgeType.topContributor => '🏅',
        CampusBadgeType.mentor => '🧑‍🏫',
        CampusBadgeType.innovator => '💡',
        CampusBadgeType.leader => '🚀',
        CampusBadgeType.scholar => '🎓',
        CampusBadgeType.helper => '🤝',
        CampusBadgeType.streakKeeper => '🔥',
      };

  String get label => switch (this) {
        CampusBadgeType.risingStar => 'Rising Star',
        CampusBadgeType.topContributor => 'Top Contributor',
        CampusBadgeType.mentor => 'Mentor',
        CampusBadgeType.innovator => 'Innovator',
        CampusBadgeType.leader => 'Leader',
        CampusBadgeType.scholar => 'Scholar',
        CampusBadgeType.helper => 'Helper',
        CampusBadgeType.streakKeeper => 'Streak Keeper',
      };
}

/// A student's Campus Level, derived from [CampusMember.xp] — a simple,
/// transparent square-root curve (each level costs progressively more XP
/// than the last), not a hand-picked lookup table. Levels 1–99; there is no
/// official O6U leveling scheme to be faithful to since this whole system
/// is new, so the curve itself is a documented judgment call.
class CampusLevelInfo {
  const CampusLevelInfo({required this.level, required this.xpIntoLevel, required this.xpForNextLevel});
  final int level;
  final int xpIntoLevel;
  final int xpForNextLevel;
  double get progress => xpForNextLevel == 0 ? 1 : xpIntoLevel / xpForNextLevel;
}

/// Total XP required to *reach* [level] — level 1 needs 0 (everyone starts
/// there), level 2 needs 100, level 3 needs 400, and so on.
int _xpForLevel(int level) => 100 * (level - 1) * (level - 1);

CampusLevelInfo computeCampusLevel(int xp) {
  var level = 1;
  while (_xpForLevel(level + 1) <= xp && level < 99) {
    level++;
  }
  final base = _xpForLevel(level);
  final next = _xpForLevel(level + 1);
  return CampusLevelInfo(level: level, xpIntoLevel: xp - base, xpForNextLevel: next - base);
}

/// Academic/Community/Leadership/Innovation reputation, each normalized to
/// 0–100 from the member's raw point stats, plus an overall weighted score.
/// See [computeCampusLevel] for the same "compute, don't hand-pick"
/// discipline applied to XP.
class ReputationBreakdown {
  const ReputationBreakdown({
    required this.academic,
    required this.community,
    required this.leadership,
    required this.innovation,
  });

  final int academic;
  final int community;
  final int leadership;
  final int innovation;

  int get overall => ((academic + community + leadership + innovation) / 4).round();
}

int _normalize(int points, {int cap = 500}) => (points.clamp(0, cap) / cap * 100).round();

ReputationBreakdown computeReputation(CampusMember member) => ReputationBreakdown(
      academic: _normalize(member.academicPoints),
      community: _normalize(member.communityPoints),
      leadership: _normalize(member.leadershipPoints),
      innovation: _normalize(member.innovationPoints),
    );

List<CampusBadgeType> computeCampusBadges(CampusMember member, ReputationBreakdown reputation) => [
      if (reputation.academic >= 80) CampusBadgeType.scholar,
      if (reputation.community >= 80) CampusBadgeType.topContributor,
      if (reputation.leadership >= 80) CampusBadgeType.leader,
      if (reputation.innovation >= 80) CampusBadgeType.innovator,
      if (member.volunteerHours >= 40) CampusBadgeType.helper,
      if (computeCampusLevel(member.xp).level >= 10) CampusBadgeType.mentor,
      if (reputation.overall >= 60 && computeCampusLevel(member.xp).level <= 3) CampusBadgeType.risingStar,
    ];

/// Rank within an arbitrary group, 1-based — used for Global/Department/
/// Faculty/Community rank, all the same operation over a differently
/// filtered member list. Ties break by [CampusMember.id] for stability.
int rankOf(CampusMember member, List<CampusMember> group, {int Function(CampusMember)? metric}) {
  final scoreOf = metric ?? ((m) => m.xp);
  final sorted = [...group]..sort((a, b) {
      final byScore = scoreOf(b).compareTo(scoreOf(a));
      return byScore != 0 ? byScore : a.id.compareTo(b.id);
    });
  final index = sorted.indexWhere((m) => m.id == member.id);
  return index == -1 ? sorted.length + 1 : index + 1;
}
