import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/account_repository.dart';
import '../../../profile/data/profile_repository.dart';

part 'edit_profile_controller.g.dart';

@riverpod
class EditProfileController extends _$EditProfileController {
  @override
  FutureOr<void> build() {}

  Future<void> editUserDetails(
      {String? title,
      String? firstName,
      String? lastName,
      String? email}) async {
    state = const AsyncValue.loading();
    try {
      final userDetails = await ref
          .watch(accountRepositoryProvider)
          .editUserDetails(
              title: title,
              firstName: firstName,
              lastName: lastName,
              email: email);
      ref.read(profileDetailsProvider.notifier).setProfileDetails(userDetails);
      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
