import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/global_providers/global_providers.dart';

part 'is_first_item_groups_open_controller.g.dart';

@riverpod
class IsFirstItemGroupsOpenController
    extends _$IsFirstItemGroupsOpenController {
  @override
  bool build() {
    return ref
            .watch(sharedPreferencesProvider)
            .requireValue
            .getBool(Keys.isFirstItemGroupsOpen) ??
        true;
  }

  void setIsFirstCartOpen() {
    ref
        .read(sharedPreferencesProvider)
        .requireValue
        .setBool(Keys.isFirstItemGroupsOpen, false);
    state = false;
  }
}
