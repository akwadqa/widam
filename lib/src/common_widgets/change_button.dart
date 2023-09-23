import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/theme/app_theme.dart';

import '../../generated/l10n.dart';
import '../theme/app_colors.dart';

class ChangeButton extends ConsumerWidget {
  const ChangeButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.red,
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: ref.watch(fontFamilyProvider)),
        ),
        child: Text(S.of(context).change));
  }
}
