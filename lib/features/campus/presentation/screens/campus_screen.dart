import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/data/campus_repository.dart';
import '../../application/campus_providers.dart';
import '../widgets/listing_card.dart';

const _segmentLabels = ['Market', 'Lost & Found', 'Groups', 'Events'];

/// Gives student-to-student life the same quality bar as the academic
/// record. The Campus tab root.
class CampusScreen extends ConsumerWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final segment = ref.watch(campusSegmentProvider);
    final category = kCampusHubSegments[segment];
    final listings = ref.watch(campusListingsProvider(category));

    return LargeTitleScaffold(
      title: 'Campus',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, 14),
            child: AppSearchBar(hintText: 'Search books, gigs, rooms, people'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppSegmentedControl(
              labels: _segmentLabels,
              selectedIndex: segment,
              onChanged: (i) => ref.read(campusSegmentProvider.notifier).set(i),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Column(
              children: [
                for (final listing in listings)
                  Padding(padding: const EdgeInsets.only(bottom: 10), child: ListingCard(listing: listing)),
              ],
            ),
          ),
          if (segment == 0)
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
                          Text("Sell something you're done with", style: context.textStyles.bodyEmphasized.copyWith(fontSize: 14.5)),
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
          const SectionHeader('More on campus'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  NavRowCard(
                    isFirst: true,
                    icon: CupertinoIcons.book_circle,
                    iconColor: colors.info,
                    title: 'Book Exchange',
                    subtitle: 'Trade or lend course textbooks',
                    onTap: () => context.push(AppRoutes.campusBookExchange),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.briefcase,
                    iconColor: colors.success,
                    title: 'Internships',
                    subtitle: 'Verified openings for O6U students',
                    onTap: () => context.push(AppRoutes.campusInternships),
                  ),
                  NavRowCard(
                    icon: CupertinoIcons.wrench,
                    iconColor: colors.accent,
                    title: 'Freelance',
                    subtitle: 'Paid gigs posted by other students',
                    onTap: () => context.push(AppRoutes.campusFreelance),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
