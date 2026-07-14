import 'package:flutter/cupertino.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/campus_listing.dart';

/// The one card every Campus screen uses â€” Market, Book Exchange, Lost &
/// Found, Study Groups, Events, Internships, Freelance are all this same
/// {title, subtitle, price?, status, color} shape. See
/// docs/reference/o6u-nexus-ios.tsx SPECS.campus pin #2 ("trust is a design
/// primitive here, not a badge we add later").
class ListingCard extends StatelessWidget {
  const ListingCard({super.key, required this.listing, this.onTap});

  final CampusListing listing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: AppRadius.mdRadius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [listing.accent, AppColors.tint(listing.accent, 0.35)],
              ),
            ),
            alignment: Alignment.center,
            child: listing.icon != null ? Icon(listing.icon, size: 20, color: AppColors.tint(colors.onAccent, 0.85)) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(listing.title, style: text.bodyEmphasized.copyWith(fontSize: 15)),
                const SizedBox(height: 2),
                Text(listing.subtitle, style: text.footnote, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (listing.price != null) ...[
                      Text(listing.price!, style: text.bodyEmphasized.copyWith(color: colors.info, fontSize: 14)),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.tint(colors.success, 0.12), borderRadius: AppRadius.smRadius),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.checkmark_shield, size: 11, color: colors.success),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                listing.status,
                                style: text.caption1.copyWith(color: colors.success, fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(CupertinoIcons.chevron_forward, size: 17, color: colors.textDim),
        ],
      ),
    );
  }
}
