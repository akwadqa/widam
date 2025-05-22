import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_colors.dart';

final carouselPageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class CarouselDotsIndicator extends ConsumerWidget {
  const CarouselDotsIndicator({super.key, required this.dotsCount});
  final int dotsCount;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(carouselPageIndexProvider);
    return DotsIndicator(
      dotsCount: dotsCount,
      position: pageIndex,
      decorator: DotsDecorator(
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        color: AppColors.whisper,
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
