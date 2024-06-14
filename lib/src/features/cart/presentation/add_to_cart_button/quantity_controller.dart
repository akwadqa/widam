import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../application/cart_service.dart';

part 'quantity_controller.g.dart';

@riverpod
class QuantityController extends _$QuantityController {
  final _debouncer = Debouncer(delayMilliseconds: 1000);
  @override
  int build(String itemId, int minQuantity, [String? row]) {
    final quantityInCart = ref.watch(quantityInCartProvider(itemId, row));
    return quantityInCart == 0 ? minQuantity : quantityInCart;
  }

  void increamentQuantity() {
    state = state + 1;
    _updateCart();
  }

  void decrementQuantity() {
    state = state - 1;
    _updateCart();
  }

  void addTocart(String? attributionToken) {
    _updateCart();
  }

  Future<void> _updateCart([String? attributionToken]) async {
    _debouncer.call(() {
      ref
          .read(updateCartProvider.notifier)
          .updateCart(
              itemId: itemId,
              quantity: state,
              attributionToken: attributionToken)
          .then((result) {
        if (!result) {
          ref.invalidate(quantityControllerProvider(itemId, minQuantity));
        }
      });
    });
  }
}

class Debouncer {
  final int delayMilliseconds;
  Timer? _timer;

  Debouncer({required this.delayMilliseconds});

  void call(Function() callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMilliseconds), callback);
  }
}
