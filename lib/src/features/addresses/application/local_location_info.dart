import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../constants/keys.dart';

part 'local_location_info.g.dart';

typedef LocalLocationInfoRow = ({Coordinates coordinates, String? warehouseId});
typedef Coordinates = ({String? latitude, String? longitude});

@Riverpod(keepAlive: true)
class LocalLocationInfo extends _$LocalLocationInfo {
  @override
  LocalLocationInfoRow build() {
    final SharedPreferences sharedPreferences =
        ref.watch(sharedPreferencesProvider).requireValue;
    final latitude = sharedPreferences.getString(Keys.latitude);
    final longitude = sharedPreferences.getString(Keys.longitude);
    final warehouseId = sharedPreferences.getString(Keys.warehouseId);
    return (
      coordinates: (latitude: latitude, longitude: longitude),
      warehouseId: warehouseId
    );
  }

  Future<void> setLocalLocationInfo(String latitude, String longitude,
      [String? warehouseId]) async {
    SharedPreferences sharedPreferences =
        ref.read(sharedPreferencesProvider).requireValue;
    await sharedPreferences.setString(Keys.latitude, latitude);
    await sharedPreferences.setString(Keys.longitude, longitude);

    if (warehouseId != null) {
      await sharedPreferences.setString(Keys.warehouseId, warehouseId);
    }

    state = (
      coordinates: (latitude: latitude, longitude: longitude),
      warehouseId: warehouseId
    );
  }
}

@Riverpod(keepAlive: true)
class LocalGeofenceId extends _$LocalGeofenceId {
  @override
  String? build() {
    final SharedPreferences sharedPreferences =
        ref.watch(sharedPreferencesProvider).requireValue;
    final geofenceId = sharedPreferences.getString(Keys.geofenceId);
    return geofenceId;
  }

  Future<void> setLocalGeofenceIdWithoutUpdateState(String geofenceId) async {
    SharedPreferences sharedPreferences =
        ref.read(sharedPreferencesProvider).requireValue;
    await sharedPreferences.setString(Keys.geofenceId, geofenceId);
  }

  Future<void> setLocalGeofenceId(String geofenceId) async {
    await setLocalGeofenceIdWithoutUpdateState(geofenceId);
    state = geofenceId;
  }
}
