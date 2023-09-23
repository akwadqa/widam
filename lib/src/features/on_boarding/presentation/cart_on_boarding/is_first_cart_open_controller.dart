import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/main.dart';
import 'package:widam/src/constants/keys.dart';

part 'is_first_cart_open_controller.g.dart';

@riverpod
class IsFirstCartOpenController extends _$IsFirstCartOpenController {
  @override
  bool build() {
    return ref.watch(sharedPreferencesProvider).getBool(Keys.isFirstCartOpen) ??
        true;
  }

  void setIsFirstCartOpen() {
    ref.read(sharedPreferencesProvider).setBool(Keys.isFirstCartOpen, false);
    state = false;
  }
}
