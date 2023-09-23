import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class OptionLabel extends StatelessWidget {
  const OptionLabel({Key? key, required this.label}) : super(key: key);
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
