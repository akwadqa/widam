import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:widam/gen/fonts.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/features/user_language/presentation/user_language_controller.dart';
import 'package:widam/src/theme/app_colors.dart';

class LanguageListTile extends ConsumerWidget {
  const LanguageListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userLanguageControllerProvider, ((previous, next) {
      if (next is AsyncLoading) {
        showDialog(
            context: context,
            builder: (_) => const FadeCircleLoadingIndicator(
                  color: Colors.white,
                ));
      } else {
        context.maybePop().then((value) {
          if (next is AsyncError) {
            showAppBannerDialog(
                context, next.error.toString(), next.stackTrace);
          }
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
      onTap:(){
          ref.read(userLanguageControllerProvider.notifier).changeUserLanguage();
          ref.invalidate(layoutProvider(LayoutType.home));
          ref.invalidate(layoutProvider(LayoutType.featured));
}    );
  }
}
