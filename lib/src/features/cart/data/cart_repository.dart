import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../domain/cart/cart.dart';
import '../../../network/network_service.dart';

part 'cart_repository.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) =>
    CartRepository(ref.watch(networkServiceProvider()));

class CartRepository {
  final NetworkService _networkService;

  CartRepository(this._networkService);

  Future<Cart?> getCart() async {
    final response = await _networkService.get(EndPoints.cart);
    return _handleResponse(response);
  }

  final _lock = Lock();
  Future<Cart?> updateCart(
      {String? itemId,
      int? quantity,
      String? attributionToken,
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
      List<({String productOptionId, int radioOptionId, int isPriceModifier})>?
          productOptions}) async {
    return await _lock.synchronized(() async {
      final FormData formData = FormData.fromMap({
        if (itemId != null)
          'website_items': jsonEncode([
            {'website_item_id': itemId, 'quantity': quantity, if(attributionToken != null) 'attribution_token' : attributionToken}
          ]),
        if (qid != null) 'qid_field_placeholder': qid,
        if (file != null)
          'file': MultipartFile.fromFile(file.path, filename: file.name),
        if (shippingAddressId != null) 'shipping_address_id': shippingAddressId,
        if (timeSlot != null) 'time_slot': timeSlot,
        if (couponCode != null) 'coupon_code': couponCode,
        if (paymentMethodId != null) 'payment_method': paymentMethodId,
        if (paymentTokenId != null) 'payment_token_id': paymentTokenId,
        if (paymentToken != null) 'payment_token': paymentToken,
        if (deliveryDate != null) 'delivery_date': deliveryDate,
        if (productOptions != null)
          'product_options': jsonEncode(productOptions
              .map((e) => {
                    "product_option_name": e.productOptionId,
                    "product_option_value": e.radioOptionId,
                    "is_price_modifier": e.isPriceModifier
                  })
              .toList()),
        if (useWalletBalance != null) 'use_wallet_balance': useWalletBalance,
      });
      print(formData.fields);
      final response = await _networkService.put(EndPoints.cart, formData);
      return _handleResponse(response);
    });
  }

  Future<Cart?> deleteItemFromCart(
      {required String itemId, String? row}) async {
    return await _lock.synchronized(() async {
      final FormData formData = FormData.fromMap({
        'website_items': jsonEncode([
          {'website_item_id': itemId, 'quantity': 0}
        ]),
        if (row != null) 'row': row,
      });
      final response = await _networkService.put(EndPoints.cart, formData);
      return _handleResponse(response);
    });
  }

  Cart? _handleResponse(response) {
    final AppResponse<Cart?> cartResponse = AppResponse.fromJson(
        response.data,
        (json) => json is String
            ? null
            : json is List && json.isEmpty
                ? null
                : Cart.fromJson(json));
    if (cartResponse.error == 1) {
      throw Exception(cartResponse.message);
    }
    return cartResponse.data;
  }
}
