import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController(text: '20211456');
  final _pwController = TextEditingController(text: '••••••••••');

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppMark(size: 54),
                    const SizedBox(height: 22),
                    Text('Welcome back', style: text.largeTitle.copyWith(fontSize: 32)),
                    const SizedBox(height: 5),
                    Text('Sign in with your O6U student account.', style: text.body.copyWith(color: colors.textMuted)),
                    const SizedBox(height: 26),
                    AppTextField(icon: CupertinoIcons.person, hintText: 'Student ID', controller: _idController),
                    const SizedBox(height: 10),
                    AppTextField(
                      icon: CupertinoIcons.lock,
                      hintText: 'Password',
                      controller: _pwController,
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        label: 'Forgot password?',
                        variant: AppButtonVariant.tertiary,
                        onPressed: () => context.push(AppRoutes.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: 6),
                    AppButton(
                      label: 'Sign in',
                      expand: true,
                      onPressed: () => context.go(AppRoutes.faceId),
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      label: 'Use Face ID',
                      icon: CupertinoIcons.viewfinder,
                      variant: AppButtonVariant.secondary,
                      expand: true,
                      onPressed: () => context.go(AppRoutes.faceId),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(CupertinoIcons.lock_shield, size: 13, color: colors.textDim),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Nexus never stores your password. Sign-in returns a short-lived token, held in the Secure Enclave.',
                      style: text.footnote.copyWith(color: colors.textDim, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
