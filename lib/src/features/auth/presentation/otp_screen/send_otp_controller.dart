import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/auth_repository.dart';
import '../../domain/login_response.dart';
import '../login_screen/login_controller.dart';
part 'send_otp_controller.g.dart';

@riverpod
class SendOtpController extends _$SendOtpController {
  @override
  FutureOr<LoginResponse?> build() async {
    return (ref.watch(loginControllerProvider) as AsyncData).asData?.value;
  }

  Future<void> resendOtp() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.watch(authRepositoryProvider).login(state.value!.mobileNumber));
  }
}
