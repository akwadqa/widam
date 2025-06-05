import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../addresses/application/local_location_info.dart';
import '../../item_groups/domain/item_group_details/item_group_details.dart';
import '../domain/subscription.dart';
part 'subscriptions_repository.g.dart';

@riverpod
SubscriptionsRepository subscriptionsRepository(
        SubscriptionsRepositoryRef ref) =>
    SubscriptionsRepository(ref.watch(networkServiceProvider()));

class SubscriptionsRepository {
  final NetworkService _networkService;

  SubscriptionsRepository(this._networkService);

  Future<AppResponse<ItemGroupDetails>> getAllItemGroupsSubscriptions(
      {required int page, String? warehouseId}) async {
    final queryParameters = {
      'page_no': page,
      'subscription_item_group': 1,
      if (warehouseId != null) 'warehouse': warehouseId
    };
    final response = await _networkService.get(EndPoints.itemGroups,
        queryParameters: queryParameters);
    AppResponse<ItemGroupDetails> itemGroupsResponse =
        AppResponse<ItemGroupDetails>.fromJson(
            response.data, (json) => ItemGroupDetails.fromJson(json));
    if (itemGroupsResponse.error == 1) {
      throw AppException(itemGroupsResponse.message);
    }
    return itemGroupsResponse;
  }

  Future<AppResponse<ItemGroupDetails>> getItemsByItemGroupSubscriptions(
      {required String itemGroupId,
      required int page,
      String? warehouseId}) async {
    final queryParameters = {
      'item_group_id': itemGroupId,
      'page_no': page,
      'subscription_item_group': 1,
      if (warehouseId != null) 'warehouse': warehouseId,
    };
    final response = await _networkService.get(EndPoints.itemGroups,
        queryParameters: queryParameters);
    AppResponse<ItemGroupDetails> itemGroupResponse =
        AppResponse<ItemGroupDetails>.fromJson(
            response.data, (json) => ItemGroupDetails.fromJson(json));
    if (itemGroupResponse.error == 1) {
      throw AppException(itemGroupResponse.message);
    }
    return itemGroupResponse;
  }

  Future<AppResponse> addSubscription(Subscription subscriptionInfo,
      [String? warehouseId]) async {
    final queryParameters = {
      if (warehouseId != null) 'warehouse': warehouseId,
    };
    final formData = FormData.fromMap(subscriptionInfo.toJson());
    final response = await _networkService.post(
        EndPoints.addSubscription,data:  formData,queryParameters:  queryParameters);
    AppResponse subscriptionResponse =
        AppResponse.fromJson(response.data, (json) => json);
    if (subscriptionResponse.error == 1) {
      throw AppException(subscriptionResponse.message);
    }
    return subscriptionResponse;
  }

  Future<List<Subscription>> getActiveSubscriptions() async {
    final response = await _networkService.get(EndPoints.getSubscriptions);
    AppResponse<List<Subscription>> subscriptionsResponse =
        AppResponse<List<Subscription>>.fromJson(
            response.data,
            (json) => json
                .map<Subscription>(
                    (subscription) => Subscription.fromJson(subscription))
                .toList());
    if (subscriptionsResponse.error == 1) {
      throw AppException(subscriptionsResponse.message);
    }
    return subscriptionsResponse.data;
  }
}

@riverpod
Future<AppResponse<ItemGroupDetails>> getAllItemGroupsSubscriptions(
    GetAllItemGroupsSubscriptionsRef ref) async {
  final warehouseId = ref.watch(localLocationInfoProvider).warehouseId;
  return ref
      .read(subscriptionsRepositoryProvider)
      .getAllItemGroupsSubscriptions(page: 1, warehouseId: warehouseId);
}

@riverpod
Future<List<Subscription>> activeSubscriptions(
    ActiveSubscriptionsRef ref) async {
  return ref.watch(subscriptionsRepositoryProvider).getActiveSubscriptions();
}
