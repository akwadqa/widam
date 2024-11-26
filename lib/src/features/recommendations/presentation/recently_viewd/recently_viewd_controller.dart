import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/recommendations/domain/recommendation_response/recommendation_response.dart';

import '../../../cart/application/cart_service.dart';
import '../../data/recommendations_repository.dart';

part 'recently_viewd_controller.g.dart';

@riverpod
class RecentlyViewdController extends _$RecentlyViewdController {
  @override
  FutureOr<RecentlyViewdData> build(String quotationId) {
    return _getRecommendations(quotationId);
  }

  Future<RecentlyViewdData> _getRecommendations(String quotationId) async {
    final recommendationResponse = await ref
        .watch(recommendationsRespositoryProvider)
        .getRecommendations(
            servingConfigs: 'recently_viewed_default',
            quotationId: quotationId);
    return RecentlyViewdData(recommendationResponse: recommendationResponse);
  }

  Future<void> addToCart(
      String itemId, String itemWarehouseId, int quantity) async {
    final RecentlyViewdData recentlyViewdData = state.asData!.value;
    state = AsyncData(recentlyViewdData.copyWith(itemIdLoading: itemId));
    final result = await ref
        .read(updateCartProvider.notifier)
        .updateCart(
            itemId: itemId,
            itemWarehouseId: itemWarehouseId,
            quantity: quantity)
        .catchError((error, stackTrace) {
      state = AsyncData(recentlyViewdData.copyWith(itemIdLoading: null));
      return false;
    });
    if (result) {
      state = AsyncData(recentlyViewdData.copyWith(
          recommendationResponse: recentlyViewdData.recommendationResponse
              .copyWith(
                  websiteItems: recentlyViewdData
                      .recommendationResponse.websiteItems
                      .where((element) => element.websiteItemId != itemId)
                      .toList()),
          itemIdLoading: null));
    } else {
      state = AsyncData(recentlyViewdData.copyWith(itemIdLoading: null));
    }
  }
}

class RecentlyViewdData {
  final RecommendationResponse recommendationResponse;
  final String? itemIdLoading;

  RecentlyViewdData({required this.recommendationResponse, this.itemIdLoading});

  RecentlyViewdData copyWith(
      {RecommendationResponse? recommendationResponse, String? itemIdLoading}) {
    return RecentlyViewdData(
        recommendationResponse:
            recommendationResponse ?? this.recommendationResponse,
        itemIdLoading: itemIdLoading ?? this.itemIdLoading);
  }
}
