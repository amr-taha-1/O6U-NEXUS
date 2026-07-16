import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_member.freezed.dart';

/// One item in a student's portfolio ("LinkedIn for Students") — a project,
/// not a course; course history already lives in the real transcript.
@freezed
abstract class PortfolioProject with _$PortfolioProject {
  const factory PortfolioProject({
    required String title,
    required String description,
    required List<String> techStack,
    String? link,
  }) = _PortfolioProject;
}

/// A verified O6U Campus Network account — "Student Profile 2.0". The
/// signed-in student's own card is built live from the real [Student]
/// record (`currentStudentAsCampusMemberProvider`); every other member here
/// is seed/demo content, the same convention as [RideParticipant] in the
/// Carpool feature — there is no real classmate data source for a
/// brand-new social feature. The four `*Points` fields are raw inputs a
/// real backend would eventually own; [computeReputation] turns them into
/// the 0–100 breakdown the UI shows, so nothing here is a hand-picked
/// "reputation score."
@freezed
abstract class CampusMember with _$CampusMember {
  const factory CampusMember({
    required String id,
    required String fullName,
    required String faculty,
    required String department,
    required int level,
    required List<String> skills,
    required List<String> programmingLanguages,
    required List<String> certificates,
    required List<PortfolioProject> projects,
    required int volunteerHours,
    required int followers,
    required int following,
    required int xp,
    required int campusCoins,
    required int academicPoints,
    required int communityPoints,
    required int leadershipPoints,
    required int innovationPoints,
    String? githubUrl,
    String? linkedinUrl,
    String? portfolioUrl,
  }) = _CampusMember;
}
