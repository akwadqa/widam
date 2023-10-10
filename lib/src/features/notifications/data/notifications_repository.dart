import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/constants/services_urls.dart';
import 'package:widam/src/network/network_service.dart';

part 'notifications_repository.g.dart';

@riverpod
NotificationsRepository notificationsRepository(
    NotificationsRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  final newDio = Dio(dio.options.copyWith(baseUrl: ServicesUrls.domain));
  newDio.interceptors.addAll(dio.interceptors);

  final NetworkService networkService =
      ref.watch(networkServiceProvider(newDio));

  return NotificationsRepository(networkService);
}

class NotificationsRepository {
  final NetworkService _networkService;

  NotificationsRepository(this._networkService);

  Future<void> sendFCMToken(String token, String userId) async {
    final response = await _networkService.post(
        EndPoints.sendFcmToken, {'device_token': token, 'user_id': userId});

    final AppResponse appResponse =
        AppResponse.fromJson(response.data, (json) => null);

    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
  }
}
