import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';

class TitledImage extends StatelessWidget {
  const TitledImage({super.key, required this.title, this.icon});
  final String title;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? Assets.icons.emptyFolder.svg(),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue))
      ],
    );
  }
}
