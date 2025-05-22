import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';

const kCircleButtonSize = 32.0;

class CircleButton extends ConsumerWidget {
  const CircleButton(
      {super.key,
      required this.onTap,
      this.backgroundColor = AppColors.secondary,
      required this.child,
      this.border});
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: kCircleButtonSize,
        height: kCircleButtonSize,
        decoration: BoxDecoration(
            color: backgroundColor, shape: BoxShape.circle, border: border),
        child: child,
      ),
    );
  }
}
