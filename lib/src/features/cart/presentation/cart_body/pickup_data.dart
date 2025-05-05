import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class PickupData extends StatelessWidget {
  const PickupData(
      {super.key,
      required this.title,
      required this.description,
      required this.openingHours});
  final String title;
  final String description;
  final String openingHours;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 8.0,
              width: 8.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.darkBlue, width: 2)),
            ),
            const SizedBox(width: 4),
            Text(title, style: _textStyle),
          ],
        ),
        const SizedBox(height: 2),
        IntrinsicHeight(
          child: Row(
            children: [
              const VerticalDivider(color: AppColors.darkBlue, thickness: 2),
              const SizedBox(width: 8),
              Text(description, style: const TextStyle(fontSize: 12))
            ],
          ),
        ),
      ],
    );
  }

  TextStyle get _textStyle => const TextStyle(
      color: AppColors.darkBlue, fontSize: 12, fontWeight: FontWeight.bold);
}
