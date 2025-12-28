import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import '../../../constants/end_points.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../domain/coupon/coupon.dart';

part 'coupons_repository.g.dart';

@riverpod
CouponsRepository couponsRepository(Ref ref) {
  return CouponsRepository(ref.watch(networkServiceProvider()));
}

class CouponsRepository {
  final NetworkService _networkService;

  CouponsRepository(this._networkService);

  Future<List<Coupon>> getCoupons(
      {String? couponCode, String? customer}) async {
    final response = await _networkService.get(
      EndPoints.coupons,
      queryParameters: {
        if (couponCode != null) 'coupon_code_id': couponCode,
        if (customer != null) "customer": customer,
      },
    );
    final couponsResponse =
        AppResponse<List<Coupon>>.fromJson(response.data, (json) {
      return (json as List).map((e) => Coupon.fromJson(e)).toList();
    });

    if (couponsResponse.error == 1) {
      throw AppException(couponsResponse.message);
    }

    return couponsResponse.data;
  }
}

@riverpod
FutureOr<List<Coupon>> coupons(Ref ref) {
  final userData = ref.watch(userDataProvider);
  return ref
      .watch(couponsRepositoryProvider)
      .getCoupons(customer: userData?.customerId);
}
