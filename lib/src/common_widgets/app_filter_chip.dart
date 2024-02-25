import 'package:flutter/material.dart';
import 'package:widam/src/theme/app_colors.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.isSelected,
    required this.onSelected,
    required this.lable,
  });

  final bool isSelected;
  final void Function(bool)? onSelected;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: isSelected,
      label: Text(
        lable,
      ),
      side: isSelected
          ? const BorderSide(color: AppColors.darkBlue, width: 1)
          : null,
      labelStyle: isSelected
          ? const TextStyle(
              color: AppColors.darkBlue, fontWeight: FontWeight.w600)
          : null,
      padding: const EdgeInsets.only(bottom: 6, top: 4, left: 4, right: 4),
      onSelected: onSelected,
    );
  }
}
