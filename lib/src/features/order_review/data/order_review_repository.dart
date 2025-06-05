import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/features/order_review/domain/order_review/order_review.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

part 'order_review_repository.g.dart';

@riverpod
OrderReviewRepository orderReviewRepository(OrderReviewRepositoryRef ref) {
  return OrderReviewRepository(ref.watch(networkServiceProvider()));
}

class OrderReviewRepository {
  final NetworkService _networkService;

  OrderReviewRepository(this._networkService);

  Future<OrderReview> sendOrderReview(OrderReview review) async {
    final reviewDate = review.toJson();
    reviewDate.removeWhere((key, value) => value == null);
    final response =
        await _networkService.post(EndPoints.customerReview,data:  reviewDate);
    final reviewResponse = AppResponse<OrderReview>.fromJson(
        response.data, (data) => OrderReview.fromJson(data));
    if (reviewResponse.error == 1) {
      throw AppException(reviewResponse.message);
    }
    return reviewResponse.data;
  }
}
