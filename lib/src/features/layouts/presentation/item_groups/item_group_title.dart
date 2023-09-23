import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class ItemGroupTitle extends StatelessWidget {
  const ItemGroupTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.raisinBlack),
        textAlign: TextAlign.center);
  }
}
