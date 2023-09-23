import 'package:flutter/cupertino.dart';

import '../../gen/assets.gen.dart';
import '../constants/strings.dart';
import '../theme/app_colors.dart';

class MobileNumberPrefix extends StatelessWidget {
  const MobileNumberPrefix({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: BorderDirectional(
            end: BorderSide(color: AppColors.spanishGray, width: 0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsetsDirectional.only(end: 10.0),
      child: Row(
        children: [
          Assets.images.qatarFlag.image(),
          const SizedBox(width: 6),
          const Text(Strings.qatarInternationalCode,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.darkGray),
              textDirection: TextDirection.ltr)
        ],
      ),
    );
  }
}
