import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:widam/src/theme/app_colors.dart';

class AppStepProgressIndicator extends StatelessWidget {
  const AppStepProgressIndicator(
      {super.key, required this.totalSteps, required this.currentStep, this.size = 8});
  final int totalSteps;
  final int currentStep;
  final double size;
  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: totalSteps,
      currentStep: currentStep,
      size: size,
      padding: 0,
      selectedColor: AppColors.vividCerulean,
      unselectedColor: AppColors.pattensBlue,
      roundedEdges: const Radius.circular(4),
    );
  }
}
