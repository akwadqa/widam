import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/network/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../domain/tag/tag.dart';

part 'tags_repository.g.dart';

@riverpod
TagsRepository tagsRepository(TagsRepositoryRef ref) =>
    TagsRepository(ref.watch(networkServiceProvider()));

class TagsRepository {
  final NetworkService _networkService;

  TagsRepository(this._networkService);

  Future<List<Tag>> getTags() async {
    final response = await _networkService.get(EndPoints.tags);
    final tagsResponse = AppResponse<List<Tag>>.fromJson(response.data,
        (json) => json.map<Tag>((tag) => Tag.fromJson(tag)).toList());
    if (tagsResponse.error == 1) {
      throw AppException(tagsResponse.message);
    }
    return tagsResponse.data;
  }
}

@riverpod
FutureOr<List<Tag>> tags(TagsRef ref) {
  return ref.watch(tagsRepositoryProvider).getTags();
}
