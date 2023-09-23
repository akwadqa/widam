import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/recommendations_repository.dart';
import '../../domain/recommendation_response/recommendation_response.dart';

part 'frequently_bought_together_controller.g.dart';

@Riverpod(keepAlive: true)
class FrequentlyBoughtTogetherController
    extends _$FrequentlyBoughtTogetherController {
  @override
  FutureOr<RecommendationResponse?> build() => null;

  Future<void> getFrequencyBoughtTogether(String itemId, int quantity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(recommendationsRespositoryProvider)
        .getRecommendations(
            servingConfigs: 'frequently_bought',
            websiteItemId: itemId,
            quantity: quantity));
  }
}
