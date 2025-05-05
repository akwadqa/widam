import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class OptionLabel extends StatelessWidget {
  const OptionLabel({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: AppColors.raisinBlack));
  }
}
