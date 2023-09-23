import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_theme.dart';

class EditButton extends ConsumerWidget {
  const EditButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            textStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily)),
        child: Text(S.of(context).edit));
  }
}
