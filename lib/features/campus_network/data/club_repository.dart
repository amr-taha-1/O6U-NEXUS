import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/club.dart';

/// Seed university clubs — fictional membership/gallery/announcement
/// content for real, well-known O6U/national student organizations (IEEE,
/// GDG, ICPC, Rotaract, Student Union all genuinely exist at Egyptian
/// universities), same "real name, seed activity content" convention as
/// the rest of Campus Network.
class ClubRepository {
  const ClubRepository();

  List<Club> getClubs() {
    final today = DateTime.now();
    DateTime at(int dayOffset, int hour) {
      final day = today.add(Duration(days: dayOffset));
      return DateTime(day.year, day.month, day.day, hour, 0);
    }

    return [
      Club(
        id: 'club-ieee',
        name: 'IEEE O6U Student Branch',
        shortName: 'IEEE',
        description: 'Technical workshops, robotics competitions, and industry talks for engineering and CS students.',
        memberCount: 420,
        announcements: const ['Robotics workshop registration closes Friday.', 'New committee elections next month.'],
        events: [
          ClubEvent(id: 'ev-ieee-1', title: 'Intro to PCB Design Workshop', dateTime: at(4, 17), location: 'Engineering Building, Lab 2'),
        ],
        galleryAssetPaths: const [],
      ),
      Club(
        id: 'club-gdg',
        name: 'Google Developer Group O6U',
        shortName: 'GDG',
        description: 'A community for Android, Flutter, Cloud, and AI enthusiasts — study jams, bootcamps, and hackathons.',
        memberCount: 610,
        announcements: const ['Flutter Bootcamp Batch 5 starts next week.'],
        events: [
          ClubEvent(id: 'ev-gdg-1', title: 'Flutter Bootcamp — Session 1', dateTime: at(2, 16), location: 'Online — Google Meet'),
        ],
        galleryAssetPaths: const [],
      ),
      Club(
        id: 'club-icpc',
        name: 'ICPC O6U Chapter',
        shortName: 'ICPC',
        description: 'Competitive programming training for the ACM International Collegiate Programming Contest.',
        memberCount: 180,
        announcements: const ['Weekly contest every Thursday, 8 PM.'],
        events: [
          ClubEvent(id: 'ev-icpc-1', title: 'Weekly Contest #14', dateTime: at(1, 20), location: 'Online — Codeforces Gym'),
        ],
        galleryAssetPaths: const [],
      ),
      Club(
        id: 'club-rotaract',
        name: 'Rotaract Club O6U',
        shortName: 'Rotaract',
        description: 'Community service, leadership development, and volunteer initiatives across October 6 City.',
        memberCount: 350,
        announcements: const ['Blood donation drive this Sunday.'],
        events: [
          ClubEvent(id: 'ev-rotaract-1', title: 'Blood Donation Drive', dateTime: at(6, 10), location: 'Main Campus Plaza'),
        ],
        galleryAssetPaths: const [],
      ),
      Club(
        id: 'club-student-union',
        name: 'O6U Student Union',
        shortName: 'Student Union',
        description: 'The elected student body representing every faculty — events, welfare, and student advocacy.',
        memberCount: 900,
        announcements: const ['Student council office hours: Sun–Thu, 10 AM–2 PM.'],
        events: const [],
        galleryAssetPaths: const [],
      ),
    ];
  }
}

final clubRepositoryProvider = Provider<ClubRepository>((ref) => const ClubRepository());

final clubsProvider = Provider<List<Club>>((ref) => ref.watch(clubRepositoryProvider).getClubs());

final clubByIdProvider = Provider.family<Club?, String>((ref, id) {
  for (final club in ref.watch(clubsProvider)) {
    if (club.id == id) return club;
  }
  return null;
});
