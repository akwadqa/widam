import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/features/udhiya_coupons/domain/udhiya_coupon/udhiya_coupon.dart';
import 'package:widam/src/features/udhiya_coupons/domain/udhiya_coupon_details/udhiya_coupon_details.dart';

import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';

part 'udhiya_coupons_repository.g.dart';

@riverpod
UdhiyaCouponsRepository udhiyaCouponsRepository(
    UdhiyaCouponsRepositoryRef ref) {
  return UdhiyaCouponsRepository(ref.watch(networkServiceProvider()));
}

class UdhiyaCouponsRepository {
  final NetworkService _networkService;

  UdhiyaCouponsRepository(this._networkService);

  Future<List<UdhiyaCoupon>> getUdhiyaCoupons() async {
    final response = await _networkService.get(EndPoints.udhiyaCoupons);
    final tagsResponse = AppResponse<List<UdhiyaCoupon>>.fromJson(
        response.data,
        (json) => json
            .map<UdhiyaCoupon>((tag) => UdhiyaCoupon.fromJson(tag))
            .toList());
    if (tagsResponse.error == 1) {
      throw AppException(tagsResponse.message);
    }
    return tagsResponse.data;
  }

  Future<UdhiyaCouponDetails> getUdhiyaCouponDetails(String couponId) async {
    final response =
        await _networkService.get(EndPoints.udhiyaCoupons, queryParameters: {
      'coupon_id': couponId,
    });
    final tagsResponse = AppResponse<UdhiyaCouponDetails>.fromJson(
        response.data, (json) => UdhiyaCouponDetails.fromJson(json));
    if (tagsResponse.error == 1) {
      throw AppException(tagsResponse.message);
    }
    return tagsResponse.data;
  }
}

@riverpod
FutureOr<List<UdhiyaCoupon>> udhiyaCoupons(UdhiyaCouponsRef ref) {
  return ref.watch(udhiyaCouponsRepositoryProvider).getUdhiyaCoupons();
}

@riverpod
FutureOr<UdhiyaCouponDetails> udhiyaCouponDetails(
    UdhiyaCouponDetailsRef ref, String couponId) {
  return ref
      .watch(udhiyaCouponsRepositoryProvider)
      .getUdhiyaCouponDetails(couponId);
}
