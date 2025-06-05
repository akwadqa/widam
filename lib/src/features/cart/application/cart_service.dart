import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/cart/domain/cart/cart_content.dart';
import 'package:widam/src/features/cart/domain/cart/delivery_type.dart';
import 'package:widam/src/features/cart/domain/cart/pickup/pickup.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';
import '../../addresses/application/local_location_info.dart';
import '../data/cart_repository.dart';
import '../domain/cart/cart.dart';
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
      String? pickupPointId,
      String? itemWarehouseId,
      bool? express,
      bool? expressPickup}) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);
    try {
      final String? warehouseId =
          ref.watch(localLocationInfoProvider).warehouseId;
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
          pickupPointId: pickupPointId,
          warehouseId: warehouseId,
          express: express,
          expressPickup: expressPickup,
          itemWarehouseId: itemWarehouseId);
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
      final String? warehouseId =
          ref.watch(localLocationInfoProvider).warehouseId;
      final cart = await cartRepository.deleteItemFromCart(
          itemId: itemId, row: row, warehouseId: warehouseId);
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
int cartCount(Ref ref) => ref.watch(cartControllerProvider).maybeMap(
      data: (cart) => cart.value != null ? cart.value!.totalQty.toInt() : 0,
      orElse: () => 0,
    );
List<DeliveryType>? getPrimaryDeliveryType(dynamic cartContent) {
  if (cartContent is CartContent) {
    final selected = cartContent.normalDelivery ??
        cartContent.expressDelivery ??
        cartContent.pickupDelivery;

    return selected != null ? [selected] : null;
  } else if (cartContent is List<Pickup>) {
    return cartContent.isNotEmpty
        ? cartContent.map((p) => p.toDeliveryType()).toList()
        : null;
  }
  return null;
}

// List<DeliveryType> getAllDeliveryTypes(dynamic cartContent) {
//   if (cartContent is CartContent) {
//     return [
//       cartContent.normalDelivery ??
//           cartContent.expressDelivery ??
//           cartContent.pickupDelivery??
//       if (cartContent.normalDelivery != null) cartContent.normalDelivery!,
//       if (cartContent.expressDelivery != null) cartContent.expressDelivery!,
//       if (cartContent.pickupDelivery != null) cartContent.pickupDelivery!,
//     ];
//   } else if (cartContent is List<Pickup>) {
//     return cartContent.map((p) => p.toDeliveryType()).toList();
//   }
//   return [];
// }

@Riverpod(keepAlive: true)
bool isInCart(Ref ref, String itemId) {
  return ref.watch(cartControllerProvider).maybeMap(
        data: (data) {
          final cart = data.value;
          if (cart == null) return false;

          // Check pickup items
          if (cart.pickup == 1 && cart.cartContent is List<Pickup>) {
            final pickups = cart.cartContent as List<Pickup>;
            return pickups.any((pickup) => pickup.websiteItems
                .any((item) => item.websiteItemId == itemId));
          }

          // Check normal delivery items
          final content = cart.cartContent;
          if (content is CartContent) {
            final normalDeliveryItems = content.normalDelivery?.websiteItems;
            if (normalDeliveryItems != null &&
                normalDeliveryItems
                    .any((item) => item.websiteItemId == itemId)) {
              return true;
            }

            final expressDeliveryItems = content.expressDelivery?.websiteItems;
            if (expressDeliveryItems != null &&
                expressDeliveryItems
                    .any((item) => item.websiteItemId == itemId)) {
              return true;
            }

            final pickupDeliveryItems = content.pickupDelivery?.websiteItems;
            if (pickupDeliveryItems != null &&
                pickupDeliveryItems
                    .any((item) => item.websiteItemId == itemId)) {
              return true;
            }
          }
          return false;
        },
        orElse: () => false,
      );
}

@Riverpod(keepAlive: true)
int quantityInCart(Ref ref, String itemId, [String? row]) {
  final cart = ref.watch(cartControllerProvider).asData?.value;
  if (cart == null) {
    return 0;
  }

  if (cart.pickup == 1) {
    for (var pickup in cart.cartContent) {
      for (var item in pickup.websiteItems) {
        if (item.row == row && item.qtyInCart != null) {
          return item.qtyInCart.toInt();
        }
      }
    }
  } else if (cart.mubadara == 1) {
    for (var item in cart.cartContent.normalDelivery.websiteItems) {
      if (item.row == row && item.qtyInCart != null) {
        return item.qtyInCart.toInt();
      }
    }
  } else {
    return _getItemQuantityInCart(cart, itemId);
  }
  return 0;
}

int _getItemQuantityInCart(Cart cart, String itemId) {
  int count = 0;

  void addItemQuantity(List<ItemDetails> items) {
    for (var item in items) {
      if (item.websiteItemId == itemId && item.qtyInCart != null) {
        count += item.qtyInCart!.toInt();
      }
    }
  }

  if (cart.cartContent.normalDelivery != null) {
    addItemQuantity(cart.cartContent.normalDelivery!.websiteItems);
  }
  if (cart.cartContent.expressDelivery != null) {
    addItemQuantity(cart.cartContent.expressDelivery!.websiteItems);
  }
  if (cart.cartContent.pickupDelivery != null) {
    addItemQuantity(cart.cartContent.pickupDelivery!.websiteItems);
  }

  return count;
}

@Riverpod(keepAlive: true)
double cartTotal(Ref ref) => ref.watch(cartControllerProvider).maybeMap(
      data: (cart) => cart.value != null ? cart.value!.total : 0,
      orElse: () => 0,
    );

@Riverpod(keepAlive: true)
bool isMubadaraCart(Ref ref) => ref.watch(cartControllerProvider).maybeMap(
      data: (cart) => cart.value != null ? cart.value!.mubadara == 1 : false,
      orElse: () => false,
    );
