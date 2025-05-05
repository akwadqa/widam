import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/submit_button.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../theme/app_colors.dart';

class CartBanner extends StatelessWidget {
  const CartBanner(
      {super.key,
      required this.title,
      this.subtitle,
      required this.buttonText,
      required this.onPressed});
  final String title;
  final String? subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: AppColors.veryLightcyan,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
        width: double.infinity,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Assets.images.cartBannerImage.svg(),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.darkBlue),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(color: AppColors.darkBlue),
            ),
          ],
          const SizedBox(height: 8),
          const RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.trending_flat,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: SubmitButton(text: buttonText, onPressed: onPressed))
        ]),
      ),
    );
  }
}
