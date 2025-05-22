import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/submit_button.dart';
import 'profile_buttons.dart';
import '../profile_settings/profile_settings.dart';
import '../reach_out_us/social_media_buttons.dart';
import '../version_name.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../generated/l10n.dart';
import '../../../auth/application/user_data_provider.dart';
import '../../data/profile_repository.dart';
import '../my_account/my_account.dart';
import '../profile_header/profile_header.dart';
import '../profile_title_container.dart';
import '../reach_out_us/reach_out_us.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 10),
            const _ProfileButton(),
            const SizedBox(height: 20),
            const ProfileButtons(),
            const MyAccount(),
            ProfileTitleContainer(title: S.of(context).settings),
            const ProfileSettings(),
            ProfileTitleContainer(title: S.of(context).reachOutToUs),
            const ReachOutUs(),
            Container(
              color: AppColors.cultured,
              child: Column(children: [
                const SizedBox(height: 30),
                const SizedBox(
                    height: 40, child: Center(child: SocialMediaButtons())),
                const SizedBox(height: 50),
                DefaultTextStyle.merge(
                  style: const TextStyle(
                      color: AppColors.philippineSilver,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Column(
                    children: [
                      const VersionName(),
                      const SizedBox(height: 3),
                      Text(
                        S.of(context).allRightsReserved,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileButton extends ConsumerWidget {
  const _ProfileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = ref.watch(userDataProvider);
    final userDetails = ref.watch(profileDetailsProvider).asData?.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SubmitButton(
          text: userToken != null
              ? S.of(context).editYourProfile
              : S.of(context).loginOrRegister,
          onPressed: () {
            if (userToken != null) {
              if (userDetails != null) {
                context.pushRoute(EditProfileScreen(userDetails: userDetails));
              }
            } else {
              context.pushRoute(const LoginScreen());
            }
          }),
    );
  }
}
