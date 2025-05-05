import 'package:freezed_annotation/freezed_annotation.dart';

import 'address/city.dart';
import 'delivery_center/delivery_center.dart';
import 'geofence.dart';

part 'default_address.freezed.dart';
part 'default_address.g.dart';

@freezed
class DefaultAddress with _$DefaultAddress {
  factory DefaultAddress({
    required String latitude,
    required String longitude,
    required City city,
    required Geofence geofence,
    required DeliveryCenter deliveryCenter
  }) = _DefaultAddress;

  factory DefaultAddress.fromJson(Map<String, dynamic> json) =>
      _$DefaultAddressFromJson(json);
}
