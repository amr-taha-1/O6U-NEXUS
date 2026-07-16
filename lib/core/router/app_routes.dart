/// Every route path in the app, in one place, so a screen never hardcodes a
/// path string inline. Sub-screen paths are grouped as constants on the
/// owning feature's section for readability; go_router only needs the flat
/// string values.
abstract final class AppRoutes {
  // Auth
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const forgotPassword = '/login/forgot-password';
  static const faceId = '/face-id';

  // Tab roots
  static const home = '/home';
  static const academics = '/academics';
  static const ai = '/ai';
  static const campus = '/campus';
  static const profile = '/profile';

  // Global search (full-screen, outside the tab shell)
  static const search = '/search';

  // Academics sub-screens
  static const academicsSchedule = '/academics/schedule';
  static const academicsExams = '/academics/exams';
  static const academicsAttendance = '/academics/attendance';
  static const academicsGrades = '/academics/grades';
  static const academicsTranscript = '/academics/transcript';
  static const academicsAssignments = '/academics/assignments';
  static const academicsGraduation = '/academics/graduation';
  static const academicsAnalytics = '/academics/analytics';
  static const academicsCatalog = '/academics/catalog';
  static const academicsCourseDetails = '/academics/course';
  static String courseDetailsPath(String code) => '$academicsCourseDetails/$code';

  // AI sub-screens
  static const aiStudyPlanner = '/ai/study-planner';
  static const aiGpaSimulator = '/ai/gpa-simulator';
  static const aiGraduationPlanner = '/ai/graduation-planner';
  static const aiResumeBuilder = '/ai/resume-builder';
  static const aiLectureSummary = '/ai/lecture-summary';

  // Campus sub-screens
  static const campusBookExchange = '/campus/book-exchange';
  static const campusInternships = '/campus/internships';
  static const campusFreelance = '/campus/freelance';
  static const campusCarpool = '/campus/carpool';
  static String carpoolRidePath(String id) => '$campusCarpool/ride/$id';

  // Campus Network
  static const campusNetwork = '/campus/network';
  static const campusNetworkFeed = '/campus/network/feed';
  static String campusNetworkPostPath(String id) => '$campusNetworkFeed/$id';
  static const campusNetworkCreatePost = '/campus/network/feed/create';
  static const campusNetworkProfile = '/campus/network/profile';
  static String campusNetworkMemberPath(String id) => '/campus/network/member/$id';
  static const campusNetworkStudyGroups = '/campus/network/study-groups';
  static String campusNetworkStudyGroupPath(String id) => '$campusNetworkStudyGroups/$id';
  static const campusNetworkClubs = '/campus/network/clubs';
  static String campusNetworkClubPath(String id) => '$campusNetworkClubs/$id';
  static const campusNetworkChallenges = '/campus/network/challenges';
  static const campusNetworkLeaderboards = '/campus/network/leaderboards';
  static const campusNetworkVideos = '/campus/network/videos';
  static const campusNetworkDna = '/campus/network/dna';
  static const campusNetworkMarketplace = '/campus/network/marketplace';

  // Profile sub-screens
  static const profileStudentId = '/profile/student-id';
  static const profileSettings = '/profile/settings';
  static const profilePrivacy = '/profile/settings/privacy';
  static const profileSecurity = '/profile/settings/security';
  static const profileAchievements = '/profile/achievements';
  static const profileAbout = '/profile/about';
}
