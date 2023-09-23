import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(subtitle, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
