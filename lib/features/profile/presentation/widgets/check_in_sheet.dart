import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

Future<void> showCheckInSheet(BuildContext context) {
  return showAppBottomSheet(context, builder: (_) => const CheckInSheet());
}

/// Geo-fenced lecture check-in. "The code only works from here, during the
/// session" — see docs/reference/o6u-nexus-ios.tsx `ScanSheet`.
class CheckInSheet extends StatefulWidget {
  const CheckInSheet({super.key});

  @override
  State<CheckInSheet> createState() => _CheckInSheetState();
}

class _CheckInSheetState extends State<CheckInSheet> {
  bool _done = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2100), () {
      if (mounted) setState(() => _done = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: AppRadius.xlRadius,
              border: Border.all(color: _done ? colors.success : AppColors.tint(colors.success, 0.35), width: 1.5),
              color: AppColors.tint(colors.success, 0.05),
            ),
            alignment: Alignment.center,
            child: _done
                ? Icon(CupertinoIcons.check_mark, size: 54, color: colors.success).animate().scale(begin: const Offset(0.6, 0.6))
                : Icon(CupertinoIcons.viewfinder, size: 40, color: AppColors.tint(colors.success, 0.6)),
          ),
          const SizedBox(height: 20),
          Text(_done ? 'Checked in' : 'Hold steady', style: text.title3),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              _done
                  ? 'ISM413 · Database Management Systems 2. The lecturer sees it instantly.'
                  : "You're inside the lecture hall and the session is running. The code only works from here, during the session.",
              style: text.callout,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: _done ? 'Done' : 'Cancel',
            expand: true,
            variant: _done ? AppButtonVariant.primary : AppButtonVariant.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
