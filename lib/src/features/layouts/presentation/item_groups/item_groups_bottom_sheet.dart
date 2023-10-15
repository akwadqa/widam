import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/app_close_header.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
import 'package:widam/src/features/layouts/domain/basic_item_group/basic_item_group.dart';
import 'package:widam/src/utils/utils.dart';

import '../../../../../generated/l10n.dart';
import 'item_group_grid_item.dart';

class ItemGroupsBottomSheet extends StatelessWidget {
  const ItemGroupsBottomSheet(
      {super.key, required this.backgroundColor, required this.itemGroups});
  final String backgroundColor;
  final List<BasicItemGroup> itemGroups;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: AppCloseHeader(
          withDivider: false,
          title: S.of(context).categories,
          content: _Content(
              backgroundColor: backgroundColor, itemGroups: itemGroups)),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.backgroundColor, required this.itemGroups});
  final String backgroundColor;
  final List<BasicItemGroup> itemGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: itemGroups.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              ref
                  .read(paramsControllerProvider.notifier)
                  .set(itemGroups[index].parameters);
              pushItemGroupScreen(
                  context: context, itemGroupId: itemGroups[index].itemGroupId);
            },
            child: ItemGroupGridItem(
                showTitleBlock: true,
                itemGroup: itemGroups[index],
                isAllCategory: false,
                backgroundColor: backgroundColor),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 20,
          childAspectRatio: 0.9 / 1.3,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
