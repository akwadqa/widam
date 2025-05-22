import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../../../network/network_service.dart';
import '../domain/company_profile/company_profile.dart';
import '../domain/user_details/user_details.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) =>
    ProfileRepository(ref.watch(networkServiceProvider()));

class ProfileRepository {
  final NetworkService _networkService;

  ProfileRepository(this._networkService);

  Future<UserDetails> getProfile() async {
    final response = await _networkService.get(EndPoints.users);
    AppResponse<UserDetails> profileResponse = AppResponse.fromJson(
        response.data, (json) => UserDetails.fromJson(json));
    if (profileResponse.error == 1) {
      throw AppException(profileResponse.message);
    }
    return profileResponse.data;
  }

  Future<CompanyProfile> getCompanyProfile() async {
    final response = await _networkService.get(EndPoints.companyProfile);
    AppResponse<CompanyProfile> companyProfileResponse = AppResponse.fromJson(
        response.data, (json) => CompanyProfile.fromJson(json));
    if (companyProfileResponse.error == 1) {
      throw AppException(companyProfileResponse.message);
    }
    return companyProfileResponse.data;
  }
}

@riverpod
class ProfileDetails extends _$ProfileDetails {
  @override
  FutureOr<UserDetails> build() {
    return ref.watch(profileRepositoryProvider).getProfile();
  }

  void setProfileDetails(UserDetails userDetails) {
    state = AsyncValue.data(userDetails);
  }
}

@riverpod
FutureOr<CompanyProfile> companyProfile(CompanyProfileRef ref) {
  return ref.watch(profileRepositoryProvider).getCompanyProfile();
}
