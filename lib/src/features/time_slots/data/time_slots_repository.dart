import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../addresses/application/geofence_id_controller.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../domain/geofence_details/geofence_details.dart';
import '../../../network/network_service.dart';

part 'time_slots_repository.g.dart';

@riverpod
TimeSlotsRepository timeSlotsRepository(TimeSlotsRepositoryRef ref) =>
    TimeSlotsRepository(ref.watch(networkServiceProvider()));

class TimeSlotsRepository {
  final NetworkService _networkService;
  TimeSlotsRepository(this._networkService);

  Future<GeofenceDetails> getGeofenceDetails(String geofenceId) async {
    final queryParameters = {'geofence_id': geofenceId};
    final response = await _networkService.get(EndPoints.geofence,
        queryParameters: queryParameters);
    AppResponse<GeofenceDetails> appResponse = AppResponse.fromJson(
        response.data, (json) => GeofenceDetails.fromJson(json));
    return appResponse.data;
  }
}

@riverpod
Future<GeofenceDetails> geofenceDetails(GeofenceDetailsRef ref) =>
    ref.watch(timeSlotsRepositoryProvider).getGeofenceDetails(
        ref.watch(geofenceIdAndCoordinatesProvider).geofenceId!);
