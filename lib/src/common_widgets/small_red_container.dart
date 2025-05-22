import 'package:flutter/widgets.dart';

import '../theme/app_colors.dart';

class SmallRedContainer extends StatelessWidget {
  const SmallRedContainer({super.key, required this.text, this.maxLines});
  final String text;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrayishRed,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(3),
        child: Text(text,
            style: const TextStyle(
                fontSize: 10,
                color: AppColors.red,
                fontWeight: FontWeight.w600),
            maxLines: maxLines));
  }
}
