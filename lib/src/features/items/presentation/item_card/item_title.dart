import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({super.key, required this.title, this.maxLines});
  final String title;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.raisinBlack),
        maxLines: maxLines);
  }
}
