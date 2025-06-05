import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_points_log/loyalty_points_log.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_program/loyalty_program.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

part 'loyalty_points_repository.g.dart';

@riverpod
LoyaltyPointsRepository loyaltyPointsRepository(
    LoyaltyPointsRepositoryRef ref) {
  return LoyaltyPointsRepository(ref.watch(networkServiceProvider()));
}

class LoyaltyPointsRepository {
  final NetworkService _networkService;

  LoyaltyPointsRepository(this._networkService);

  Future<AppResponse<List<LoyaltyPointsLog>>> getloyaltyPointsLog(
      int pageNo) async {
    final response =
        await _networkService.get(EndPoints.loyaltyPointsLog, queryParameters: {
      'page_no': pageNo,
    });

    AppResponse<List<LoyaltyPointsLog>> appResponse = AppResponse.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => LoyaltyPointsLog.fromJson(e)).toList());

    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }

    return appResponse;
  }

  Future<LoyaltyProgram?> getLoyaltyProgram() async {
    final response = await _networkService.get(EndPoints.loyaltyProgram);
    final AppResponse<LoyaltyProgram?> loyaltyProgramResponse =
        AppResponse.fromJson(response.data,
            (json) => json is List ? null : LoyaltyProgram.fromJson(json));

    if (loyaltyProgramResponse.error == 1) {
      throw AppException(loyaltyProgramResponse.message);
    }
    return loyaltyProgramResponse.data;
  }

  Future<String> redeemPoints() async {
    final response = await _networkService.post(EndPoints.redeemPoints);
    final AppResponse<String> redeemPointsResponse =
        AppResponse.fromJson(response.data, (json) => json.toString());

    if (redeemPointsResponse.error == 1) {
      throw AppException(redeemPointsResponse.message);
    }
    return redeemPointsResponse.data;
  }
}
