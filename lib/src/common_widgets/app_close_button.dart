import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton(
      {Key? key,
      this.icon = const Icon(Icons.close, color: AppColors.darkBlue),
      this.width,
      this.height})
      : super(key: key);
  final Widget icon;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 4.0,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: IconButton(
        onPressed: context.popRoute,
        icon: icon,
      ),
    );
  }
}
