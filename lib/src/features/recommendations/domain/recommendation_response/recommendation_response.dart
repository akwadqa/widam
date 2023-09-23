import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';

part 'recommendation_response.freezed.dart';
part 'recommendation_response.g.dart';

@freezed
class RecommendationResponse with _$RecommendationResponse {
  factory RecommendationResponse({
    required String attributionToken,
    required List<ItemDetails> websiteItems,
  }) = _RecommendationResponse;

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseFromJson(json);
}
