import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_listing.freezed.dart';

/// One shape covers Market, Book Exchange, Lost & Found, Study Groups,
/// Events, Internships, and Freelance gigs — the reference prototype's
/// `MARKET`/`GROUPS`/`EVENTS`/`LOST` fixtures are all the same
/// {title, meta, price?, status, color} record, just filtered differently.
/// One model, one card widget, reused across every Campus screen.
enum CampusListingCategory {
  market,
  bookExchange,
  lostFound,
  studyGroup,
  event,
  internship,
  freelance,
}

@freezed
abstract class CampusListing with _$CampusListing {
  const factory CampusListing({
    required String id,
    required CampusListingCategory category,
    required String title,
    required String subtitle,
    required String status,
    required Color accent,
    String? price,
    IconData? icon,
  }) = _CampusListing;
}
