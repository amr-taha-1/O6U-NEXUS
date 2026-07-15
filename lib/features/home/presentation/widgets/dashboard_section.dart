import 'package:flutter/cupertino.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/degree_progress/domain/degree_progress.dart';
import '../../../../shared/domain/student.dart';
import '../../domain/dashboard_data.dart';

/// The real-data academic summary at the top of Home: who you are, where
/// you stand. Everything here comes from
/// `assets/data/{student,dashboard,degree_progress}.json` — nothing is
/// invented in this widget.
class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
    required this.student,
    required this.dashboard,
    required this.degreeProgress,
  });

  final Student student;
  final DashboardData dashboard;
  final DegreeProgress degreeProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: _GreetingCard(student: student, dashboard: dashboard, degreeProgress: degreeProgress),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: _StatRow(student: student, degreeProgress: degreeProgress),
        ),
      ],
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.student, required this.dashboard, required this.degreeProgress});
  final Student student;
  final DashboardData dashboard;
  final DegreeProgress degreeProgress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return AppCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.tint(colors.accentDeep, 0.28), AppColors.tint(colors.infoDeep, 0.12), colors.surface],
        stops: const [0, 0.6, 1],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome back ${dashboard.greetingName} 👋', style: text.title3),
                const SizedBox(height: 8),
                Text(student.faculty, style: text.footnote.copyWith(fontSize: 12.5), maxLines: 2),
                const SizedBox(height: 2),
                Text('${student.major} · Level ${student.level}', style: text.footnote.copyWith(fontSize: 12.5)),
                const SizedBox(height: 2),
                Text('Advisor: ${student.academicAdvisor}', style: text.footnote.copyWith(fontSize: 12.5)),
                const SizedBox(height: 8),
                Text(student.id, style: text.monoSmall.copyWith(color: colors.accent, fontSize: 12.5, letterSpacing: 0.6)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProgressRing(percent: (degreeProgress.overallProgress * 100).round(), size: 58, threshold: 0),
              const SizedBox(height: 4),
              Text('degree', style: text.caption1.copyWith(color: colors.textDim, fontWeight: FontWeight.w500, fontSize: 10.5)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.student, required this.degreeProgress});
  final Student student;
  final DegreeProgress degreeProgress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final goodStanding = student.cumulativeGpa >= 2.0;
    final statusColor = goodStanding ? colors.success : colors.danger;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.65,
      children: [
        _StatTile(label: 'CGPA', value: student.cumulativeGpa.toStringAsFixed(2), color: colors.accent, sub: '/ 4.00 scale'),
        _StatTile(
          label: 'Registered hours',
          value: '${student.creditHoursCompleted}',
          color: colors.info,
          sub: 'of ${student.creditHoursTotal} to graduate',
        ),
        _StatTile(label: 'Remaining', value: '${student.creditHoursRemaining} hrs', color: colors.warning, sub: 'toward graduation'),
        _StatTile(
          label: 'Academic status',
          value: goodStanding ? 'Good standing' : 'Below 2.0',
          color: statusColor,
          sub: 'CGPA vs. 2.00 minimum',
          valueFontSize: 16,
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color, required this.sub, this.valueFontSize = 22});
  final String label;
  final String value;
  final Color color;
  final String sub;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: text.footnote.copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: text.title2.copyWith(color: color, fontSize: valueFontSize, letterSpacing: -0.3)),
          const SizedBox(height: 2),
          Text(sub, style: text.caption1.copyWith(color: colors.textDim, fontWeight: FontWeight.w400, fontSize: 11)),
        ],
      ),
    );
  }
}
