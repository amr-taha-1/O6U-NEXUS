import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_routes.dart';
import '../../../shared/application/notifications_controller.dart';
import '../../../shared/data/course_repository.dart';
import '../../../shared/data/student_repository.dart';
import '../../course_details/application/course_details.dart' show categoryLabel;
import '../../curriculum/data/curriculum_repository.dart';
import '../../degree_progress/data/degree_progress_repository.dart';
import '../../schedule/application/schedule_providers.dart';
import '../../schedule/domain/schedule_session.dart';
import '../../transcript/application/transcript_enrichment.dart';
import '../../transcript/data/transcript_repository.dart';
import '../domain/search_result.dart';

/// One flat index over every real (and, where the app is still fictional —
/// current courses, notifications — placeholder) data source, rebuilt
/// whenever any of them changes. This is the entire cross-app search
/// surface: Student Profile, Transcript, Current Courses, Schedule, Degree
/// Progress, GPA Analytics, Course Catalog, Bylaw/Prerequisites, and
/// Notifications. Every [SearchResult.route] here is a route the router
/// already serves — nothing is invented for search's sake.
final searchIndexProvider = FutureProvider<List<SearchResult>>((ref) async {
  final student = await ref.watch(currentStudentProvider.future);
  final semesters = await ref.watch(enrichedTranscriptProvider.future);
  final transferredCredits = await ref.watch(transferredCreditsProvider.future);
  final catalog = await ref.watch(curriculumProvider.future);
  final degreeProgress = await ref.watch(degreeProgressProvider.future);
  final schedule = await ref.watch(weeklyScheduleProvider.future);
  final registeredCourses = ref.watch(coursesProvider);
  final notifications = ref.watch(notificationsControllerProvider);

  final results = <SearchResult>[];

  // Student Profile
  results.add(SearchResult(
    id: 'profile-student',
    category: SearchCategory.profile,
    title: student.name,
    subtitle: '${student.major} · Level ${student.level} · ${student.faculty}',
    route: AppRoutes.profile,
  ));
  results.add(SearchResult(
    id: 'profile-advisor',
    category: SearchCategory.profile,
    title: 'Advisor: ${student.academicAdvisor}',
    subtitle: 'Academic advisor · shown on Home',
    route: AppRoutes.home,
  ));

  // GPA & Analytics
  results.add(SearchResult(
    id: 'gpa-cgpa',
    category: SearchCategory.gpaAnalytics,
    title: 'CGPA — Cumulative GPA',
    subtitle: '${student.cumulativeGpa.toStringAsFixed(2)} · official transcript',
    route: AppRoutes.academicsTranscript,
  ));
  results.add(const SearchResult(
    id: 'gpa-simulator',
    category: SearchCategory.gpaAnalytics,
    title: 'GPA Calculator',
    subtitle: 'Simulate a target grade for this semester',
    route: AppRoutes.aiGpaSimulator,
  ));
  results.add(const SearchResult(
    id: 'gpa-analytics',
    category: SearchCategory.gpaAnalytics,
    title: 'Academic Analytics',
    subtitle: 'Trends, grade mix, repeated courses',
    route: AppRoutes.academicsAnalytics,
  ));

  // Transcript — every semester and every course attempt, plus transferred credits.
  results.add(const SearchResult(
    id: 'transcript-root',
    category: SearchCategory.transcript,
    title: 'Transcript',
    subtitle: 'Full official academic record',
    route: AppRoutes.academicsTranscript,
  ));
  for (final semester in semesters) {
    results.add(SearchResult(
      id: 'semester-${semester.label}',
      category: SearchCategory.transcript,
      title: semester.label,
      subtitle: 'GPA ${semester.gpa.toStringAsFixed(2)} · ${semester.creditHours} hrs · ${semester.points.toStringAsFixed(1)} pts',
      route: AppRoutes.academicsTranscript,
    ));
    for (final course in semester.courses) {
      results.add(SearchResult(
        id: 'transcript-${semester.label}-${course.code}',
        category: SearchCategory.transcript,
        title: '${course.name} (${course.code})',
        subtitle: '${semester.label} · Grade ${course.grade}${course.creditHours != null ? ' · ${course.creditHours} hrs' : ''}',
        route: AppRoutes.courseDetailsPath(course.code),
      ));
    }
  }
  for (final course in transferredCredits) {
    results.add(SearchResult(
      id: 'transferred-${course.code}',
      category: SearchCategory.transcript,
      title: '${course.name} (${course.code})',
      subtitle: 'Transferred credit · ${course.grade}',
      route: AppRoutes.courseDetailsPath(course.code),
    ));
  }

  // Current (registered) courses — the fictional current-semester placeholder.
  for (final course in registeredCourses) {
    results.add(SearchResult(
      id: 'current-${course.code}',
      category: SearchCategory.currentCourses,
      title: '${course.name} (${course.code})',
      subtitle: 'Instructor ${course.instructor} · Grade ${course.grade} · ${course.attendancePercent}% attendance',
      route: AppRoutes.courseDetailsPath(course.code),
    ));
  }

  // Schedule
  results.add(const SearchResult(
    id: 'schedule-root',
    category: SearchCategory.schedule,
    title: 'Schedule',
    subtitle: "This week's classes",
    route: AppRoutes.academicsSchedule,
  ));
  for (final sessions in schedule.values) {
    for (final session in sessions) {
      results.add(SearchResult(
        id: 'schedule-${session.day.name}-${session.courseCode}-${session.type.name}',
        category: SearchCategory.schedule,
        title: '${session.courseName} · ${session.day.label}',
        subtitle: '${session.type.name == 'lecture' ? 'Lecture' : 'Lab'} · ${session.timeRangeLabel} · Room ${session.room}'
            '${session.instructor != null ? ' · ${session.instructor}' : ''}',
        route: AppRoutes.courseDetailsPath(session.courseCode),
      ));
    }
  }

  // Degree Progress
  results.add(SearchResult(
    id: 'degree-progress-root',
    category: SearchCategory.degreeProgress,
    title: 'Degree Progress',
    subtitle: '${degreeProgress.graduationHoursCompleted} of ${degreeProgress.graduationHoursRequired} hours',
    route: AppRoutes.academicsGraduation,
  ));
  for (final category in degreeProgress.categories) {
    results.add(SearchResult(
      id: 'degree-progress-${category.name}',
      category: SearchCategory.degreeProgress,
      title: category.name,
      subtitle: '${category.completedHours} of ${category.requiredHours} hours',
      route: AppRoutes.academicsGraduation,
    ));
  }

  // Course Catalog, Bylaw & Prerequisites
  results.add(const SearchResult(
    id: 'catalog-root',
    category: SearchCategory.catalog,
    title: 'Course Catalog',
    subtitle: 'What can I register next?',
    route: AppRoutes.academicsCatalog,
  ));
  results.add(const SearchResult(
    id: 'bylaw',
    category: SearchCategory.catalog,
    title: 'Bylaw',
    subtitle: 'Information Systems track requirements',
    route: AppRoutes.academicsCatalog,
  ));
  results.add(const SearchResult(
    id: 'prerequisites',
    category: SearchCategory.catalog,
    title: 'Prerequisites',
    subtitle: 'Course eligibility rules',
    route: AppRoutes.academicsCatalog,
  ));
  results.add(const SearchResult(
    id: 'graduation-project-rule',
    category: SearchCategory.catalog,
    title: 'Graduation Project Eligibility (Article 40)',
    subtitle: 'Minimum completed credit-hour threshold',
    route: AppRoutes.academicsGraduation,
  ));
  for (final course in catalog) {
    results.add(SearchResult(
      id: 'catalog-${course.code}',
      category: SearchCategory.catalog,
      title: '${course.name} (${course.code})',
      subtitle: '${categoryLabel(course.category)} · ${course.creditHours} hrs · Year ${course.yearLevel}',
      route: AppRoutes.courseDetailsPath(course.code),
    ));
  }

  // Notifications — no dedicated route (opened as a sheet from Home), so
  // results land on Home, the only screen that can open it.
  for (final notification in notifications) {
    results.add(SearchResult(
      id: 'notification-${notification.id}',
      category: SearchCategory.notifications,
      title: notification.title,
      subtitle: notification.body,
      route: AppRoutes.home,
    ));
  }

  return results;
});
