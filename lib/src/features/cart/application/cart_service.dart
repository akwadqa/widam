import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/cart_repository.dart';
import '../domain/cart/cart.dart';
import '../domain/cart/pickup/pickup.dart';
import '../presentation/cart_body/cart_controller.dart';

part 'cart_service.g.dart';

@Riverpod(keepAlive: true)
class UpdateCart extends _$UpdateCart {
  @override
  FutureOr<void> build() {}

  Future<bool> updateCart(
      {String? itemId,
      int? quantity,
      String? shippingAddressId,
      String? timeSlot,
      String? qid,
      XFile? file,
      String? couponCode,
      String? paymentMethodId,
      String? paymentTokenId,
      int? paymentToken,
      String? deliveryDate,
      int? useWalletBalance,
      String? attributionToken,
      bool? isPriceModifier,
      String? pickupPointId}) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);
    try {
      final cart = await cartRepository.updateCart(
          itemId: itemId,
          quantity: quantity,
          shippingAddressId: shippingAddressId,
          timeSlot: timeSlot,
          couponCode: couponCode,
          qid: qid,
          file: file,
          paymentMethodId: paymentMethodId,
          paymentTokenId: paymentTokenId,
          paymentToken: paymentToken,
          deliveryDate: deliveryDate,
          isPriceModifier: isPriceModifier,
          useWalletBalance: useWalletBalance,
          attributionToken: attributionToken,
          pickupPointId: pickupPointId);
      ref.read(cartControllerProvider.notifier).updateCart(cart);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> deleteItemFromCart({required String itemId, String? row}) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);
    try {
      final cart =
          await cartRepository.deleteItemFromCart(itemId: itemId, row: row);
      ref.read(cartControllerProvider.notifier).updateCart(cart);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  void refreshCart() {
    ref.invalidate(cartControllerProvider);
  }

  void setCart(Cart? cart) {
    ref.read(cartControllerProvider.notifier).updateCart(cart);
  }
}

@Riverpod(keepAlive: true)
int cartCount(CartCountRef ref) => ref.watch(cartControllerProvider).maybeMap(
      data: (cart) => cart.value != null ? cart.value!.totalQty.toInt() : 0,
      orElse: () => 0,
    );

@Riverpod(keepAlive: true)
bool isInCart(IsInCartRef ref, String itemId) =>
    ref.watch(cartControllerProvider).maybeMap(
        data: (data) {
          final Cart? cart = data.value;
          if (cart != null) {
            if (cart.pickup == 1) {
              cart.cartContent.forEach((Pickup element) {
                if (element.websiteItems
                    .any((element) => element.websiteItemId == itemId)) {
                  return true;
                }
              });
              return false;
            }
            return cart.cartContent.normalDelivery.websiteItems
                .any((element) => element.websiteItemId == itemId);
          }
          return false;
        },
        orElse: () => false);

@Riverpod(keepAlive: true)
int quantityInCart(QuantityInCartRef ref, String itemId) {
  final cart = ref.watch(cartControllerProvider).asData?.value;
  if (cart == null) {
    return 0;
  }

  if (cart.pickup == 1) {
    for (var pickup in cart.cartContent) {
      for (var item in pickup.websiteItems) {
        if (item.websiteItemId == itemId && item.qtyInCart != null) {
          return item.qtyInCart.toInt();
        }
      }
    }
  } else {
    for (var item in cart.cartContent.normalDelivery.websiteItems) {
      if (item.websiteItemId == itemId && item.qtyInCart != null) {
        return item.qtyInCart.toInt();
      }
    }
  }
  return 0;
}

@Riverpod(keepAlive: true)
double cartTotal(CartTotalRef ref) =>
    ref.watch(cartControllerProvider).maybeMap(
          data: (cart) => cart.value != null ? cart.value!.total : 0,
          orElse: () => 0,
        );

@Riverpod(keepAlive: true)
bool isMubadaraCart(IsMubadaraCartRef ref) =>
    ref.watch(cartControllerProvider).maybeMap(
          data: (cart) =>
              cart.value != null ? cart.value!.mubadara == 1 : false,
          orElse: () => false,
        );
