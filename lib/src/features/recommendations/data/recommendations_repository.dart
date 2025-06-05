import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/features/recommendations/domain/recommendation_response/recommendation_response.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

part 'recommendations_repository.g.dart';

@riverpod
RecommendationsRespository recommendationsRespository(
        RecommendationsRespositoryRef ref) =>
    RecommendationsRespository(ref.watch(networkServiceProvider()));

class RecommendationsRespository {
  final NetworkService _networkService;

  RecommendationsRespository(this._networkService);

  Future<RecommendationResponse> getRecommendations(
      {required String servingConfigs,
      String? quotationId,
      String? websiteItemId,
      int? quantity}) async {
    final formData = FormData.fromMap({
      'serving_configs': servingConfigs,
      if (quotationId != null) 'quotation_id': quotationId,
      if (websiteItemId != null) 'website_item_id': websiteItemId,
      if (quantity != null) 'quantity': quantity
    });
    final response = await _networkService.post(
      EndPoints.recommendations,
    data:   formData,
    );
    debugPrint("**********************");
    debugPrint(servingConfigs.toString());
    debugPrint(quotationId.toString());
    debugPrint(websiteItemId.toString());
    debugPrint(quantity.toString());
    debugPrint(formData.toString());
    AppResponse<RecommendationResponse> recommendationResponse =
        AppResponse<RecommendationResponse>.fromJson(
            response.data, (json) => RecommendationResponse.fromJson(json));

    if (recommendationResponse.error == 1) {
      throw AppException(recommendationResponse.message);
    }
    return recommendationResponse.data;
  }
}

@riverpod
FutureOr<RecommendationResponse> recommendations(
    RecommendationsRef ref, String quotationId) {
  return ref.watch(recommendationsRespositoryProvider).getRecommendations(
      servingConfigs: 'recommendations', quotationId: quotationId);
}
