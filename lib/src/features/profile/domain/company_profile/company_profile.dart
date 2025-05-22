import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_media_link.dart';

part 'company_profile.freezed.dart';
part 'company_profile.g.dart';

@freezed
class CompanyProfile with _$CompanyProfile {
  factory CompanyProfile({
    required String contactNumber,
    required String termsAndConditions,
    required List<SocialMediaLink> socialMediaLinks,
  }) = _CompanyProfile;

  factory CompanyProfile.fromJson(Map<String, dynamic> json) =>
      _$CompanyProfileFromJson(json);
}
