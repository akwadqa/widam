import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/theme/app_theme.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/submit_button.dart';
import '../form_fields/email_form_field.dart';
import '../form_fields/last_name_form_field.dart';
import '../../../auth/application/user_data_provider.dart';
import '../../../profile/domain/user_details/user_details.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/app_header.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/header_text.dart';
import '../../../../theme/app_colors.dart';
import '../form_fields/first_name_form_field.dart';
import '../form_fields/title_radios_form_field.dart';
import 'edit_profile_controller.dart';

@RoutePage()
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.userDetails});
  final UserDetails userDetails;
  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppHeader(),
                      const SizedBox(height: 30),
                      HeaderText(
                          title: S.of(context).editProfile,
                          subtitle: S.of(context).editProfileDesc),
                      const SizedBox(height: 8),
                      Text(widget.userDetails.mobileNo,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray)),
                      const SizedBox(height: 16),
                      TitleRadiosFormField(
                          onSaved: (value) => _title = value,
                          initialValue: widget.userDetails.salutation,
                          context: context),
                      const SizedBox(height: 30),
                      FirstNameFormField(
                          initialValue: widget.userDetails.firstName,
                          onSaved: (value) => _firstName = value),
                      const SizedBox(height: 20),
                      LastNameFormField(
                          initialValue: widget.userDetails.lastName,
                          onSaved: (value) => _lastName = value),
                      const SizedBox(height: 20),
                      EmailFormField(
                          initialValue: widget.userDetails.email,
                          onSaved: (value) => _email = value),
                      const SizedBox(height: 30),
                      Text(S.of(context).accountDeletion,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const SizedBox(height: 8),
                      Text(S.of(context).accountDeletionDesc,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.gray)),
                      const _DeleteAccountButton(),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return Positioned(
                bottom: isKeyboardVisible ? 5 : 30 + getBottomPadding(context),
                left: 0,
                right: 0,
                child: Consumer(
                  builder: (context, ref, child) {
                    ref.listen(editProfileControllerProvider, (previous, next) {
                      if (next.hasError) {
                        showAppBannerDialog(
                            context, next.error.toString(), next.stackTrace);
                      }
                      if (next is AsyncData) {
                        context.popRoute();
                      }
                    });
                    final editProfileController =
                        ref.watch(editProfileControllerProvider);
                    if (editProfileController.isLoading) {
                      return const FadeCircleLoadingIndicator();
                    }
                    return SubmitButton(
                        text: S.of(context).confirm,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ref
                                .read(editProfileControllerProvider.notifier)
                                .editUserDetails(
                                    title: _title,
                                    firstName: _firstName,
                                    lastName: _lastName,
                                    email: _email);
                          }
                        });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends ConsumerWidget {
  const _DeleteAccountButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return TextButton(
      onPressed: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
              title: Text(S.of(context).areYouSure),
              actions: [
                TextButton(
                    onPressed: context.popRoute, child: Text(S.of(context).no)),
                TextButton(
                    child: Text(S.of(context).yes),
                    onPressed: () {
                      ref.read(userDataProvider.notifier).removeUserData();
                      context.router.popUntilRoot();
                    })
              ]),
        );
      },
      style: TextButton.styleFrom(
          foregroundColor: AppColors.carminePink,
          textStyle:
              TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily),
          padding: const EdgeInsetsDirectional.only(start: 0)),
      child: Text(S.of(context).deleteYourAccount),
    );
  }
}
