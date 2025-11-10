import 'package:widam/src/features/auth/domain/customer_details.dart';

import 'validation.dart';

class ValidationOtpResponse {
  final Validation validation;
  final VerifyProfileDetails? verifyProfileDetails;
  final String? token;
  final String? userId;
  final String? fullName;

  ValidationOtpResponse(
      {required this.validation,
      required this.token,
      required this.verifyProfileDetails,
      required this.userId,
      required this.fullName});

  factory ValidationOtpResponse.fromJson(Map<String, dynamic> json) {
    return ValidationOtpResponse(
        validation: Validation.fromJson(json['validation']),
        
        verifyProfileDetails:json['profile_details']!=null? VerifyProfileDetails.fromJson(json['profile_details']):null,
        token: json['token'],
        userId: json['user_id'],
        fullName: json['profile_details'] != null
            ? '${json['profile_details']['first_name']} ${json['profile_details']['last_name']}'
            : null);
  }
}
