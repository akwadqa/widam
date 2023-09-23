import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_to_cart_controller.g.dart';

@riverpod
class GoToTabController extends _$GoToTabController {
  @override
  GoToTabState build() {
    return Initial();
  }

  void goToCart() {
    state = GoToCart();
  }

  void goToHome() {
    state = GoToHome();
  }

  void showCartDialog() {
    state = ShowCartDialog();
  }
}

sealed class GoToTabState {}

class Initial extends GoToTabState {}

class GoToCart extends GoToTabState {}

class GoToHome extends GoToTabState {}

class ShowCartDialog extends GoToTabState {}
