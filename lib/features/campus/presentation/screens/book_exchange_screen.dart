import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/campus_repository.dart';
import '../../../../shared/domain/campus_listing.dart';
import '../widgets/listing_card.dart';

/// Trade or lend course textbooks with verified students — one of the
/// "More on campus" destinations off [CampusScreen].
class BookExchangeScreen extends ConsumerWidget {
  const BookExchangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final listings = ref.watch(campusListingsProvider(CampusListingCategory.bookExchange));

    return AppPushScaffold(
      title: 'Book Exchange',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: Text(
              'Trade or lend course textbooks with verified students — no listing fee, no shipping.',
              style: context.textStyles.callout,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: AppSearchBar(hintText: 'Search by course or title'),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 4, AppSpacing.screenMargin, 0),
            child: AppCard(
              dashed: true,
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: AppColors.tint(colors.accentDeep, 0.35), borderRadius: AppRadius.mdRadius),
                    alignment: Alignment.center,
                    child: Icon(CupertinoIcons.add, size: 16, color: colors.accent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('List a textbook', style: context.textStyles.bodyEmphasized.copyWith(fontSize: 14.5)),
                        const SizedBox(height: 2),
                        Text(
                          'Your level and course history are attached automatically.',
                          style: context.textStyles.footnote,
                        ),
                      ],
                    ),
                  ),
                  AppButton(label: 'Post', onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
