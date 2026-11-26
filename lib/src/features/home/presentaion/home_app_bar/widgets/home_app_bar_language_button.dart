import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';
import '../home_app_bar_controller.dart';
import 'home_app_bar_tile.dart';

/// Globe button that switches the app to the other language. Its label shows
/// the language it switches to (`EN` in Arabic, `عربي` in English).
class HomeAppBarLanguageButton extends ConsumerWidget {
  const HomeAppBarLanguageButton({super.key});

  static const double _letterSpacing = 0.5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return HomeAppBarTile(
      width: HomeAppBarTile.height,
      semanticLabel: s.language,
      onTap: () =>
          ref.read(homeAppBarControllerProvider.notifier).switchLanguage(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.language, size: 18, color: AppColors.navyBlue),
          const SizedBox(height: 2),
          Text(
            s.homeSwitchLanguage,
            maxLines: 1,
            style: AppTextStyles.bold11.copyWith(
              color: AppColors.navyBlue,
              letterSpacing: _letterSpacing,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
