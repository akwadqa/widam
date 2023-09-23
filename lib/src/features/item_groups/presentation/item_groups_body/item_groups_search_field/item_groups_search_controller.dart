import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';

part 'item_groups_search_controller.g.dart';

@riverpod
class ItemGroupsSearchController extends _$ItemGroupsSearchController {
  @override
  String? build() {
    return null;
  }

  void set(String? value) {
    state = value;
    ref.read(itemGroupItemsControllerProvider.notifier).getItems();
  }
}