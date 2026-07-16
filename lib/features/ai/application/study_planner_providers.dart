import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../schedule/application/schedule_providers.dart';
import '../../schedule/domain/schedule_session.dart';
import '../domain/study_block.dart';

int _dayIndex(Weekday day) => switch (day) {
      Weekday.monday => 0,
      Weekday.tuesday => 1,
      Weekday.wednesday => 2,
      Weekday.thursday => 3,
      Weekday.sunday => 6,
    };

/// The week grid's lecture cells, built from the real weekly timetable
/// (`weeklyScheduleProvider`) — previously a fully static grid mixing real
/// day slots with fictional course codes (CS402/MA201/CS310/PH101) *and*
/// invented AI-placed study/exam blocks. There is no real study-scheduling
/// or exam-calendar data source in this app, so those invented blocks are
/// gone rather than kept fictional; only real lecture/lab slots remain.
final studyBlocksProvider = FutureProvider<List<StudyBlock>>((ref) async {
  final byDay = await ref.watch(weeklyScheduleProvider.future);
  final blocks = <StudyBlock>[];
  for (final entry in byDay.entries) {
    final dayIndex = _dayIndex(entry.key);
    for (var row = 0; row < entry.value.length && row < 3; row++) {
      final session = entry.value[row];
      blocks.add(StudyBlock(day: dayIndex, row: row, label: session.courseCode, type: StudyBlockType.lecture));
    }
  }
  return blocks;
});

/// One of the cards under the week grid explaining what's real here.
class PlannerInsight {
  const PlannerInsight({required this.title, required this.body, required this.color});
  final String title;
  final String body;
  final Color color;
}

final plannerInsightsProvider = Provider<List<PlannerInsight>>((ref) {
  final c = AppColors.dark;
  return [
    PlannerInsight(
      title: 'Reads your real schedule',
      body: 'Every lecture/lab slot above comes from your real registered timetable — nothing invented.',
      color: c.success,
    ),
    PlannerInsight(
      title: 'No automatic study-block placement yet',
      body: 'Nexus doesn\'t have a real scheduling engine to fill your free hours automatically — that\'s '
          'still on you for now, rather than a fabricated "0 conflicts" plan.',
      color: c.warning,
    ),
    PlannerInsight(
      title: 'No exam calendar connected',
      body: 'There\'s no official exam schedule uploaded yet, so no exam blocks are shown here.',
      color: c.info,
    ),
  ];
});
