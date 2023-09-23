import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/basic_item_group/basic_item_group.dart';
import 'item_group_title.dart';

class ItemGroupGridItem extends StatelessWidget {
  const ItemGroupGridItem({
    super.key,
    required this.itemGroup,
    required this.isAllCategory,
    required this.backgroundColor,
  });

  final BasicItemGroup? itemGroup;
  final bool isAllCategory;
  final String backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.hexToColor(backgroundColor),
                  padding: EdgeInsets.all(isAllCategory ? 30 : 5),
                ),
              ),
              isAllCategory
                  ? Center(
                      child:
                          Assets.icons.categoryIcon.svg(height: 50, width: 50))
                  : AppCachedNetworkImage(
                      imageUrl: itemGroup!.itemGroupImage,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
            child: ItemGroupTitle(
                title: isAllCategory
                    ? S.of(context).viewAllCategories
                    : itemGroup!.itemGroupName))
      ],
    );
  }
}
