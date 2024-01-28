import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';

import '../domain/item_details/item_details.dart';

part 'item_details_repository.g.dart';

@Riverpod(keepAlive: true)
ItemDetailsRepository itemDetailsRepository(ItemDetailsRepositoryRef ref) =>
    ItemDetailsRepository(ref.watch(networkServiceProvider()));

class ItemDetailsRepository {
  final NetworkService _networkService;

  const ItemDetailsRepository(this._networkService);

  Future<ItemDetails> getItemDetails(
      {required String itemId,
      String? mubadaraId,
      String? attributionToken}) async {
    final Map<String, dynamic> queryParameters = {
      'website_item_id': itemId,
      'get_attribute_variants': 1,
      if (mubadaraId != null) 'get_mubadara_details': mubadaraId,
      if (attributionToken != null) 'attribution_token': attributionToken
    };

    final response = await _networkService.get(EndPoints.itemDetails,
        queryParameters: queryParameters);
    AppResponse<ItemDetails> itemDetailsResponse =
        AppResponse<ItemDetails>.fromJson(
            response.data, (json) => ItemDetails.fromJson(json));
    if (itemDetailsResponse.error == 1) {
      throw AppException(itemDetailsResponse.message);
    }
    return itemDetailsResponse.data;
  }

  Future<({bool isValid, String message})> validateQid(
      {required String qid,
      required String mubadaraId,
      required int quantity}) async {
    final formData = FormData.fromMap({
      'qid': qid,
      'mubadara_id': mubadaraId,
      'quantity': quantity,
    });

    final response =
        await _networkService.post(EndPoints.validateQid, formData);
    AppResponse<bool> validateQidResponse = AppResponse<bool>.fromJson(
        response.data, (json) => json['permitted'] == 1);
    if (validateQidResponse.error == 1) {
      throw AppException(validateQidResponse.message);
    }
    return (
      isValid: validateQidResponse.data,
      message: response.data['message'] as String
    );
  }
}
