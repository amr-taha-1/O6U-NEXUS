import 'package:flutter/foundation.dart';

enum StudyBlockType { lecture, aiPlaced, exam }

/// One cell in the Study Planner's 7×3 week grid. Not in the design
/// reference's data model directly — ports the reference's inline
/// `[col, row, label, type]` tuples (SPECS.planner) into a named shape.
@immutable
class StudyBlock {
  const StudyBlock({required this.day, required this.row, required this.label, required this.type});

  /// 0 (Mon) .. 6 (Sun).
  final int day;

  /// 0..2, the grid row.
  final int row;
  final String label;
  final StudyBlockType type;
}
