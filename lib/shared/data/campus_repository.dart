import 'package:flutter/cupertino.dart';
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
    // Book exchange
    CampusListing(
      id: 'b1',
      category: CampusListingCategory.bookExchange,
      title: 'Data Structures & Algorithms',
      subtitle: 'Cormen · 3rd ed. · Lend for the semester',
      status: 'Level 2 · Verified',
      accent: _c.infoDeep,
      icon: CupertinoIcons.book,
    ),
    CampusListing(
      id: 'b2',
      category: CampusListingCategory.bookExchange,
      title: 'Organic Chemistry',
      subtitle: 'Klein · 3rd ed. · Trade for a Physics II text',
      status: 'Level 1 · Verified',
      accent: _c.accentDeep,
      icon: CupertinoIcons.book,
    ),
    CampusListing(
      id: 'b3',
      category: CampusListingCategory.bookExchange,
      title: 'Linear Algebra and Its Applications',
      subtitle: 'Lay · 5th ed. · Free to a good home',
      status: 'Level 3 · Verified',
      accent: const Color(0xFF0F766E),
      icon: CupertinoIcons.book,
    ),
    CampusListing(
      id: 'b4',
      category: CampusListingCategory.bookExchange,
      title: 'Technical Writing workbook',
      subtitle: 'EN102 · barely used, no markings',
      status: 'Level 1 · Verified',
      accent: _c.infoDeep,
      icon: CupertinoIcons.book,
    ),
    // Internships
    CampusListing(
      id: 'i1',
      category: CampusListingCategory.internship,
      title: 'Software Engineering Intern',
      subtitle: 'Vodafone Egypt · Cairo · Paid',
      status: 'Deadline in 5 days',
      accent: _c.infoDeep,
      icon: CupertinoIcons.briefcase,
    ),
    CampusListing(
      id: 'i2',
      category: CampusListingCategory.internship,
      title: 'Data Analyst Intern',
      subtitle: 'Etisalat by e& · Remote-friendly · Paid',
      status: 'Applications open',
      accent: _c.accentDeep,
      icon: CupertinoIcons.briefcase,
    ),
    CampusListing(
      id: 'i3',
      category: CampusListingCategory.internship,
      title: 'Marketing Intern',
      subtitle: 'Careem · Cairo · Unpaid, certificate provided',
      status: 'Closing soon',
      accent: const Color(0xFFB45309),
      icon: CupertinoIcons.briefcase,
    ),
    CampusListing(
      id: 'i4',
      category: CampusListingCategory.internship,
      title: 'Mechanical Design Intern',
      subtitle: 'Schneider Electric · 6th of October City',
      status: 'Applications open',
      accent: const Color(0xFF0F766E),
      icon: CupertinoIcons.briefcase,
    ),
    // Freelance
    CampusListing(
      id: 'f1',
      category: CampusListingCategory.freelance,
      title: "Logo design for student startup",
      subtitle: 'Posted by Marwan S. · Business major',
      price: '500 EGP',
      status: '3 students interested',
      accent: _c.accentDeep,
      icon: CupertinoIcons.wrench,
    ),
    CampusListing(
      id: 'f2',
      category: CampusListingCategory.freelance,
      title: 'English–Arabic translation · 10 pages',
      subtitle: 'Posted by Nourhan K. · due Friday',
      price: '250 EGP',
      status: 'Posted 2 days ago',
      accent: _c.infoDeep,
      icon: CupertinoIcons.wrench,
    ),
    CampusListing(
      id: 'f3',
      category: CampusListingCategory.freelance,
      title: 'Build a simple portfolio website',
      subtitle: 'Posted by Youssef A. · React preferred',
      price: '800 EGP',
      status: '1 student interested',
      accent: const Color(0xFF0F766E),
      icon: CupertinoIcons.wrench,
    ),
    CampusListing(
      id: 'f4',
      category: CampusListingCategory.freelance,
      title: 'Poster design for ACM hackathon',
      subtitle: 'Posted by ACM O6U · needed by Sunday',
      price: '300 EGP',
      status: 'Posted 5 hours ago',
      accent: const Color(0xFFB45309),
      icon: CupertinoIcons.wrench,
    ),
  ];
}

final campusRepositoryProvider = Provider<CampusRepository>((ref) => const CampusRepository());

final campusListingsProvider = Provider.family<List<CampusListing>, CampusListingCategory>((ref, category) {
  return ref.watch(campusRepositoryProvider).getListings(category);
});
