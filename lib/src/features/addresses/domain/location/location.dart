import 'package:freezed_annotation/freezed_annotation.dart';

import '../default_address.dart';
import '../geofence.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required String? latitude,
    required String? longitude,
    @JsonKey(name: 'isValid') required bool? isValid,
    required String? message,
    required DefaultAddress defaultAddress,
    @JsonKey(name: 'matchedGeofence') required Geofence? matchedGeofence,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
