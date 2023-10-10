import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common_models/response/app_response.dart';
import '../../app_data/application/app_data_controller.dart';
import '../../../network/network_service.dart';
import '../../../constants/end_points.dart';
import '../../items/domain/item/item.dart';
import '../../layouts/domain/block.dart';
import '../../layouts/domain/layout.dart';
part 'layouts_repository.g.dart';

enum LayoutType { home, featured }

@Riverpod(keepAlive: true)
LayoutsRepository layoutsRepository(LayoutsRepositoryRef ref) =>
    LayoutsRepository(ref.watch(networkServiceProvider()));

class LayoutsRepository {
  final NetworkService _networkService;

  const LayoutsRepository(this._networkService);

  Future<Layout> getLayout(
      {String? layoutId, String? sortBy, String? sortOrder}) async {
    final Map<String, dynamic> queryParameters = {
      if (layoutId != null) 'layout_id': layoutId,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder
    };
    final response = await _networkService.get(EndPoints.layouts,
        queryParameters: queryParameters);
    AppResponse<Layout> layoutResponse =
        AppResponse.fromJson(response.data, (json) => Layout.fromJson(json));
    if (layoutResponse.error == 1) {
      throw AppException(layoutResponse.message);
    }
    return layoutResponse.data;
  }

  Future<Block<List<Item>>> getBlock({required String blockId}) async {
    final Map<String, dynamic> queryParameters = {
      'block_id': blockId,
    };
    final response = await _networkService.get(EndPoints.blocks,
        queryParameters: queryParameters);
    AppResponse<Block<List<Item>>> blockResponse =
        AppResponse<Block<List<Item>>>.fromJson(
            response.data,
            (json) => Block<List<Item>>.fromJson(
                json,
                (json) =>
                    (json as List).map((e) => Item.fromJson(e)).toList()));
    if (blockResponse.error == 1) {
      throw AppException(blockResponse.message);
    }
    return blockResponse.data;
  }
}

@Riverpod(keepAlive: true)
Future<Layout> layout(LayoutRef ref, LayoutType type,
    {String? sortBy, String? sortOrder}) async {
  final repository = ref.watch(layoutsRepositoryProvider);
  final appData = await ref.watch(appDataControllerProvider.future);
  return repository.getLayout(
      layoutId:
          type == LayoutType.home ? appData.homeLayout : appData.featuredLayout,
      sortBy: sortBy,
      sortOrder: sortOrder);
}

@Riverpod(keepAlive: true)
Future<Block<List<Item>>> block(BlockRef ref, {required String blockId}) async {
  final repository = ref.watch(layoutsRepositoryProvider);
  return repository.getBlock(blockId: blockId);
}
