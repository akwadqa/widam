import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/item_groups/domain/item_group/item_group.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';

part 'sub_item_groups_controller.g.dart';

@riverpod
class SubItemGroupsController extends _$SubItemGroupsController {
  @override
  List<ItemGroup> build() {
    return [];
  }

  void set(List<ItemGroup> value) {
    state = value;
  }
}

@riverpod
class SelectedSubItemGroupController extends _$SelectedSubItemGroupController {
  @override
  String? build() {
    return null;
  }

  void set(String? value) {
    state = value;
    ref.read(itemGroupItemsControllerProvider.notifier).getItems();
  }
}
