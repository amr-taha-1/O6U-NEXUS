import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/campus_repository.dart';
import '../../../../shared/domain/campus_listing.dart';
import '../widgets/listing_card.dart';

/// Paid gigs posted by other students — one of the "More on campus"
/// destinations off [CampusScreen].
class FreelanceScreen extends ConsumerWidget {
  const FreelanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listings = ref.watch(campusListingsProvider(CampusListingCategory.freelance));

    return AppPushScaffold(
      title: 'Freelance',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: Text(
              'Paid gigs posted by other students — design, writing, code, anything a peer needs done.',
              style: context.textStyles.callout,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: AppSearchBar(hintText: 'Search gigs'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final listing in listings)
                  Padding(padding: const EdgeInsets.only(bottom: 10), child: ListingCard(listing: listing)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
