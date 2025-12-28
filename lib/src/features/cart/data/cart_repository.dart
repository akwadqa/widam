import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../domain/cart/cart.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

part 'cart_repository.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) =>
    CartRepository(ref.watch(networkServiceProvider()));

class CartRepository {
  final NetworkService _networkService;

  CartRepository(this._networkService);

  Future<Cart?> getCart([String? warehouseId]) async {
    final response = await _networkService.get(EndPoints.cart,
        queryParameters:
            warehouseId != null ? {'warehouse': warehouseId} : null);
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
      bool? isPriceModifier,
      String? pickupPointId,
      String? warehouseId,
      String? itemWarehouseId,
      String? shippingAddress,
      bool? express,
      List<Map<String, dynamic>>? productOptions, // ✅ added

      bool? expressPickup}) async {
    return await _lock.synchronized(() async {
      final FormData formData = FormData.fromMap({
        if (itemId != null)
          'website_items': jsonEncode([
            {
              'website_item_id': itemId,
              'quantity': quantity,
              if (pickupPointId != null) 'pickup_point': pickupPointId,
              if (attributionToken != null)
                'attribution_token': attributionToken,
              if (isPriceModifier != null)
                'price_modifier': isPriceModifier ? 1 : 0,
              if (itemWarehouseId != null) 'warehouse': itemWarehouseId,
              if (productOptions != null && productOptions.isNotEmpty)
                'product_options': productOptions, // ✅ inserted correctly
            }
          ]),
        if (itemId != null && warehouseId != null) 'warehouse': warehouseId,
        if (pickupPointId != null && timeSlot != null)
          'item_pickup_point': jsonEncode({
            'pickup_point_id': pickupPointId,
            'time_slot': timeSlot,
            'delivery_date': deliveryDate,
          }),
        if (qid != null) 'qid_field_placeholder': qid,
        if (file != null)
          'file': await MultipartFile.fromFile(file.path, filename: file.name),
        if (shippingAddressId != null) 'shipping_address_id': shippingAddressId,
        if (timeSlot != null && pickupPointId == null) 'time_slot': timeSlot,
        if (couponCode != null) 'coupon_code': couponCode,
        if (paymentMethodId != null) 'payment_method': paymentMethodId,
        if (paymentTokenId != null) 'payment_token_id': paymentTokenId,
        if (paymentToken != null) 'payment_token': paymentToken,
        if (deliveryDate != null && pickupPointId == null)
          'delivery_date': deliveryDate,
        if (useWalletBalance != null) 'use_wallet_balance': useWalletBalance,
        if (express != null) 'express': express ? 1 : 0,
        if (expressPickup != null) 'express_pickup': expressPickup ? 1 : 0
      });
      debugPrint(formData.toString());
      for (var field in formData.fields) {
        debugPrint('Field: ${field.key} => ${field.value}');
      }

      final response = await _networkService.put(EndPoints.cart,
          data: formData,
          queryParameters: warehouseId != null
              ? {
                  'warehouse': warehouseId,
                  // if(shippingAddressId!=null)  "shipping_address_id":shippingAddressId
                }
              : null);
      return _handleResponse(response);
    });
  }

  Future<Cart?> deleteItemFromCart(
      {required String itemId, String? row, String? warehouseId}) async {
    return await _lock.synchronized(() async {
      final FormData formData = FormData.fromMap({
        'website_items': jsonEncode([
          {'website_item_id': itemId, 'quantity': 0}
        ]),
        if (row != null) 'row': row,
      });
      final response = await _networkService.put(EndPoints.cart,
          data: formData,
          queryParameters:
              warehouseId != null ? {'warehouse': warehouseId} : null);
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
      throw AppException(cartResponse.message);
    }
    return cartResponse.data;
  }
}
