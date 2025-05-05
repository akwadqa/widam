import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';

part 'filters_controller.g.dart';

@riverpod
class SelectedFilterController extends _$SelectedFilterController {
  @override
  String? build() {
    return null;
  }

  void set(String? value) {
    state = value;
    ref.read(itemGroupItemsControllerProvider.notifier).getItems();
  }
}

@riverpod
List<String> filters(FiltersRef filtersRef) => [
      S.current.priceHighToLow,
      S.current.priceLowToHigh,
      S.current.nameAtoZ,
      S.current.nameZtoA,
    ];
