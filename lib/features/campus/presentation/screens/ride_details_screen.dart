import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/carpool_favorites.dart';
import '../../application/trust_score.dart';
import '../../data/carpool_repository.dart';
import '../../domain/ride.dart';
import '../widgets/trust_badges.dart';

/// The full picture behind one ride: who the driver is (verified O6U
/// profile, masked ID, trust score and badges), and every safety/comfort
/// preference they've set for this specific trip. See
/// `carpool_repository.dart` for why the ride/driver content itself is
/// seed data rather than real classmate records.
class RideDetailsScreen extends ConsumerWidget {
  const RideDetailsScreen({super.key, required this.rideId});
  final String rideId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ride = ref.watch(carpoolRideByIdProvider(rideId));

    return AppPushScaffold(
      title: 'Ride Details',
      body: ride == null
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: StatusPlaceholder.empty(
                icon: CupertinoIcons.car_detailed,
                title: 'Ride not found',
                message: 'This ride may have been filled or removed.',
              ),
            )
          : _RideDetailsBody(ride: ride),
    );
  }
}

class _RideDetailsBody extends ConsumerWidget {
  const _RideDetailsBody({required this.ride});
  final Ride ride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final text = context.textStyles;
    final driver = ride.driver;
    final score = computeTrustScore(driver);
    final isFavorite = ref.watch(carpoolFavoritesProvider).contains(driver.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
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
                              Flexible(child: Text(driver.fullName, style: text.title3, overflow: TextOverflow.ellipsis)),
                              const SizedBox(width: 6),
                              if (driver.verified) Icon(CupertinoIcons.checkmark_seal_fill, size: 17, color: colors.info),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text('${driver.faculty} · ${driver.department} · Level ${driver.level}', style: text.footnote),
                          const SizedBox(height: 2),
                          Text(driver.maskedStudentId, style: text.footnote.copyWith(color: colors.textDim)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ref.read(carpoolFavoritesProvider.notifier).toggle(driver.id),
                      child: Icon(
                        isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                        size: 24,
                        color: isFavorite ? colors.due : colors.textDim,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TrustScoreBadge(score: score),
                const SizedBox(height: 8),
                TrustBadgeRow(badges: score.badges),
              ],
            ),
          ),
        ),
        const SectionHeader('Trip'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _InfoRow(isFirst: true, label: 'From', value: ride.originLabel),
                _InfoRow(label: 'To', value: ride.destinationLabel),
                _InfoRow(label: 'Departure', value: '${ride.departureDayLabel}, ${ride.departureTimeLabel}'),
                _InfoRow(label: 'Seats', value: '${ride.availableSeats} of ${ride.maxPassengers} available'),
                _InfoRow(label: 'Rider preference', value: ride.genderPreference.label),
                if (ride.carModel != null) _InfoRow(label: 'Car', value: ride.carModel!),
              ],
            ),
          ),
        ),
        const SectionHeader('Safety & Comfort'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              TagChip(label: '${ride.arrivalToleranceMinutes} min arrival tolerance', color: colors.info, icon: CupertinoIcons.timer),
              TagChip(
                label: ride.allowsMusic ? 'Music allowed' : 'No music',
                color: ride.allowsMusic ? colors.success : colors.textMuted,
                icon: CupertinoIcons.music_note,
              ),
              TagChip(
                label: ride.allowsSmoking ? 'Smoking allowed' : 'No smoking',
                color: ride.allowsSmoking ? colors.warning : colors.textMuted,
                icon: CupertinoIcons.smoke,
              ),
              TagChip(
                label: ride.hasAc ? 'A/C available' : 'No A/C',
                color: ride.hasAc ? colors.success : colors.textMuted,
                icon: CupertinoIcons.snow,
              ),
            ],
          ),
        ),
        if (ride.pickupInstructions != null) ...[
          const SectionHeader('Pickup Instructions'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(child: Text(ride.pickupInstructions!, style: text.body.copyWith(fontSize: 14.5))),
          ),
        ],
        if (ride.notes != null) ...[
          const SectionHeader('Notes'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(child: Text(ride.notes!, style: text.body.copyWith(fontSize: 14.5))),
          ),
        ],
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 6, AppSpacing.screenMargin, 0),
          child: AppButton(
            label: ride.isFull ? 'Ride is full' : 'Request to join',
            expand: true,
            onPressed: ride.isFull
                ? null
                : () => AppSnackbar.show(
                      context,
                      message: 'Request sent to ${driver.fullName} · simulated, no backend in this build.',
                    ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.isFirst = false});
  final String label;
  final String value;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: text.body.copyWith(fontSize: 14.5)),
          Flexible(child: Text(value, style: text.bodyEmphasized.copyWith(fontSize: 14.5), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
