import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';
import '../domain/location/location.dart';

part 'validate_coordinates_repository.g.dart';

@riverpod
ValidateCoordinatesRepository validateCoordinatesRepository(
        ValidateCoordinatesRepositoryRef ref) =>
    ValidateCoordinatesRepository(ref.watch(networkServiceProvider()));

class ValidateCoordinatesRepository {
  final NetworkService _networkService;

  const ValidateCoordinatesRepository(this._networkService);

  Future<Location> validateCoordinates(
      {double? latitude, double? longitude}) async {
    final queryParameters = {
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
    final response = await _networkService.get(EndPoints.validateCoordinates,
        queryParameters: queryParameters);

    AppResponse<Location> locationResponse = AppResponse<Location>.fromJson(
        response.data, (json) => Location.fromJson(json));
    if (locationResponse.error == 1) {
      throw AppException(locationResponse.message);
    }
    return locationResponse.data;
  }
}
