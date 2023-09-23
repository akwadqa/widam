import 'package:freezed_annotation/freezed_annotation.dart';

import '../geofence.dart';
import 'area.dart';
import 'city.dart';
import 'country.dart';
import 'zone.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@AddressConverter()
@freezed
class Address with _$Address {
  factory Address({
    required String addressId,
    required String addressTitle,
    required String addressType,
    required String streetNo,
    required String buildingNo,
    required City city,
    required Zone zone,
    required Area area,
    required Country country,
    required String latitude,
    required String longitude,
    required int? preferredShippingAddress,
    required String? customerId,
    required String? customerFullname,
    required Geofence? geofence,
    required String phone,
    required String fullName,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

class AddressConverter implements JsonConverter<Address, Map<String, dynamic>> {
  const AddressConverter();

  @override
  Map<String, dynamic> toJson(Address address, [bool isUpdate = false]) {
    return {
      if (isUpdate) 'address_id': address.addressId,
      'address_title': address.addressTitle,
      'address_type': address.addressType,
      'street_no': address.streetNo,
      'building_no': address.buildingNo,
      'city': address.city.cityId,
      'zone': address.zone.zoneId,
      'area': address.area.areaId,
      'country': address.country.countryId,
      'latitude': address.latitude,
      'longitude': address.longitude,
      'phone': address.phone,
      'is_shipping_address': address.preferredShippingAddress,
      'full_name': address.fullName,
    };
  }

  @override
  Address fromJson(Map<String, dynamic> json) {
    return Address.fromJson(json);
  }
}
