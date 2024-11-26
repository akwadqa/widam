import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../cart/application/cart_service.dart';
import '../../data/recommendations_repository.dart';
import '../../domain/recommendation_response/recommendation_response.dart';

part 'similar_items_controller.g.dart';

@riverpod
class SimilarItemsController extends _$SimilarItemsController {
  @override
  FutureOr<SimilarItemsData> build(String quotationId) {
    return _getRecommendations(quotationId);
  }

  Future<SimilarItemsData> _getRecommendations(String quotationId) async {
    final recommendationResponse = await ref
        .watch(recommendationsRespositoryProvider)
        .getRecommendations(
            servingConfigs: 'similar_items', quotationId: quotationId);
    return SimilarItemsData(recommendationResponse: recommendationResponse);
  }

  Future<void> addToCart(String itemId, String itemWarehouseId, int quantity) async {
    final SimilarItemsData similarItemsData = state.asData!.value;
    state = AsyncData(similarItemsData.copyWith(itemIdLoading: itemId));
    final result = await ref
        .read(updateCartProvider.notifier)
        .updateCart(itemId: itemId, itemWarehouseId: itemWarehouseId, quantity: quantity)
        .catchError((error, stackTrace) {
      state = AsyncData(similarItemsData.copyWith(itemIdLoading: null));
      return false;
    });
    if (result) {
      state = AsyncData(similarItemsData.copyWith(
          recommendationResponse: similarItemsData.recommendationResponse
              .copyWith(
                  websiteItems: similarItemsData
                      .recommendationResponse.websiteItems
                      .where((element) => element.websiteItemId != itemId)
                      .toList()),
          itemIdLoading: null));
    } else {
      state = AsyncData(similarItemsData.copyWith(itemIdLoading: null));
    }
  }
}

class SimilarItemsData {
  final RecommendationResponse recommendationResponse;
  final String? itemIdLoading;

  SimilarItemsData({required this.recommendationResponse, this.itemIdLoading});

  SimilarItemsData copyWith(
      {RecommendationResponse? recommendationResponse, String? itemIdLoading}) {
    return SimilarItemsData(
        recommendationResponse:
            recommendationResponse ?? this.recommendationResponse,
        itemIdLoading: itemIdLoading ?? this.itemIdLoading);
  }
}
