import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:widam/src/features/user_language/presentation/language_list_tile.dart';
import '../../../../../generated/l10n.dart';

import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const LanguageListTile(),
        const Divider(),
        ListTile(
          title: Text(S.of(context).notification),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => context.pushRoute(const NotificationsSettingsScreen()),
        ),
        const Divider(),
        ListTile(
          title: Text(S.of(context).country),
          trailing: Text(S.of(context).qatar,
              style: const TextStyle(color: AppColors.darkBlue)),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
