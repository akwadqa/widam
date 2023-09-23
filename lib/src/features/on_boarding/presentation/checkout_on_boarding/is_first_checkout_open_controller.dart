import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../main.dart';
import '../../../../constants/keys.dart';

part 'is_first_checkout_open_controller.g.dart';

@riverpod
class IsFirstCheckoutOpenController extends _$IsFirstCheckoutOpenController {
  @override
  bool build() {
    return ref
            .watch(sharedPreferencesProvider)
            .getBool(Keys.isFirstCheckoutOpen) ??
        true;
  }

  void setIsFirstCartOpen() {
    ref
        .read(sharedPreferencesProvider)
        .setBool(Keys.isFirstCheckoutOpen, false);
    state = false;
  }
}
