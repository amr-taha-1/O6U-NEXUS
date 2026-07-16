import 'package:freezed_annotation/freezed_annotation.dart';

import 'campus_member.dart';

part 'campus_video.freezed.dart';

/// Short-video topics — the "TikTok/Reels for O6U" section. There is no
/// `video_player`/camera/upload dependency in this build (the sandbox this
/// was built in cannot resolve new native Gradle dependencies — see
/// docs/CHANGELOG.md), so [CampusVideo] deliberately carries no video file
/// or URL field. The feed, ranking, and engagement counters are all real,
/// working code; only actual playback is stubbed (a simulated "Play"
/// action, the same pattern as "Export official PDF").
enum VideoTopic { programmingTips, examTricks, projectDemo, courseExplanation, aiTips, flutterTutorial, databaseExplanation }

extension VideoTopicX on VideoTopic {
  String get label => switch (this) {
        VideoTopic.programmingTips => 'Programming Tips',
        VideoTopic.examTricks => 'Exam Tricks',
        VideoTopic.projectDemo => 'Project Demo',
        VideoTopic.courseExplanation => 'Course Explanation',
        VideoTopic.aiTips => 'AI Tips',
        VideoTopic.flutterTutorial => 'Flutter Tutorial',
        VideoTopic.databaseExplanation => 'Database Explanation',
      };
}

@freezed
abstract class CampusVideo with _$CampusVideo {
  const factory CampusVideo({
    required String id,
    required CampusMember creator,
    required String title,
    required VideoTopic topic,
    required int durationSeconds,
    required int likeCount,
    required int commentCount,
    required int shareCount,
    required int saveCount,
  }) = _CampusVideo;
}
