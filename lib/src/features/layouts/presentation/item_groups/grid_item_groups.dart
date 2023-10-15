import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
import 'package:widam/src/features/layouts/presentation/item_groups/item_groups_bottom_sheet.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../layouts/domain/basic_item_group/basic_item_group.dart';
import 'item_group_grid_item.dart';

class GridItemGroups extends ConsumerWidget {
  const GridItemGroups(
      {Key? key,
      required this.itemGroups,
      required this.backgroundColor,
      required this.showTitleBlock})
      : super(key: key);
  final List<BasicItemGroup> itemGroups;
  final String backgroundColor;
  final bool showTitleBlock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subList = itemGroups.sublist(0, itemGroups.length > 11 ? 11 : null);
    return GridView.builder(
      itemCount: itemGroups.length > 11 ? subList.length + 1 : subList.length,
      itemBuilder: (BuildContext context, int index) {
        final isAllCategory = index == subList.length;
        return Consumer(
          builder: (context, ref, child) {
            return InkWell(
              onTap: () {
                if (isAllCategory) {
                  showAdaptiveModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ItemGroupsBottomSheet(
                            backgroundColor: backgroundColor,
                            itemGroups: itemGroups);
                      });
                } else {
                  ref
                      .read(paramsControllerProvider.notifier)
                      .set(subList[index].parameters);
                  pushItemGroupScreen(
                      context: context,
                      itemGroupId: subList[index].itemGroupId);
                }
              },
              child: ItemGroupGridItem(
                  showTitleBlock: showTitleBlock,
                  backgroundColor: backgroundColor,
                  itemGroup: isAllCategory ? null : subList[index],
                  isAllCategory: isAllCategory),
            );
          },
        );
      },
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: showTitleBlock ? 0.9 / 1.4 : 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
