import 'package:freezed_annotation/freezed_annotation.dart';

part 'geofence.freezed.dart';
part 'geofence.g.dart';

@freezed
class Geofence with _$Geofence {
  factory Geofence({
    required String geofenceId,
    required String geofenceName,
  }) = _Geofence;

  factory Geofence.fromJson(Map<String, dynamic> json) =>
      _$GeofenceFromJson(json);
}
