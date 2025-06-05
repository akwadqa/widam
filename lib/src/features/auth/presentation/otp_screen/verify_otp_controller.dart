import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'send_otp_controller.dart';

import '../../application/user_data_provider.dart';
import '../../data/auth_repository.dart';
import '../../domain/validation_otp_response.dart';

part 'verify_otp_controller.g.dart';

@riverpod
class VerifyOtpController extends _$VerifyOtpController {
  @override
  FutureOr<ValidationOtpResponse?> build() async => null;

  Future<void> verifyOtp(String otp) async {
    state = const AsyncValue.loading();
    try {
      final AuthRepository authRepository = ref.watch(authRepositoryProvider);
      final mobileNumber =
          ref.read(sendOtpControllerProvider).value!.mobileNumber;
      final appResponse = await authRepository.verifyOtp(mobileNumber, otp);
      final token = appResponse.token;
      final userId = appResponse.userId;
      final fullName = appResponse.fullName;
      if (token != null && userId != null && fullName != null) {
      await  ref
            .read(userDataProvider.notifier)
            .setUserData(token: token, id: userId, fullName: fullName);
      }
      state = AsyncValue.data(appResponse);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
