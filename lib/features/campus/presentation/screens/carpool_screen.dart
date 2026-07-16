import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/carpool_favorites.dart';
import '../../application/carpool_filters.dart';
import '../../application/current_student_ride_participant.dart';
import '../../application/ride_matching.dart';
import '../../application/trust_score.dart';
import '../../data/carpool_repository.dart';
import '../../domain/ride.dart';
import '../../domain/ride_participant.dart';
import '../widgets/trust_badges.dart';

const _genderFilters = <GenderPreference?>[null, GenderPreference.noPreference, GenderPreference.maleOnly, GenderPreference.femaleOnly];
const _genderFilterLabels = ['Any', 'No Pref.', 'Male Only', 'Female Only'];

/// O6U-exclusive, university-verified carpool. Every account here is tied
/// to a real O6U profile (the student's own card at the top is built from
/// the real [Student] record); ride listings themselves are seed data —
/// see `carpool_repository.dart` for why. Rides are ranked by
/// [matchPercentFor], never listed in arbitrary/insertion order, and one
/// end of every trip is always October 6 University — the student only
/// ever picks the other end.
class CarpoolScreen extends ConsumerWidget {
  const CarpoolScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final direction = ref.watch(carpoolDirectionFilterProvider);
    final genderFilter = ref.watch(carpoolGenderFilterProvider);
    final rides = ref.watch(carpoolRidesProvider(direction));
    final favorites = ref.watch(carpoolFavoritesProvider);
    final meAsync = ref.watch(currentStudentAsRideParticipantProvider);

    final filtered = [
      for (final ride in rides)
        if (genderFilter == null || ride.genderPreference == genderFilter || ride.genderPreference == GenderPreference.noPreference) ride,
    ];
    final ranked = [
      for (final ride in filtered)
        (
          ride: ride,
          match: matchPercentFor(
            ride,
            isFavoriteDriver: favorites.contains(ride.driver.id),
            pastRidesWithDriver: ref.watch(pastRidesWithDriverProvider(ride.driver.id)),
          ),
        ),
    ]..sort((a, b) => b.match.compareTo(a.match));

    return AppPushScaffold(
      title: 'Carpool',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: meAsync.when(
              data: (me) => _MyProfileCard(me: me),
              loading: () => const SkeletonBox(height: 76, borderRadius: BorderRadius.all(Radius.circular(16))),
              error: (error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 16, AppSpacing.screenMargin, 0),
            child: AppSegmentedControl(
              labels: const ['To Campus', 'From Campus'],
              selectedIndex: direction == RideDirection.toCampus ? 0 : 1,
              onChanged: (i) => ref.read(carpoolDirectionFilterProvider.notifier).state =
                  i == 0 ? RideDirection.toCampus : RideDirection.fromCampus,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 10, AppSpacing.screenMargin, 0),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (var i = 0; i < _genderFilters.length; i++)
                  GestureDetector(
                    onTap: () => ref.read(carpoolGenderFilterProvider.notifier).state = _genderFilters[i],
                    child: TagChip(
                      label: _genderFilterLabels[i],
                      color: context.colors.accent,
                      selected: genderFilter == _genderFilters[i],
                      filled: genderFilter == _genderFilters[i],
                    ),
                  ),
              ],
            ),
          ),
          const SectionHeader('Ranked for you'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: ranked.isEmpty
                ? const StatusPlaceholder.empty(
                    icon: CupertinoIcons.car_detailed,
                    title: 'No rides match your filters',
                    message: 'Try a different gender preference or check the other direction.',
                  )
                : Column(
                    children: [
                      for (final entry in ranked)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _RideCard(
                            ride: entry.ride,
                            matchPercent: entry.match,
                            isFavorite: favorites.contains(entry.ride.driver.id),
                            onFavoriteToggle: () => ref.read(carpoolFavoritesProvider.notifier).toggle(entry.ride.driver.id),
                            onTap: () => context.push(AppRoutes.carpoolRidePath(entry.ride.id)),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _MyProfileCard extends StatelessWidget {
  const _MyProfileCard({required this.me});
  final RideParticipant me;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final score = computeTrustScore(me);

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(CupertinoIcons.person_alt, size: 19, color: colors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(me.fullName, style: text.bodyEmphasized.copyWith(fontSize: 14.5), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 6),
                    Icon(CupertinoIcons.checkmark_seal_fill, size: 14, color: colors.info),
                  ],
                ),
                const SizedBox(height: 1),
                Text('${me.faculty} · Level ${me.level}', style: text.footnote.copyWith(color: colors.textMuted)),
              ],
            ),
          ),
          TrustScoreBadge(score: score),
        ],
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  const _RideCard({
    required this.ride,
    required this.matchPercent,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  final Ride ride;
  final double matchPercent;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    final score = computeTrustScore(ride.driver);

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(ride.driver.fullName, style: text.bodyEmphasized.copyWith(fontSize: 15), overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 5),
                        if (ride.driver.verified) Icon(CupertinoIcons.checkmark_seal_fill, size: 14, color: colors.info),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text('${ride.driver.faculty} · ${ride.driver.department}', style: text.footnote.copyWith(color: colors.textMuted)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  size: 20,
                  color: isFavorite ? colors.due : colors.textDim,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(CupertinoIcons.arrow_right, size: 13, color: colors.textDim),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${ride.originLabel} → ${ride.destinationLabel}',
                  style: text.footnote.copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${ride.departureTimeLabel} · ${ride.availableSeats} of ${ride.maxPassengers} seats left',
            style: text.footnote.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TagChip(label: '${matchPercent.round()}% Match', color: colors.success, filled: true),
              TrustScoreBadge(score: score),
              TagChip(label: ride.genderPreference.label, color: colors.warning),
              if (ride.isFull) TagChip(label: 'Full', color: colors.danger),
            ],
          ),
        ],
      ),
    );
  }
}
