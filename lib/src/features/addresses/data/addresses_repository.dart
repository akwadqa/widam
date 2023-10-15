import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../domain/address/city.dart';
import '../../../network/network_service.dart';

import '../domain/address/address.dart';

part 'addresses_repository.g.dart';

@riverpod
AddressesRepository addressesRepository(AddressesRepositoryRef ref) =>
    AddressesRepository(ref.watch(networkServiceProvider()));

class AddressesRepository {
  final NetworkService _networkService;

  AddressesRepository(this._networkService);

  Future<List<Address>> getAddresses() async {
    final response = await _networkService.get(EndPoints.addresses);
    final AppResponse<List<Address>> appResponse = AppResponse.fromJson(
        response.data,
        (json) =>
            json.map<Address>((address) => Address.fromJson(address)).toList());
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }

  Future<Address> addAddress(Address address) async {
    AddressConverter addressConverter = const AddressConverter();
    final FormData formData =
        FormData.fromMap(addressConverter.toJson(address));
    final response = await _networkService.post(EndPoints.addresses, formData);
    return _handelResponse(response);
  }

  Future<Address> updateAddress(Address address) async {
    AddressConverter addressConverter = const AddressConverter();
    final FormData formData =
        FormData.fromMap(addressConverter.toJson(address, true));
    final response = await _networkService.put(EndPoints.addresses, formData);
    return _handelResponse(response);
  }

  Address _handelResponse(response) {
    final AppResponse<Address> appResponse =
        AppResponse.fromJson(response.data, (json) => Address.fromJson(json));
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }

  Future<String> deleteAddress(String addressId) async {
    final FormData formData = FormData.fromMap({'address_id': addressId});
    final response =
        await _networkService.delete(EndPoints.addresses, data: formData);
    final AppResponse<String> appResponse =
        AppResponse.fromJson(response.data, (json) => json);
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }
}
