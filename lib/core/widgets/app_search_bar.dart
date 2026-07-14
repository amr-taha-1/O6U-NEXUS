import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_card.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      tier: AppCardTier.raised,
      borderRadius: AppRadius.mdRadius,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 36,
        child: Row(
          children: [
            Icon(CupertinoIcons.search, size: 16, color: colors.textDim),
            const SizedBox(width: 9),
            Expanded(
              // `TextField` is a Material widget and asserts a `Material` ancestor at
              // build time. Nothing above this point in the tree (the Cupertino-styled
              // scaffolds) provides one, so it's supplied locally — `transparency` adds
              // no fill, elevation, or ink, keeping the iOS HIG look intact.
              child: Material(
                type: MaterialType.transparency,
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onTap: onTap,
                  readOnly: readOnly,
                  style: context.textStyles.body.copyWith(color: colors.textPrimary),
                  cursorColor: colors.accent,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: context.textStyles.body.copyWith(color: colors.textDim),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
