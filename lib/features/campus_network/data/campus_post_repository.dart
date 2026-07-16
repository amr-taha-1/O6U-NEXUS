import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/campus_member.dart';
import '../domain/campus_post.dart';
import 'campus_member_repository.dart';

/// Seed Campus Community posts/comments — fictional feature-demonstration
/// content, same convention as `campus_member_repository.dart`. Engagement
/// counters here are the *starting* seed values; live like/bookmark toggles
/// for the current session are layered on top in
/// `campus_feed_controller.dart`, not mutated here.
class CampusPostRepository {
  const CampusPostRepository(this._members);
  final List<CampusMember> _members;

  CampusMember _m(String id) => _members.firstWhere((m) => m.id == id);

  List<CampusPost> getPosts() {
    final now = DateTime.now();
    return [
      CampusPost(
        id: 'post-1',
        author: _m('cm-mostafa'),
        type: CampusPostType.note,
        body: 'Summary of Database Management Systems — normalization forms (1NF–BCNF) with worked examples. '
            'Helped me a lot before the midterm, hope it helps someone else too.',
        hashtags: const ['#Database', '#Exams'],
        mentions: const [],
        createdAt: now.subtract(const Duration(hours: 3)),
        likeCount: 142,
        commentCount: 18,
        bookmarkCount: 96,
        shareCount: 12,
        attachmentName: 'DBMS_Normalization_Summary.pdf',
      ),
      CampusPost(
        id: 'post-2',
        author: _m('cm-kareem'),
        type: CampusPostType.projectUpdate,
        body: 'Shipped the Course Details page in O6U Nexus today — every course is now clickable across the '
            'whole app. Clean Architecture + Riverpod all the way down. #Flutter #Projects',
        hashtags: const ['#Flutter', '#Projects'],
        mentions: const [],
        createdAt: now.subtract(const Duration(hours: 7)),
        likeCount: 89,
        commentCount: 11,
        bookmarkCount: 20,
        shareCount: 6,
      ),
      CampusPost(
        id: 'post-3',
        author: _m('cm-yasmin'),
        type: CampusPostType.question,
        body: 'Anyone have a solid source for tuning PID controllers for line-following robots? Struggling with '
            'oscillation on sharp turns. #AI #Projects',
        hashtags: const ['#AI', '#Projects'],
        mentions: const [],
        createdAt: now.subtract(const Duration(hours: 10)),
        likeCount: 34,
        commentCount: 22,
        bookmarkCount: 8,
        shareCount: 1,
      ),
      CampusPost(
        id: 'post-4',
        author: _m('cm-mostafa'),
        type: CampusPostType.poll,
        body: 'Which elective are you leaning toward next semester?',
        hashtags: const ['#IEEE', '#Exams'],
        mentions: const [],
        createdAt: now.subtract(const Duration(days: 1)),
        likeCount: 61,
        commentCount: 40,
        bookmarkCount: 4,
        shareCount: 3,
        pollOptions: const [
          PollOption(label: 'Machine Learning', voteCount: 58),
          PollOption(label: 'Mobile Development', voteCount: 71),
          PollOption(label: 'Cloud Computing', voteCount: 33),
        ],
      ),
      CampusPost(
        id: 'post-5',
        author: _m('cm-nour'),
        type: CampusPostType.achievement,
        body: 'Just wrapped up the Google Digital Marketing certificate! Three months of late nights, finally '
            'worth it. #Certificates',
        hashtags: const ['#Certificates'],
        mentions: const [],
        createdAt: now.subtract(const Duration(days: 2)),
        likeCount: 210,
        commentCount: 26,
        bookmarkCount: 5,
        shareCount: 9,
      ),
    ];
  }

  List<CampusComment> getComments(String postId) {
    if (postId != 'post-1') return const [];
    final now = DateTime.now();
    return [
      CampusComment(
        id: 'c-1',
        postId: postId,
        author: _m('cm-kareem'),
        body: 'This is exactly what I needed, thank you!',
        createdAt: now.subtract(const Duration(hours: 2, minutes: 30)),
        likeCount: 9,
      ),
      CampusComment(
        id: 'c-2',
        postId: postId,
        author: _m('cm-salma'),
        body: 'Could you add BCNF vs 3NF examples too?',
        createdAt: now.subtract(const Duration(hours: 2)),
        likeCount: 3,
      ),
      CampusComment(
        id: 'c-3',
        postId: postId,
        parentCommentId: 'c-2',
        author: _m('cm-mostafa'),
        body: 'Good idea — added in the next revision.',
        createdAt: now.subtract(const Duration(hours: 1, minutes: 45)),
        likeCount: 5,
      ),
    ];
  }
}

final campusPostRepositoryProvider = Provider<CampusPostRepository>(
  (ref) => CampusPostRepository(ref.watch(campusMembersProvider)),
);

final campusPostsProvider = Provider<List<CampusPost>>((ref) => ref.watch(campusPostRepositoryProvider).getPosts());

final campusCommentsProvider = Provider.family<List<CampusComment>, String>(
  (ref, postId) => ref.watch(campusPostRepositoryProvider).getComments(postId),
);
