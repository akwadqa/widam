import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';
import '../../profile/domain/user_details/user_details.dart';

part 'account_repository.g.dart';

@riverpod
AccountRepository accountRepository(AccountRepositoryRef ref) =>
    AccountRepository(ref.watch(networkServiceProvider()));

class AccountRepository {
  final NetworkService _networkService;

  AccountRepository(this._networkService);

  Future<({String token, String id, String fullName})> register(
      {required String mobileNumber,
      required String title,
      required String firstName,
      required String lastName,
      String? email}) async {
    final response = await _networkService.post(EndPoints.register, {
      'mobile_no': mobileNumber,
      'salutation': title,
      'first_name': firstName,
      'last_name': lastName,
      if (email != null) 'email': email
    });
    final appResponse =
        AppResponse<({String token, String id, String fullName})>.fromJson(
            response.data,
            (json) => (
                  token: json['token'],
                  id: json['user_id'],
                  fullName:
                      '${json['profile_details']['first_name']} ${json['profile_details']['last_name']}'
                ));
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }

  Future<UserDetails> editUserDetails(
      {String? title,
      String? firstName,
      String? lastName,
      String? email}) async {
    final response = await _networkService.put(EndPoints.users, {
      if (title != null) 'salutation': title,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
    });
    final appResponse = AppResponse<UserDetails>.fromJson(
        response.data, (json) => UserDetails.fromJson(json));
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }
}
