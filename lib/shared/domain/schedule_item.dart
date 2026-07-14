import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_item.freezed.dart';

enum ScheduleItemKind { lecture, lab, freeBlock, exam }

@freezed
abstract class ScheduleItem with _$ScheduleItem {
  const factory ScheduleItem({
    required String time,
    required String title,
    required String meta,
    required Color accent,
    required IconData icon,
    required ScheduleItemKind kind,
  }) = _ScheduleItem;

  const ScheduleItem._();

  bool get isAiPlaced => kind == ScheduleItemKind.freeBlock;
}
