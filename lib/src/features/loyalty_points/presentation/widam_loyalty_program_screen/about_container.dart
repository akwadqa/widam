import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class AboutContainer extends StatelessWidget {
  const AboutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightgrayishBlue,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).learnAboutWidamPoints,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue)),
              TextButton(
                onPressed: () {},
                child: Text(S.of(context).learnMore,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
          Assets.icons.widamPointsIcon.svg()
        ],
      ),
    );
  }
}
