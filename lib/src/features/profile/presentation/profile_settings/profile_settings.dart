import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:widam/gen/fonts.gen.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../../../localization/current_language.dart';

import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const _LanguageListTile(),
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

class _LanguageListTile extends ConsumerWidget {
  const _LanguageListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(currentLanguageProvider, ((previous, next) {
      if (previous != next) {
        showDialog(
            context: context,
            builder: (_) => const FadeCircleLoadingIndicator(
                  color: Colors.white,
                ));

        Future.delayed(const Duration(seconds: 1), () {
          context.popRoute();
        });
      }
    }));
    return ListTile(
      title: Text(S.of(context).language),
      trailing: SizedBox(
        width: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(S.of(context).languageValue,
              style: TextStyle(
                  color: AppColors.darkBlue,
                  fontFamily: Intl.getCurrentLocale().contains('en')
                      ? FontFamily.qatar
                      : FontFamily.montserrat)),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_ios)
        ]),
      ),
      onTap: () => ref.read(currentLanguageProvider.notifier).changeLanguage(),
    );
  }
}
