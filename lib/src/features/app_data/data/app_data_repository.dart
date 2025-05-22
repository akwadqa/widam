import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';
import '../domain/app_data/app_data.dart';

part 'app_data_repository.g.dart';

@Riverpod(keepAlive: true)
AppDataRepository appDataRepository(AppDataRepositoryRef ref) =>
    AppDataRepository(ref.watch(networkServiceProvider()));

class AppDataRepository {
  final NetworkService _networkService;

  const AppDataRepository(this._networkService);

  Future<AppData> getAppData(String geofenceId) async {
    final Map<String, dynamic> queryParameters = {
      'geofence_id': geofenceId,
    };
    final response = await _networkService.get(EndPoints.utilities,
        queryParameters: queryParameters);
    final AppResponse<AppData> appDataResponse =
        AppResponse.fromJson(response.data, (json) => AppData.fromJson(json));
    if (appDataResponse.error == 1) {
      throw AppException(appDataResponse.message);
    }
    return appDataResponse.data;
  }
}
