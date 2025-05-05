import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/network/network_service.dart';

part 'user_language_repository.g.dart';

@riverpod
UserLangaugeRepository userLangaugeRepository(UserLangaugeRepositoryRef ref) =>
    UserLangaugeRepository(ref.watch(networkServiceProvider()));

class UserLangaugeRepository {
  final NetworkService _networkService;

  UserLangaugeRepository(this._networkService);

  Future<void> changeUserLanguage(String languageCode) async {
    final formData = FormData.fromMap({'language': languageCode});
    final response =
        await _networkService.put(EndPoints.userLanguage, formData);
    AppResponse appResponse =
        AppResponse.fromJson(response.data, (json) => null);
    return appResponse.data;
  }
}
