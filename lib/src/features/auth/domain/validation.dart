class Validation {
  final String mobileNumber;
  final bool userExist;
  final bool otpValid;

  Validation(
      {required this.mobileNumber,
      required this.userExist,
      required this.otpValid});

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
        mobileNumber: json['mobile_number'],
        userExist: json['user_exist'],
        otpValid: json['OTP_valid']);
  }
}
