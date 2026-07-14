import 'package:flutter/widgets.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/domain/student.dart';
import 'id_pattern.dart';

/// The digital-ID card — must render with no network (it opens the
/// turnstile). Reused on Profile and the full-screen Student ID view.
class ProfileIdCard extends StatelessWidget {
  const ProfileIdCard({super.key, required this.student, this.footnote = "Opens the turnstile at every gate · works offline"});

  final Student student;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;
    return AppCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.tint(colors.accentDeep, 0.5), AppColors.tint(colors.infoDeep, 0.35)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.university.toUpperCase(),
                      style: text.caption1.copyWith(color: AppColors.tint(colors.onAccent, 0.7), fontWeight: FontWeight.w700, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    Text(student.name, style: text.title2.copyWith(color: colors.onAccent, fontSize: 24)),
                    const SizedBox(height: 2),
                    Text(
                      '${student.major} · Level ${student.level}',
                      style: text.body.copyWith(color: AppColors.tint(colors.onAccent, 0.75), fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      student.id,
                      style: text.monoBody.copyWith(color: AppColors.tint(colors.onAccent, 0.9), fontSize: 13, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
              const IdPattern(),
            ],
          ),
          const SizedBox(height: 14),
          Text(footnote, style: text.footnote.copyWith(color: AppColors.tint(colors.onAccent, 0.7), fontSize: 12)),
        ],
      ),
    );
  }
}
