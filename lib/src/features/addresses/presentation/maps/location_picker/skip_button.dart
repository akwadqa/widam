import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_theme.dart';
import '../validate_coordinates_banner/validate_coordinates_notifier.dart';

class SkipButton extends ConsumerWidget {
  const SkipButton({super.key, this.withDefaultLocation = false});
  final bool withDefaultLocation;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(validateCoordinatesProvider);
    if (state is ValidateCoordinatesLoading &&
        state.loadingType == LoadingType.skip) {
      return const FadeCircleLoadingIndicator();
    }
    final fontFamily = ref.watch(fontFamilyProvider);
    return ElevatedButton(
      onPressed: withDefaultLocation
          ? () => ref
              .read(validateCoordinatesProvider.notifier)
              .validateCoordinates(loadingType: LoadingType.skip)
          : context.maybePop,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.red,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: fontFamily,
          ),
          side: const BorderSide(color: AppColors.red)),
      child: Text(S.of(context).skip),
    );
  }
}
