import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import 'app_close_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Assets.images.widamLogo.svg(), const AppCloseButton()],
    );
  }
}
