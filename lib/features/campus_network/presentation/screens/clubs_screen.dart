import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/club_repository.dart';

/// Every university club's landing page. See `club_repository.dart` for
/// what's real (club names/existence) vs. seed (member counts, events).
class ClubsScreen extends ConsumerWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubs = ref.watch(clubsProvider);
    final colors = context.colors;
    final text = context.textStyles;

    return AppPushScaffold(
      title: 'Clubs',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        child: Column(
          children: [
            for (final club in clubs)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => context.push(AppRoutes.campusNetworkClubPath(club.id)),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.16), borderRadius: AppRadius.mdRadius),
                        alignment: Alignment.center,
                        child: Text(club.shortName[0], style: text.title3.copyWith(color: colors.accent)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(club.name, style: text.bodyEmphasized.copyWith(fontSize: 14.5)),
                            Text('${club.memberCount} members', style: text.footnote.copyWith(color: colors.textMuted)),
                          ],
                        ),
                      ),
                      Icon(CupertinoIcons.chevron_forward, size: 15, color: colors.textDim),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
