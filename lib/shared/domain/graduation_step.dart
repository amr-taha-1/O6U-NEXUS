import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'graduation_step.freezed.dart';

enum GraduationStepStatus { done, now, advised, forecast }

@freezed
abstract class GraduationStep with _$GraduationStep {
  const factory GraduationStep({
    required String title,
    required String subtitle,
    required String statusLabel,
    required GraduationStepStatus status,
    required Color accent,
  }) = _GraduationStep;
}
