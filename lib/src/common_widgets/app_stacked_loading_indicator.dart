import 'package:flutter/material.dart';

import 'fade_circle_loading_indicator.dart';

class AppStackedLoadingIndicator extends StatelessWidget {
  const AppStackedLoadingIndicator(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: const FadeCircleLoadingIndicator(),
            ),
          )
        ],
      );
    }
    return child;
  }
}
