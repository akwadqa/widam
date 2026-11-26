import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

/// Rounded light-blue square holding an icon, used by the home header and
/// the order tracking card.
class HomeIconTile extends StatelessWidget {
  const HomeIconTile({
    super.key,
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.radius,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.iceBlue,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, size: iconSize, color: AppColors.navyBlue),
    );
  }
}
