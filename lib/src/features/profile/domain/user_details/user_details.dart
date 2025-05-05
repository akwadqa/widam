import 'package:freezed_annotation/freezed_annotation.dart';
import 'nationality/nationality.dart';

part 'user_details.freezed.dart';
part 'user_details.g.dart';

@freezed
class UserDetails with _$UserDetails {
  factory UserDetails({
    required String mobileNo,
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required Nationality? nationality,
  }) = _UserDetails;

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
}
