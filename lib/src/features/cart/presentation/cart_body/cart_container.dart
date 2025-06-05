import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class CartContainer extends StatelessWidget {
  const CartContainer(
      {super.key, required this.child, this.withoutPadding = false});
  final Widget child;
  final bool withoutPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.veryLightcyan,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        border: Border.all(color: AppColors.mediumGray),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2))
        ],
      ),
      padding: withoutPadding
          ? const EdgeInsets.only(top: 16)
          : const EdgeInsets.all(14),
      child: child,
    );
  }
}
