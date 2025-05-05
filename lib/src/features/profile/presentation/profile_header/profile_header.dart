import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../auth/application/user_data_provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/header_text.dart';
import '../../data/profile_repository.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 30),
        _HeaderText(),
      ]),
    );
  }
}

class _HeaderText extends ConsumerWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = ref.watch(userDataProvider);
    if (userToken != null) {
      final userDetailsAsync = ref.watch(profileDetailsProvider);
      if (userDetailsAsync is AsyncLoading) {
        return const FadeCircleLoadingIndicator();
      }
      if (userDetailsAsync is AsyncData) {
        return HeaderText(
            title:
                '${S.of(context).hello} ${userDetailsAsync.asData?.value.firstName}',
            subtitle: S.of(context).profileGreetingsDescription);
      }
      return _unauthenticatedHeaderText(context);
    }
    return _unauthenticatedHeaderText(context);
  }

  HeaderText _unauthenticatedHeaderText(BuildContext context) {
    return HeaderText(
        title: S.of(context).profileGreetings,
        subtitle: S.of(context).profileGreetingsDescription);
  }
}
