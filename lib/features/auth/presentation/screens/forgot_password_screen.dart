import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Not in the design reference â€” added to satisfy the full auth flow.
/// Follows the same field/button language as [LoginScreen] and resolves to
/// an honest confirmation state (no backend exists yet to actually send
/// anything).
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _idController = TextEditingController(text: '20211456');
  bool _sent = false;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return ColoredBox(
      color: colors.ink,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton(
                  label: 'Back',
                  icon: CupertinoIcons.chevron_back,
                  variant: AppButtonVariant.tertiary,
                  onPressed: () => context.pop(),
                ),
              ),
              Expanded(
                child: _sent
                    ? StatusPlaceholder.success(
                        title: 'Check your university email',
                        message:
                            "We've sent a reset link to the address on file for student ${_idController.text}. It expires in 15 minutes.",
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reset your password', style: text.largeTitle.copyWith(fontSize: 30)),
                          const SizedBox(height: 8),
                          Text(
                            "Enter your student ID and we'll email a reset link to your university address.",
                            style: text.body.copyWith(color: colors.textMuted),
                          ),
                          const SizedBox(height: 24),
                          AppTextField(icon: CupertinoIcons.person, hintText: 'Student ID', controller: _idController),
                          const SizedBox(height: 18),
                          AppButton(
                            label: 'Send reset link',
                            expand: true,
                            onPressed: () => setState(() => _sent = true),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
