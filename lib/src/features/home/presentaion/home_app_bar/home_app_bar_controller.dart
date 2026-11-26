import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../item_groups/data/item_groups_repository.dart';
import '../../../item_groups/presentation/item_groups_body/filters_drop_down/filters_controller.dart';
import '../../../item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';
import '../../../item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_controller.dart';
import '../../../item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';
import '../../../items/application/item_group_items_controller.dart';
import '../../../layouts/data/layouts_repository.dart';
import '../../../user_language/application/current_language.dart';

part 'home_app_bar_controller.g.dart';

@riverpod
class HomeAppBarController extends _$HomeAppBarController {
  @override
  void build() {}

  /// Toggles Arabic / English and reloads the content that the API returns
  /// in the selected language.
  void switchLanguage() {
    ref.read(currentLanguageProvider.notifier).changeLanguage();
    ref.invalidate(layoutProvider(LayoutType.home));
    ref.invalidate(layoutProvider(LayoutType.featured));
    ref.invalidate(getAllItemGroupsProvider);
    ref.invalidate(itemGroupItemsControllerProvider);
    ref.invalidate(selectedItemGroupControllerProvider);
    ref.invalidate(selectedSubItemGroupControllerProvider);
    ref.invalidate(itemGroupsSearchControllerProvider);
    ref.invalidate(selectedFilterControllerProvider);
  }
}
