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

  // Profile sub-screens
  static const profileStudentId = '/profile/student-id';
  static const profileSettings = '/profile/settings';
  static const profilePrivacy = '/profile/settings/privacy';
  static const profileSecurity = '/profile/settings/security';
  static const profileAchievements = '/profile/achievements';
  static const profileAbout = '/profile/about';
}
