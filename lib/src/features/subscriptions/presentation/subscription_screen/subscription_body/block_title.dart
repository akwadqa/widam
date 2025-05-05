import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';

class BlockTitle extends StatelessWidget {
  const BlockTitle({super.key, required this.title, this.icon});

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: icon == null
            ? _text
            : Row(
                children: [icon!, const SizedBox(width: 5), _text],
              ));
  }

  Text get _text => Text(title,
      style: const TextStyle(
          color: AppColors.raisinBlack, fontWeight: FontWeight.w600));
}
