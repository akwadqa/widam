import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/mobile_number_prefix.dart';
import '../../../../common_widgets/header_text.dart';
import '../../../../constants/strings.dart';
import '../otp_screen/otp_screen.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/submit_button.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../utils/utils.dart';
import '../../domain/login_response.dart';
import '../../../../common_widgets/app_header.dart';
import 'login_controller.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),
              const SizedBox(height: 30),
              HeaderText(
                  title: S.of(context).enterYourMobileNumber,
                  subtitle: S.of(context).loginDes),
              const SizedBox(height: 24),
              Directionality(
                textDirection: TextDirection.ltr,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: S.of(context).enterYourMobileNo,
                      filled: true,
                      fillColor: AppColors.lightGrayishCyan,
                      prefixIconConstraints:
                          const BoxConstraints(maxWidth: 100),
                      prefixIcon: const MobileNumberPrefix()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ArabicNumberInputFormatter(),
                  ],
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator: mobileNumberValidation(context),
                  onSaved: (value) =>
                      _mobile = '${Strings.qatarInternationalCodeNumber}$value',
                ),
              ),
              const Spacer(),
              Consumer(builder: (context, ref, child) {
                ref.listen(loginControllerProvider, (previous, next) async {
                  if (next is AsyncData<LoginResponse?> && next.value != null) {
                    final isUserExist = await showAdaptiveModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => const OtpScreen());
                    if (isUserExist != null) _handleOtpResult(isUserExist);
                  } else if (next is AsyncError) {
                    showAppBannerDialog(
                        context, next.error.toString(), next.stackTrace);
                  }
                });
                final state = ref.watch(loginControllerProvider);
                if (state is AsyncLoading) {
                  return const FadeCircleLoadingIndicator();
                }
                return SubmitButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ref
                            .read(loginControllerProvider.notifier)
                            .login(mobileNumber: _mobile!);
                      }
                    },
                    text: S.of(context).confirm);
              }),
              SizedBox(height: 30 + getBottomPadding(context)),
            ],
          ),
        ),
      ),
    ));
  }

  void _handleOtpResult(bool isUserExist) {
    if (isUserExist) {
      context.router.popUntilRoot();
    } else {
      context.replaceRoute(RegisterScreen(mobileNumber: _mobile!));
    }
  }
}