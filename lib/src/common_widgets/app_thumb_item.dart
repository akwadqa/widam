import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppThumbItem extends StatelessWidget {
  const AppThumbItem({
    super.key,
    required this.quantity,
    required this.image,
  });

  final String quantity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(quantity),
      backgroundColor: AppColors.red,
      textStyle: const TextStyle(
          fontSize: 11.0, fontWeight: FontWeight.w500, color: Colors.white),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.brightGray, width: 0.5),
          borderRadius: BorderRadius.circular(2),
          image: DecorationImage(image: CachedNetworkImageProvider(image)),
        ),
      ),
    );
  }
}
