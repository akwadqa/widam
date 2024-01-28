import 'package:freezed_annotation/freezed_annotation.dart';

import '../geofence.dart';
import 'country.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@AddressConverter()
@freezed
class Address with _$Address {
  factory Address(
      {required String addressId,
      required String addressTitle,
      required String addressType,
      required String streetNo,
      required String? buildingNo,
      required String zone,
      required Country country,
      required String latitude,
      required String longitude,
      required int? preferredShippingAddress,
      required String? customerId,
      required String? customerFullname,
      required Geofence? geofence,
      required String phone,
      required String fullName,
      required String? landmark}) = _Address;

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
      'zone': address.zone,
      'building_no': address.buildingNo,
      'country': address.country.countryId,
      'latitude': address.latitude,
      'longitude': address.longitude,
      'phone': address.phone,
      'is_shipping_address': address.preferredShippingAddress,
      'full_name': address.fullName,
      'landmark': address.landmark
    };
  }

  @override
  Address fromJson(Map<String, dynamic> json) {
    return Address.fromJson(json);
  }
}
