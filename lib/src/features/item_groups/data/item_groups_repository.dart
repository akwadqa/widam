import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';
import '../domain/item_group_details/item_group_details.dart';
part 'item_groups_repository.g.dart';

@Riverpod(keepAlive: true)
ItemGroupsRepository itemGroupsRepository(ItemGroupsRepositoryRef ref) =>
    ItemGroupsRepository(ref.watch(networkServiceProvider()));

class ItemGroupsRepository {
  final NetworkService _networkService;

  ItemGroupsRepository(this._networkService);

  final _lock = Lock();

  Future<AppResponse<ItemGroupDetails>> getItemsByItemGroup(
      {String? itemGroupId,
      required int page,
      String? sortBy,
      String? sortOrder,
      String? searchQuery,
      String? barcode,
      String? parameters}) async {
    return await _lock.synchronized(() async {
      final queryParameters = {
        if(itemGroupId != null) 'item_group_id': itemGroupId,
        'page_no': page,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        if (searchQuery != null) 'website_item_name': searchQuery,
        if (barcode != null) 'barcode': barcode,
        if (sortBy == null &&
            sortOrder == null &&
            searchQuery == null &&
            barcode == null &&
            parameters != null)
          ..._parseQueryParamsString(parameters)
      };
      final response = await _networkService.get(EndPoints.itemGroups,
          queryParameters: queryParameters);
      AppResponse<ItemGroupDetails> itemGroupResponse =
          AppResponse<ItemGroupDetails>.fromJson(
              response.data, (json) => ItemGroupDetails.fromJson(json));
      if (itemGroupResponse.error == 1) {
        throw Exception(itemGroupResponse.message);
      }
      return itemGroupResponse;
    });
  }

  Map<String, String> _parseQueryParamsString(String queryParamsString) {
    List<String> queryParamsList = queryParamsString.split('&');
    Map<String, String> queryParamsMap = {};

    for (String param in queryParamsList) {
      List<String> keyValue = param.split('=');
      if (keyValue.length == 2) {
        queryParamsMap[keyValue[0]] = keyValue[1];
      }
    }

    return queryParamsMap;
  }
}

@riverpod
Future<AppResponse<ItemGroupDetails>> getAllItemGroups(
    GetAllItemGroupsRef ref) async {
  return ref.watch(itemGroupsRepositoryProvider).getItemsByItemGroup(page: 1);
}
