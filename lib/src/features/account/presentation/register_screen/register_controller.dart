import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/account_repository.dart';

import '../../../auth/application/user_data_provider.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<({String token, String id, String fullName})?> build() async => null;

  Future<void> register(
      {required String mobileNumber,
      required String title,
      required String firstName,
      required String lastName,
      String? email}) async {
    state = const AsyncValue.loading();
    try {
      final AccountRepository authRepository =
          ref.watch(accountRepositoryProvider);
      final userData = await authRepository.register(
          mobileNumber: mobileNumber,
          title: title,
          firstName: firstName,
          lastName: lastName,
          email: email);
      ref.read(userDataProvider.notifier).setUserData(
          token: userData.token, id: userData.id, fullName: userData.fullName);
      state = AsyncValue.data(userData);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
