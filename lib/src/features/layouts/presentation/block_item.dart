import 'package:flutter/material.dart';
import '../../../common_widgets/app_cached_network_image.dart';
import '../../layouts/domain/block.dart';
import '../../../theme/app_colors.dart';

import 'block_data_item.dart';

class BlockItem extends StatelessWidget {
  const BlockItem({super.key, required this.block});

  final Block block;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.hexToColor(block.background);
    final isBannerWithMultipleItems = block.blockType == 'Banner' &&
        block.data is List &&
        block.data.length > 1;
    final withoutHorizontalPadding = block.viewType == 'Circle' ||
        block.viewType == 'Horizontal Scroll' ||
        block.blockType == 'Item' ||
        block.blockType == 'Mubadara';
    const titlePadding = EdgeInsets.only(right: 10, left: 10, bottom: 10);

    Widget buildTitle() {
      if (block.showTitle == 0) {
        return const SizedBox.shrink();
      }
      if (block.icon != null) {
        return Padding(
          padding: titlePadding,
          child: AppCachedNetworkImage(imageUrl: block.icon!, height: 30),
        );
      } else if (block.title == null) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: titlePadding,
        child: Text(
          block.title!,
          style: const TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      );
    }

    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(children: [buildTitle()]),
          Padding(
            padding: isBannerWithMultipleItems || withoutHorizontalPadding
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 10),
            child: BlockDataItem(block: block),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
