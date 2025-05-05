import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/app_filter_chip.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';

class SubItemGroupsList extends ConsumerWidget {
  const SubItemGroupsList(
      {super.key, this.shrinkWrap = false, this.withoutBottomPadding = false});
  final bool shrinkWrap;
  final bool withoutBottomPadding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subItemGroups = ref.watch(subItemGroupsControllerProvider);
    return subItemGroups.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: 40,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: subItemGroups.length,
                itemBuilder: (context, index) {
                  final isSelected =
                      ref.watch(selectedSubItemGroupControllerProvider) ==
                          subItemGroups[index].itemGroupId;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppFilterChip(
                      isSelected: isSelected,
                      onSelected: (bool value) {
                        ref
                            .read(
                                selectedSubItemGroupControllerProvider.notifier)
                            .set(value
                                ? subItemGroups[index].itemGroupId
                                : null);
                      },
                      lable: subItemGroups[index].itemGroupName,
                    ),
                  );
                },
                physics:
                    shrinkWrap ? const NeverScrollableScrollPhysics() : null,
                shrinkWrap: shrinkWrap,
                padding: EdgeInsets.only(
                    left: 10, right: 10, bottom: withoutBottomPadding ? 0 : 10),
                separatorBuilder: (context, index) => const SizedBox(width: 6)),
          );
  }
}
