import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';

part 'filters_controller.g.dart';
enum FilterType {
  priceHighToLow,
  priceLowToHigh,
  nameAtoZ,
  nameZtoA,
}
@riverpod
class SelectedFilterController extends _$SelectedFilterController {
  @override
 FilterType? build() {
    return null;
  }

  void set(FilterType? value) {
    state = value;
  }
}

@riverpod
List<FilterType> filters(Ref ref) {
  ref.watch(currentLanguageProvider);

  return [
    FilterType.priceHighToLow,
    FilterType.priceLowToHigh,
    FilterType.nameAtoZ,
    FilterType.nameZtoA,
  ];
}
