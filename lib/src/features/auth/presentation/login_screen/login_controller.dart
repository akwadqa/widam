import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/auth_repository.dart';
import '../../domain/login_response.dart';
part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<LoginResponse?> build() => null;

  Future<void> login({required String mobileNumber}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.watch(authRepositoryProvider).login(mobileNumber));
  }
}
