import 'package:flutter/material.dart';
import 'package:widam/src/theme/app_colors.dart';

class AppAddingButton extends StatelessWidget {
  const AppAddingButton(
      {super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 43),
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.gray, width: 0.5),
          foregroundColor: AppColors.londonRain),
      child: Text('+ $title'),
    );
  }
}
