import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';
import '../../../../../theme/app_colors.dart';

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
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(
                        subItemGroups[index].itemGroupName,
                      ),
                      side: isSelected
                          ? const BorderSide(
                              color: AppColors.darkBlue, width: 1)
                          : null,
                      labelStyle: isSelected
                          ? const TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.w600)
                          : null,
                      padding: const EdgeInsets.only(
                          bottom: 6, top: 4, left: 4, right: 4),
                      onSelected: (bool value) {
                        ref
                            .read(
                                selectedSubItemGroupControllerProvider.notifier)
                            .set(value
                                ? subItemGroups[index].itemGroupId
                                : null);
                      },
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
