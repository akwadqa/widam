import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

/// Colors with opacity and shadows shared by the home header and cards.
abstract final class HomeDecorations {
  static final Color mutedText = AppColors.navyBlue.withValues(alpha: 0.78);
  static final Color frostedWhite = Colors.white.withValues(alpha: 0.82);
  static final Color whiteBorder = Colors.white.withValues(alpha: 0.95);

  /// Floating header card (delivery slot + address).
  static final List<BoxShadow> headerCardShadow = [
    BoxShadow(
      color: AppColors.navyBlue.withValues(alpha: 0.10),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Small header tiles (search field, language button).
  static final List<BoxShadow> headerTileShadow = [
    BoxShadow(
      color: AppColors.navyBlue.withValues(alpha: 0.10),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ];

  /// White content cards on the page (order tracking).
  static final List<BoxShadow> contentCardShadow = [
    BoxShadow(
      color: AppColors.navyBlue.withValues(alpha: 0.08),
      blurRadius: 22,
      offset: const Offset(0, 8),
    ),
  ];
}
