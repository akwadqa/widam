import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/features/items/domain/item/item.dart';
import 'package:widam/src/network/network_service.dart';

part 'mubadara_items_repository.g.dart';

@Riverpod(keepAlive: true)
MubadaraItemsRepository mubadaraItemsRepository(
        MubadaraItemsRepositoryRef ref) =>
    MubadaraItemsRepository(ref.watch(networkServiceProvider()));

class MubadaraItemsRepository {
  final NetworkService _networkService;

  const MubadaraItemsRepository(this._networkService);

  Future<List<Item>> getMubadraItems({required String mubadaraId}) async {
    final Map<String, dynamic> queryParameters = {
      'mubadara_id': mubadaraId,
    };

    final response = await _networkService.get(EndPoints.mubadaraItems,
        queryParameters: queryParameters);
    AppResponse<List<Item>> itemDetailsResponse =
        AppResponse<List<Item>>.fromJson(response.data,
            (json) => json.map<Item>((e) => Item.fromJson(e)).toList());
    if (itemDetailsResponse.error == 1) {
      throw AppException(itemDetailsResponse.message);
    }
    return itemDetailsResponse.data;
  }
}

@riverpod
FutureOr<List<Item>> mubadaraItems(MubadaraItemsRef ref, String mubadaraId) =>
    ref
        .watch(mubadaraItemsRepositoryProvider)
        .getMubadraItems(mubadaraId: mubadaraId);
