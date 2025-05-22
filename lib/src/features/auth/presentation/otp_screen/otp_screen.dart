import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:widam/src/theme/app_theme.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/header_text.dart';
import 'send_otp_controller.dart';
import 'verify_otp_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/submit_button.dart';
import '../../../../utils/utils.dart';
import '../../../../common_widgets/app_close_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  late final SmsRetrieverImpl smsRetrieverImpl;

  @override
  void initState() {
    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text(S.of(context).verificationCode,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black)))),
                  const Expanded(child: AppCloseButton())
                ],
              ),
              const SizedBox(height: 30),
              HeaderText(
                  title: S.of(context).otpHeaderTitle,
                  subtitle: S.of(context).otpHeaderDes),
              const SizedBox(height: 30),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  smsRetriever: smsRetrieverImpl,
                  defaultPinTheme:
                      _createPinTheme(Colors.white, AppColors.antiFlashWhite),
                  focusedPinTheme:
                      _createPinTheme(AppColors.blue, AppColors.secondary),
                  validator: qValidator([
                    IsRequired(S.of(context).required),
                    MinLength(6, S.of(context).otpMinLength)
                  ]),
                  onCompleted: (value) => _otp = value,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ArabicNumberInputFormatter(),
                  ],
                  errorTextStyle: const TextStyle(
                      color: AppColors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Text(S.of(context).dontReceiveTheCode,
                  style: const TextStyle(
                      color: AppColors.gray,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 3),
              Consumer(builder: (context, ref, child) {
                final asyncValue = ref.watch(sendOtpControllerProvider);

                return asyncValue.when(
                    data: (data) => Column(
                          children: [
                            Countdown(
                              seconds: data?.allowLoginAfter.toInt() ?? 0,
                              build: (BuildContext context, double time) =>
                                  Column(
                                children: [
                                  Text(time.toString(),
                                      style: const TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 10),
                                  _ResendCodeButton(
                                    onPressed: time != 0
                                        ? null
                                        : ref
                                            .read(sendOtpControllerProvider
                                                .notifier)
                                            .resendOtp,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                text: '${S.of(context).youHave} ',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: '${data?.remainingAttempts ?? 0}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${S.of(context).attemptsLeft}',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                    error: (error, stackTrace) => AppBanner(
                        message: error.toString(), stackTrace: stackTrace),
                    loading: () => const FadeCircleLoadingIndicator());
              }),
              const SizedBox(height: 30),
              Consumer(builder: (context, ref, child) {
                ref.listen(verifyOtpControllerProvider, (previous, next) {
                  if (next is AsyncData && next.value != null) {
                    if (next.value?.validation.userExist == true) {
                      context.maybePop(true);
                    } else {
                      context.maybePop(false);
                    }
                  } else if (next is AsyncError) {
                    showAppBannerDialog(
                        context, next.error.toString(), next.stackTrace);
                  }
                });
                final asyncValue = ref.watch(verifyOtpControllerProvider);
                return asyncValue.isLoading
                    ? const FadeCircleLoadingIndicator()
                    : SubmitButton(
                        text: S.of(context).verify,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(verifyOtpControllerProvider.notifier)
                                .verifyOtp(_otp!);
                          }
                        });
              })
            ],
          ),
        ),
      ),
    );
  }

  PinTheme _createPinTheme(Color backgroundColor, Color borderColor) {
    return PinTheme(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 1,
              offset: const Offset(0, 1))
        ],
      ),
      width: 36,
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      textStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkBlue),
    );
  }
}

class _ResendCodeButton extends ConsumerWidget {
  const _ResendCodeButton({
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: TextStyle(
              fontFamily: fontFamily, decoration: TextDecoration.underline),
        ),
        child: Text(S.of(context).resendMyCode));
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsCode();
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
