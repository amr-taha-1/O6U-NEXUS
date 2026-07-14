import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../domain/campus_listing.dart';

/// In-memory dummy fixtures for every Campus screen. See the note on
/// [NotificationRepository] re: seed data using [AppColors.dark] directly.
class CampusRepository {
  const CampusRepository();

  static final AppColors _c = AppColors.dark;

  List<CampusListing> getListings(CampusListingCategory category) {
    return _all.where((l) => l.category == category).toList();
  }

  static final List<CampusListing> _all = [
    // Market
    CampusListing(
      id: 'm1',
      category: CampusListingCategory.market,
      title: 'Calculus textbook',
      subtitle: 'Stewart · 8th ed.',
      price: '120 EGP',
      status: 'Level 2 · Verified',
      accent: _c.infoDeep,
    ),
    CampusListing(
      id: 'm2',
      category: CampusListingCategory.market,
      title: 'Scientific calculator',
      subtitle: 'Casio fx-991EX',
      price: '300 EGP',
      status: 'Level 3 · Verified',
      accent: _c.accentDeep,
    ),
    CampusListing(
      id: 'm3',
      category: CampusListingCategory.market,
      title: 'Lab coat · size M',
      subtitle: 'Worn one semester',
      price: '90 EGP',
      status: 'Level 1 · Verified',
      accent: const Color(0xFF0F766E),
    ),
    // Lost & found
    CampusListing(
      id: 'l1',
      category: CampusListingCategory.lostFound,
      title: 'AirPods Pro · white case',
      subtitle: 'Found in Hall B2 · photo-matched to your report',
      status: 'Claim by 20 Oct',
      accent: _c.infoDeep,
    ),
    CampusListing(
      id: 'l2',
      category: CampusListingCategory.lostFound,
      title: 'Student ID · Mariam H.',
      subtitle: 'Found at Gate 3 · owner notified',
      status: 'Returned',
      accent: const Color(0xFF0F766E),
    ),
    CampusListing(
      id: 'l3',
      category: CampusListingCategory.lostFound,
      title: 'Grey hoodie · size L',
      subtitle: 'Library, 2nd floor · 3 days ago',
      status: 'Unclaimed',
      accent: _c.accentDeep,
    ),
    // Study groups
    CampusListing(
      id: 'g1',
      category: CampusListingCategory.studyGroup,
      title: 'CS402 · Data Structures',
      subtitle: 'Wed 14:00 · Library Room 4',
      status: '2 spots left',
      accent: _c.accentDeep,
    ),
    CampusListing(
      id: 'g2',
      category: CampusListingCategory.studyGroup,
      title: 'MA201 · Midterm revision',
      subtitle: 'Thu 16:00 · Hall A4',
      status: '5 spots left',
      accent: _c.infoDeep,
    ),
    // Events
    CampusListing(
      id: 'e1',
      category: CampusListingCategory.event,
      title: 'ACM O6U · Hackathon',
      subtitle: 'Sat 09:00 · Innovation Hub',
      status: 'Registration open',
      accent: const Color(0xFFB45309),
    ),
    CampusListing(
      id: 'e2',
      category: CampusListingCategory.event,
      title: 'Career fair · Engineering',
      subtitle: 'Mon 10:00 · Main Plaza',
      status: '42 companies',
      accent: const Color(0xFF0F766E),
    ),
  ];
}

final campusRepositoryProvider = Provider<CampusRepository>((ref) => const CampusRepository());

final campusListingsProvider = Provider.family<List<CampusListing>, CampusListingCategory>((ref, category) {
  return ref.watch(campusRepositoryProvider).getListings(category);
});
