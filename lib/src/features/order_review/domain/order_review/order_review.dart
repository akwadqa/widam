import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_review.freezed.dart';
part 'order_review.g.dart';

@Freezed(toJson: true)
class OrderReview with _$OrderReview {
  factory OrderReview({
    String? customerReviewId,
    required String orderId,
    String? user,
    String? customer,
    double? deliverySpeed,
    double? productQuality,
    double? customerService,
    String? commentsFeedback,
  }) = _OrderReview;

  factory OrderReview.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewFromJson(json);
}
