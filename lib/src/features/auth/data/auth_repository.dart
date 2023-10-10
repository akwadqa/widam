import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../constants/end_points.dart';
import '../domain/validation_otp_response.dart';
import '../../../network/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../domain/login_response.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(ref.watch(networkServiceProvider()));

class AuthRepository {
  final NetworkService _networkService;

  AuthRepository(this._networkService);

  Future<LoginResponse> login(String mobileNumber) async {
    final response = await _networkService
        .post(EndPoints.login, {'mobile_no': mobileNumber});
    final loginResponse = AppResponse<LoginResponse>.fromJson(
        response.data, (json) => LoginResponse.fromJson(json));
    if (loginResponse.error == 1) {
      throw AppException(loginResponse.message);
    }
    return loginResponse.data;
  }

  Future<ValidationOtpResponse> verifyOtp(
      String mobileNumber, String otp) async {
    final response = await _networkService
        .post(EndPoints.verifyOtp, {'mobile_no': mobileNumber, 'otp': otp});
    final validationOtpResponse = AppResponse<ValidationOtpResponse>.fromJson(
        response.data, (json) => ValidationOtpResponse.fromJson(json));
    if (validationOtpResponse.error == 1) {
      throw AppException(validationOtpResponse.message);
    }
    return validationOtpResponse.data;
  }
}
