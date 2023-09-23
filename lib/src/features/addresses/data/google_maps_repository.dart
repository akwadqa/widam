import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/end_points.dart';
import '../../../constants/keys.dart';
import '../../../constants/services_urls.dart';
import '../../../network/network_service.dart';
import '../domain/place/place.dart';

part 'google_maps_repository.g.dart';

@riverpod
GoogleMapsRepository googleMapsRepository(GoogleMapsRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  final newDio =
      Dio(dio.options.copyWith(baseUrl: ServicesUrls.googleMapsBaseUrl));
  newDio.interceptors.addAll(dio.interceptors);

  final NetworkService networkService =
      ref.watch(networkServiceProvider(newDio));
  return GoogleMapsRepository(networkService);
}

class GoogleMapsRepository {
  final NetworkService _networkService;

  const GoogleMapsRepository(this._networkService);

  Future<List<Place>> autoComplete(String input, String sessionToken) async {
    final queryParameters = {
      'input': input,
      'key': Keys.googleAPIKey,
      'sessiontoken': sessionToken
    };
    final response = await _networkService.get(EndPoints.googleMapsAutoComplete,
        queryParameters: queryParameters);
    final status = response.data['status'];
    if (status != 'OK') {
      throw Exception(status);
    }
    final predictions = response.data['predictions'] as List<dynamic>;
    final places =
        predictions.map<Place>((json) => Place.fromJson(json)).toList();
    return places;
  }
}

@riverpod
Future<List<Place>> autoComplete(
    AutoCompleteRef ref, String input, String sessionToken) async {
  final repository = ref.watch(googleMapsRepositoryProvider);
  return repository.autoComplete(input, sessionToken);
}
