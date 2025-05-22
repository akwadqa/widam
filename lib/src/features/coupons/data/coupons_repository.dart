import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../domain/coupon/coupon.dart';

part 'coupons_repository.g.dart';

@riverpod
CouponsRepository couponsRepository(CouponsRepositoryRef ref) {
  return CouponsRepository(ref.watch(networkServiceProvider()));
}

class CouponsRepository {
  final NetworkService _networkService;

  CouponsRepository(this._networkService);

  Future<List<Coupon>> getCoupons([String? couponCode]) async {
    final response = await _networkService.get(EndPoints.coupons,
        queryParameters:
            couponCode != null ? {'coupon_code_id': couponCode} : null);
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
FutureOr<List<Coupon>> coupons(CouponsRef ref) {
  return ref.watch(couponsRepositoryProvider).getCoupons();
}
