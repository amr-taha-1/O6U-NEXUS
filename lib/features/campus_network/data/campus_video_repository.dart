import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_member.dart';
import '../domain/campus_video.dart';
import 'campus_member_repository.dart';

/// Seed Campus Short Videos — metadata only. See [CampusVideo]'s doc
/// comment for why there's no real video file/URL/playback in this build.
class CampusVideoRepository {
  const CampusVideoRepository(this._members);
  final List<CampusMember> _members;

  CampusMember _m(String id) => _members.firstWhere((m) => m.id == id);

  List<CampusVideo> getVideos() => [
        CampusVideo(
          id: 'vid-1',
          creator: _m('cm-kareem'),
          title: 'Riverpod in 60 seconds',
          topic: VideoTopic.flutterTutorial,
          durationSeconds: 58,
          likeCount: 1240,
          commentCount: 86,
          shareCount: 210,
          saveCount: 340,
        ),
        CampusVideo(
          id: 'vid-2',
          creator: _m('cm-mostafa'),
          title: '3NF vs BCNF — the difference that actually matters',
          topic: VideoTopic.databaseExplanation,
          durationSeconds: 74,
          likeCount: 980,
          commentCount: 64,
          shareCount: 150,
          saveCount: 410,
        ),
        CampusVideo(
          id: 'vid-3',
          creator: _m('cm-yasmin'),
          title: 'PID tuning trick nobody tells you',
          topic: VideoTopic.aiTips,
          durationSeconds: 45,
          likeCount: 620,
          commentCount: 39,
          shareCount: 70,
          saveCount: 180,
        ),
        CampusVideo(
          id: 'vid-4',
          creator: _m('cm-mostafa'),
          title: 'How I answer any midterm essay question in 5 minutes',
          topic: VideoTopic.examTricks,
          durationSeconds: 89,
          likeCount: 2100,
          commentCount: 156,
          shareCount: 480,
          saveCount: 690,
        ),
      ];
}

final campusVideoRepositoryProvider = Provider<CampusVideoRepository>(
  (ref) => CampusVideoRepository(ref.watch(campusMembersProvider)),
);

final campusVideosProvider = Provider<List<CampusVideo>>((ref) => ref.watch(campusVideoRepositoryProvider).getVideos());
