import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../common_widgets/app_close_button.dart';
import '../../../../theme/app_colors.dart';

class AdaptiveBackButton extends StatelessWidget {
  const AdaptiveBackButton({super.key, this.width, this.height});
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppCloseButton(
          width: width,
          height: height,
          icon: Padding(
            padding: Platform.isIOS
                ? const EdgeInsetsDirectional.only(start: 4.0)
                : const EdgeInsetsDirectional.only(start: 0.0),
            child: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                color: AppColors.vividCerulean),
          )),
    );
  }
}
