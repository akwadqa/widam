import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_colors.dart';
import 'home_app_bar_language_button.dart';
import 'home_app_bar_search_field.dart';

/// Logo, search field and language button.
class HomeAppBarSearchRow extends StatelessWidget {
  const HomeAppBarSearchRow({super.key});

  static const double _logoHeight = 38;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 4),
          child: Assets.images.widamLogo.svg(
            height: _logoHeight,
            colorFilter:
                const ColorFilter.mode(AppColors.navyBlue, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(child: HomeAppBarSearchField()),
        const SizedBox(width: 8),
        const HomeAppBarLanguageButton(),
      ],
    );
  }
}
