import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/addresses/application/local_location_info.dart';
import '../../data/cart_repository.dart';
import '../../domain/cart/cart.dart';

part 'cart_controller.g.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  @override
  FutureOr<Cart?> build() {
    return _getCart();
  }

  Future<Cart?> _getCart() async {
    final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
    final String? warehouseId = ref.watch(localLocationInfoProvider).warehouseId;
    return cartRepository.getCart(warehouseId);
  }

  void updateCart(Cart? cart) {
    state = AsyncData(cart);
  }
}
