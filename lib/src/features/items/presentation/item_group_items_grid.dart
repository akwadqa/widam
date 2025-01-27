import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/presentation/items_grid.dart';
import '../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../common_widgets/banner/app_banner.dart';
import '../../../common_widgets/app_pagination_widget.dart';
import '../application/item_group_items_controller.dart';

class ItemGroupItemsGrid extends ConsumerWidget {
  const ItemGroupItemsGrid({super.key, this.childAspectRatio = 0.49});
  final double childAspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(itemGroupItemsControllerProvider, (previous, next) {
      if (next is AsyncData &&
          next.asData?.value is ItemGroupItemsLoaded &&
          (next.asData?.value as ItemGroupItemsLoaded).paginationError !=
              null) {
        final paginationError =
            (next.asData?.value as ItemGroupItemsLoaded).paginationError!;
        showAppBannerDialog(context, paginationError.error.toString(),
            paginationError.stackTrace);
      }
    });
    final state = ref.watch(itemGroupItemsControllerProvider);
    if (state is AsyncLoading) {
      return const FadeCircleLoadingIndicator();
    } else if (state is AsyncError) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: AppBanner(
            message: state.error.toString(), stackTrace: state.stackTrace),
      );
    }
    if (state.asData?.value is ItemGroupItemsLoading) {
      return const FadeCircleLoadingIndicator();
    } else if ((state.asData?.value as ItemGroupItemsLoaded).items.isEmpty) {
      return Center(child: Text(S.of(context).noProductsMatchingYourSelection));
    }
    final items = (state.asData?.value as ItemGroupItemsLoaded).items;
    return AppPaginationWidget(
      onLoading: ref.read(itemGroupItemsControllerProvider.notifier).onLoading,
      enableLoadingOnScrollStart: true,
      enablePullDown: true,
      onRefresh: ref.read(itemGroupItemsControllerProvider.notifier).onRefresh,
      child: ItemsGrid(items: items, childAspectRatio: childAspectRatio),
    );
  }
}
