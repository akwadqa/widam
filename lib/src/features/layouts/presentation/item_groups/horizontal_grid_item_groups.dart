import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../theme/app_colors.dart';
import '../../../layouts/domain/basic_item_group/basic_item_group.dart';
import 'item_group_title.dart';

class HorizontalGridItemGroups extends ConsumerWidget {
  const HorizontalGridItemGroups(
      {super.key, required this.itemGroups, required this.backgroundColor});
  final List<BasicItemGroup> itemGroups;
  final String backgroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5 / 1),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              ref
                  .read(paramsControllerProvider.notifier)
                  .set(itemGroups[index].parameters);
              pushItemGroupScreen(
                  context: context, itemGroupId: itemGroups[index].itemGroupId);
            },
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: AppColors.hexToColor(backgroundColor),
                    child: AppCachedNetworkImage(
                      imageUrl: itemGroups[index].itemGroupImage,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                    flex: 2,
                    child:
                        ItemGroupTitle(title: itemGroups[index].itemGroupName))
              ],
            ),
          );
        },
        itemCount: itemGroups.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
