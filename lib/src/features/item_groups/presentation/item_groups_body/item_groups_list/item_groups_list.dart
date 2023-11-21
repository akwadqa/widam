import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../common_widgets/app_cached_network_image.dart';
import '../../../../../theme/app_colors.dart';
import '../../../domain/item_group/item_group.dart';

class ItemGroupList extends StatelessWidget {
  const ItemGroupList({super.key, required this.itemGroups, this.focusNode});
  final List<ItemGroup> itemGroups;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemGroups.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return _ItemGroup(
            itemGroup: itemGroups[index],
            focusNode: index == 1 ? focusNode : null);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 14),
    );
  }
}

class _ItemGroup extends ConsumerWidget {
  const _ItemGroup({required this.itemGroup, this.focusNode});
  final ItemGroup itemGroup;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedItemGroupControllerProvider);
    final isSelected = selectedId == itemGroup.itemGroupId;
    return InkWell(
      onTap: () => ref
          .read(selectedItemGroupControllerProvider.notifier)
          .onCategorySelected(itemGroup.itemGroupId),
      child: Focus(
        focusNode: focusNode,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: itemGroup.itemGroupId == Strings.allItemGroup
                        ? Assets.icons.categoryIcon.svg()
                        : AppCachedNetworkImage(
                            imageUrl: itemGroup.itemGroupImage,
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(itemGroup.itemGroupName,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color:
                              isSelected ? Colors.black : AppColors.taupeGray),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            if (isSelected)
              Container(
                height: 75,
                width: 6,
                decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
              )
          ],
        ),
      ),
    );
  }
}
