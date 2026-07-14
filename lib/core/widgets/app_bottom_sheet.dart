import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Presents [child] as a bottom sheet with the reference prototype's drag
/// handle, corner radius, and width cap on wide layouts (tablet/web — see
/// PROJECT_RULES.md §6). Every modal flow (Notifications, course details,
/// check-in) goes through this instead of calling `showModalBottomSheet`
/// directly.
Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: true,
    backgroundColor: context.colors.solidRaised,
    barrierColor: const Color(0x8C000000),
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    constraints: const BoxConstraints(maxWidth: 480),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: context.colors.textPrimary.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  Builder(builder: builder),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
