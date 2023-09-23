import 'package:freezed_annotation/freezed_annotation.dart';

import 'delivery_method.dart';

part 'geofence_details.freezed.dart';
part 'geofence_details.g.dart';

@freezed
class GeofenceDetails with _$GeofenceDetails {
  factory GeofenceDetails({
    required String geofenceId,
    required String geofenceName,
    required List<DeliveryMethod> deliveryMethods,
  }) = _GeofenceDetails;

  factory GeofenceDetails.fromJson(Map<String, dynamic> json) =>
      _$GeofenceDetailsFromJson(json);
}
