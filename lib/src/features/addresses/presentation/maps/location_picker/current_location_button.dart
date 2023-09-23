import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../theme/app_theme.dart';

class CurrentLocationButton extends ConsumerWidget {
  const CurrentLocationButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Assets.icons.filledLocationIcon.svg(),
      label: Text(S.of(context).locateMe),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily),
      ),
    );
  }
}
