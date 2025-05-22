class LoginResponse {
  final String mobileNumber;
  final int remainingAttempts;
  final num allowLoginAfter;

  LoginResponse(
      {required this.mobileNumber,
      required this.remainingAttempts,
      required this.allowLoginAfter});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      mobileNumber: json['mobile_number'],
      remainingAttempts: json['remaining_attempts'],
      allowLoginAfter: json['allow_login_after'],
    );
  }
}
