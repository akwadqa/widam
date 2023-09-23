import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/features/tags/domain/tag/tag.dart';

import '../../../../theme/app_colors.dart';

class TagItem extends StatelessWidget {
  const TagItem({super.key, required this.tag, this.iconSize = 30});
  final Tag tag;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCachedNetworkImage(
            imageUrl: tag.icon!,
            fit: BoxFit.fitHeight,
            height: iconSize,
            width: iconSize),
        const SizedBox(width: 6),
        Text(tag.title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.taupeGray))
      ],
    );
  }
}
