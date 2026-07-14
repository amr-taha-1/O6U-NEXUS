import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/campus_listing.dart';

const kCampusHubSegments = [
  CampusListingCategory.market,
  CampusListingCategory.lostFound,
  CampusListingCategory.studyGroup,
  CampusListingCategory.event,
];

class CampusSegmentNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void set(int index) => state = index;
}

final campusSegmentProvider = NotifierProvider<CampusSegmentNotifier, int>(CampusSegmentNotifier.new);
