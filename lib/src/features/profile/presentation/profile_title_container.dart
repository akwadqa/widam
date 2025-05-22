import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class ProfileTitleContainer extends StatelessWidget {
  const ProfileTitleContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cultured,
      padding: const EdgeInsets.only(
          top: 30.0, bottom: 8.0, left: 18.0, right: 18.0),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
