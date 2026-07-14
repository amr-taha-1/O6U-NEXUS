import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

enum NotificationCategory { academic, deadline, campus, nexus }

extension NotificationCategoryX on NotificationCategory {
  String get label => switch (this) {
        NotificationCategory.academic => 'Academic',
        NotificationCategory.deadline => 'Deadline',
        NotificationCategory.campus => 'Campus',
        NotificationCategory.nexus => 'Nexus',
      };
}

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String day,
    required IconData icon,
    required Color accent,
    required NotificationCategory category,
    required String title,
    required String body,
    required String time,
    required bool unread,
    String? actionLabel,
  }) = _AppNotification;
}
