import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../form_fields/email_form_field.dart';
import '../form_fields/first_name_form_field.dart';
import '../form_fields/last_name_form_field.dart';
import 'register_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/submit_button.dart';
import '../../../../common_widgets/app_header.dart';
import '../../../../common_widgets/header_text.dart';
import '../form_fields/title_radios_form_field.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.mobileNumber});

  final String mobileNumber;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _firstName;
  String? _lastName;
  String? _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppHeader(),
                      const SizedBox(height: 30),
                      HeaderText(
                          title: S.of(context).newAccount,
                          subtitle: S.of(context).newAccountDesc),
                      const SizedBox(height: 8),
                      Text(widget.mobileNumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary)),
                      const SizedBox(height: 16),
                      TitleRadiosFormField(
                          onSaved: (value) => _title = value,
                          initialValue: 'Mr',
                          context: context),
                      const SizedBox(height: 50),
                      FirstNameFormField(
                          onSaved: (value) => _firstName = value),
                      const SizedBox(height: 20),
                      LastNameFormField(onSaved: (value) => _lastName = value),
                      const SizedBox(height: 20),
                      EmailFormField(onSaved: (value) => _email = value),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _CheckBoxFormField(
                              validator: (value) => value == false
                                  ? S.of(context).required
                                  : null),
                          Text(S.of(context).termAndConditionsPrefix,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          TextButton(
                              onPressed: () => context.pushRoute(
                                  TermsConditionsAndPrivacyPolicyScreen()),
                              child: Text(S.of(context).termsAndConditions,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      color: AppColors.darkBlue,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
                return Positioned(
                  bottom:
                      isKeyboardVisible ? 5 : 30 + getBottomPadding(context),
                  left: 0,
                  right: 0,
                  child: Consumer(builder: (context, ref, child) {
                    ref.listen(registerControllerProvider, (previous, next) {
                      if (next is AsyncError) {
                        showAppBannerDialog(
                            context, next.error.toString(), next.stackTrace);
                      } else if (next is AsyncData && next.value != null) {
                        context.router.popUntilRoot();
                      }
                    });
                    final asyncValue = ref.watch(registerControllerProvider);
                    return asyncValue.isLoading
                        ? const FadeCircleLoadingIndicator()
                        : SubmitButton(
                            text: S.of(context).confirm,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ref
                                    .read(registerControllerProvider.notifier)
                                    .register(
                                      title: _title!,
                                      firstName: _firstName!,
                                      lastName: _lastName!,
                                      email: _email!,
                                      mobileNumber: widget.mobileNumber,
                                    );
                              }
                            });
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckBoxFormField extends FormField<bool> {
  _CheckBoxFormField({super.validator})
      : super(
          initialValue: true,
          builder: (FormFieldState<bool> field) {
            return Column(
              children: [
                Checkbox(
                  value: field.value,
                  onChanged: (value) => field.didChange(value),
                ),
                if (field.hasError)
                  Text(field.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            );
          },
        );
}
