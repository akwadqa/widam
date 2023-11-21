import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../constants/keys.dart';

part 'geofence_id_controller.g.dart';

typedef GeofenceIdAndCoordinatesRow = ({
  String? geofenceId,
  Coordinates coordinates
});
typedef Coordinates = ({String? latitude, String? longitude});

@Riverpod(keepAlive: true)
class GeofenceIdAndCoordinates extends _$GeofenceIdAndCoordinates {
  @override
  GeofenceIdAndCoordinatesRow build() {
    final SharedPreferences sharedPreferences =
        ref.watch(sharedPreferencesProvider).requireValue;
    final geofenceId = sharedPreferences.getString(Keys.geofenceId);
    final latitude = sharedPreferences.getString(Keys.latitude);
    final longitude = sharedPreferences.getString(Keys.longitude);
    return (
      geofenceId: geofenceId,
      coordinates: (latitude: latitude, longitude: longitude)
    );
  }

  void setGeofenceIdAndCoordinates(
      String geofenceId, String latitude, String longitude) {
    SharedPreferences sharedPreferences =
        ref.read(sharedPreferencesProvider).requireValue;
    sharedPreferences.setString(Keys.geofenceId, geofenceId);
    sharedPreferences.setString(Keys.latitude, latitude);
    sharedPreferences.setString(Keys.longitude, longitude);
    state = (
      geofenceId: geofenceId,
      coordinates: (latitude: latitude, longitude: longitude)
    );
  }
}
