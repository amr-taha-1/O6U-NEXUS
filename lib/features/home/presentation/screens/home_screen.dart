import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/degree_progress/data/degree_progress_repository.dart';
import '../../../../features/transcript/data/transcript_repository.dart';
import '../../../../shared/application/notifications_controller.dart';
import '../../../../shared/data/student_repository.dart';
import '../../../notifications/presentation/widgets/notifications_sheet.dart';
import '../../application/home_providers.dart';
import '../../data/dashboard_repository.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/day_timeline.dart';
import '../widgets/glance_grid.dart';
import '../widgets/nexus_thread_banner.dart';
import '../widgets/next_up_card.dart';

/// Answers "what does the next hour ask of me?" before the student thinks
/// to ask. The Home tab root.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final schedule = ref.watch(todayScheduleProvider);
    final unread = ref.watch(unreadCountProvider);
    final dateLabel = DateFormat('EEEE, d MMMM').format(DateTime.now());

    final studentAsync = ref.watch(currentStudentProvider);
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final degreeProgressAsync = ref.watch(degreeProgressProvider);
    final transcriptAsync = ref.watch(transcriptProvider);

    final student = studentAsync.valueOrNull;
    final dashboard = dashboardAsync.valueOrNull;
    final degreeProgress = degreeProgressAsync.valueOrNull;
    final semesters = transcriptAsync.valueOrNull;
    final dashboardReady = student != null && dashboard != null && degreeProgress != null && semesters != null;
    final dashboardFailed = studentAsync.hasError || dashboardAsync.hasError || degreeProgressAsync.hasError;

    return LargeTitleScaffold(
      title: 'Home',
      trailing: GestureDetector(
        onTap: () => showNotificationsSheet(context),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(CupertinoIcons.bell, size: 20, color: colors.textPrimary),
              if (unread > 0)
                Positioned(
                  top: 5,
                  right: 6,
                  child: GlowBadge(color: colors.due, ringColor: colors.ink),
                ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: Text(dateLabel, style: text.body.copyWith(color: colors.textMuted)),
          ),
          if (dashboardReady)
            DashboardSection(
              student: student,
              dashboard: dashboard,
              degreeProgress: degreeProgress,
              mostRecentSemester: semesters.isEmpty ? null : semesters.last,
            )
          else if (dashboardFailed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: StatusPlaceholder.error(message: 'Couldn\'t load your academic summary.'),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: SkeletonBox(height: 150, borderRadius: AppRadius.cardRadius),
            ),
          const SizedBox(height: 4),
          const NexusThreadBanner(),
          const NextUpCard(),
          const SectionHeader('Your day'),
          DayTimeline(items: schedule),
          const SectionHeader('At a glance'),
          const GlanceGrid(),
        ],
      ),
    );
  }
}
