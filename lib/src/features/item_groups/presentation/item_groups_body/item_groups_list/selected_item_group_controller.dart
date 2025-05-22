import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';

part 'selected_item_group_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectedItemGroupController extends _$SelectedItemGroupController {
  @override
  String build() {
    return Strings.allItemGroup;
  }

  void onCategorySelected(String categoryId) {
    state = categoryId;
    ref.read(selectedSubItemGroupControllerProvider.notifier).set(null);
    ref.read(subItemGroupsControllerProvider.notifier).set([]);
    ref.read(itemGroupItemsControllerProvider.notifier).getItems();
  }
}
