import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_member.dart';

/// Seed Campus Network members — fictional, feature-demonstration data in
/// the same spirit as [CarpoolRepository]'s driver fixtures: there is no
/// real O6U social-network backend or real classmate data to be faithful
/// to, so this is authored sample content. Only the signed-in student's own
/// card (`currentStudentAsCampusMemberProvider`) is built from real data.
class CampusMemberRepository {
  const CampusMemberRepository();

  List<CampusMember> getMembers() => const [
        CampusMember(
          id: 'cm-yasmin',
          fullName: 'Yasmin Adel',
          faculty: 'Faculty of Engineering',
          department: 'Mechatronics',
          level: 4,
          skills: ['Robotics', 'CAD Design', 'Public Speaking'],
          programmingLanguages: ['C++', 'Python'],
          certificates: ['IEEE Robotics Workshop'],
          projects: [
            PortfolioProject(
              title: 'Autonomous Line-Follower Robot',
              description: 'A PID-tuned line-following robot built for the IEEE robotics competition.',
              techStack: ['C++', 'Arduino'],
            ),
          ],
          volunteerHours: 52,
          followers: 340,
          following: 120,
          xp: 18500,
          campusCoins: 640,
          academicPoints: 410,
          communityPoints: 460,
          leadershipPoints: 380,
          innovationPoints: 300,
          githubUrl: 'github.com/yasmin-adel',
        ),
        CampusMember(
          id: 'cm-kareem',
          fullName: 'Kareem Nabil',
          faculty: 'Faculty of Computer Science and Information Systems',
          department: 'Computer Science',
          level: 3,
          skills: ['Flutter', 'Backend APIs', 'UI Design'],
          programmingLanguages: ['Dart', 'JavaScript', 'Python'],
          certificates: ['Google Developer Groups Flutter Bootcamp'],
          projects: [
            PortfolioProject(
              title: 'O6U Nexus',
              description: 'A full student-life app: transcript, GPA tools, schedule, and campus features.',
              techStack: ['Flutter', 'Riverpod'],
              link: 'github.com/kareem-nabil/o6u-nexus',
            ),
          ],
          volunteerHours: 18,
          followers: 210,
          following: 95,
          xp: 9200,
          campusCoins: 310,
          academicPoints: 300,
          communityPoints: 250,
          leadershipPoints: 180,
          innovationPoints: 420,
          githubUrl: 'github.com/kareem-nabil',
          linkedinUrl: 'linkedin.com/in/kareem-nabil',
        ),
        CampusMember(
          id: 'cm-nour',
          fullName: 'Nour Hassan',
          faculty: 'Faculty of Business Administration',
          department: 'Marketing',
          level: 2,
          skills: ['Content Strategy', 'Public Speaking'],
          programmingLanguages: [],
          certificates: ['Google Digital Marketing'],
          projects: [],
          volunteerHours: 30,
          followers: 150,
          following: 200,
          xp: 4100,
          campusCoins: 120,
          academicPoints: 260,
          communityPoints: 340,
          leadershipPoints: 220,
          innovationPoints: 90,
        ),
        CampusMember(
          id: 'cm-mostafa',
          fullName: 'Mostafa Reda',
          faculty: 'Faculty of Computer Science and Information Systems',
          department: 'Information Systems',
          level: 4,
          skills: ['Database Design', 'Data Analysis', 'Mentoring'],
          programmingLanguages: ['SQL', 'Python', 'Java'],
          certificates: ['Oracle Database Foundations'],
          projects: [
            PortfolioProject(
              title: 'University Course Recommendation Engine',
              description: 'A rule-based engine suggesting electives from a student\'s completed courses.',
              techStack: ['Python', 'Pandas'],
            ),
          ],
          volunteerHours: 65,
          followers: 480,
          following: 140,
          xp: 26400,
          campusCoins: 890,
          academicPoints: 470,
          communityPoints: 430,
          leadershipPoints: 460,
          innovationPoints: 380,
          githubUrl: 'github.com/mostafa-reda',
          linkedinUrl: 'linkedin.com/in/mostafa-reda',
        ),
        CampusMember(
          id: 'cm-salma',
          fullName: 'Salma Tarek',
          faculty: 'Faculty of Pharmacy',
          department: 'Clinical Pharmacy',
          level: 3,
          skills: ['Research', 'Lab Techniques'],
          programmingLanguages: [],
          certificates: [],
          projects: [],
          volunteerHours: 12,
          followers: 90,
          following: 130,
          xp: 3100,
          campusCoins: 75,
          academicPoints: 340,
          communityPoints: 140,
          leadershipPoints: 90,
          innovationPoints: 60,
        ),
      ];
}

final campusMemberRepositoryProvider = Provider<CampusMemberRepository>((ref) => const CampusMemberRepository());

final campusMembersProvider = Provider<List<CampusMember>>((ref) => ref.watch(campusMemberRepositoryProvider).getMembers());

final campusMemberByIdProvider = Provider.family<CampusMember?, String>((ref, id) {
  for (final member in ref.watch(campusMembersProvider)) {
    if (member.id == id) return member;
  }
  return null;
});
