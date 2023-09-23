import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../item_details_controller.dart';
import 'item_details_content.dart';

class ItemDetailsBody extends ConsumerWidget {
  const ItemDetailsBody({Key? key, this.attributionToken}) : super(key: key);
  final String? attributionToken;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemDetailsDataAsync = ref.watch(itemDetailsControllerProvider);
    return itemDetailsDataAsync.when(
        data: (data) {
          if (data == null) {
            return const SizedBox.shrink();
          }
          return ItemDetailsContent(
              itemDetails: data.itemDetails, isLoading: data.isLoading);
        },
        error: (error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: AppBanner(
                    message: error.toString(), stackTrace: stackTrace)),
          );
        },
        loading: () => const Center(child: FadeCircleLoadingIndicator()));
  }
}
