import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_card.dart';

/// Icon-led input row used across Login, Forgot Password, and any form
/// field — matches the reference's login field styling exactly.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.icon,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.trailing,
    this.onChanged,
    this.autofocus = false,
  });

  final IconData icon;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      tier: AppCardTier.raised,
      borderRadius: AppRadius.lgRadius,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Icon(icon, size: 17, color: colors.textDim),
            const SizedBox(width: 11),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                autofocus: autofocus,
                onChanged: onChanged,
                style: context.textStyles.body.copyWith(color: colors.textPrimary, fontSize: 16.5),
                cursorColor: colors.accent,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: context.textStyles.body.copyWith(color: colors.textDim, fontSize: 16.5),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
