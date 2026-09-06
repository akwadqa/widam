import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/presentation/items_grid.dart';
import '../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../common_widgets/banner/app_banner.dart';
import '../../../common_widgets/app_pagination_widget.dart';
import '../../item_groups/presentation/barcode_widget/barcode_controller.dart';
import '../../item_groups/presentation/item_groups_body/filters_drop_down/filters_controller.dart';
import '../../item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';
import '../../item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_controller.dart';
import '../../item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';
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
        showAppBannerDialog(
          context,
          paginationError.error.toString(),
          paginationError.stackTrace,
        );
      }
    });
    final state = ref.watch(itemGroupItemsControllerProvider);
    // Dynamic key to reset pagination whenever category/filter/search changes
    final mainGroupId = ref.watch(selectedItemGroupControllerProvider);
    final subGroupId = ref.watch(selectedSubItemGroupControllerProvider);
    final filter = ref.watch(selectedFilterControllerProvider);
    final search = ref.watch(itemGroupsSearchControllerProvider);
    final barcode = ref.watch(barcodeControllerProvider);

    final widgetKey =
        ValueKey('$mainGroupId-$subGroupId-$filter-$search-$barcode');

    return state.when(
      loading: () => const FadeCircleLoadingIndicator(),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: AppBanner(
          message: error.toString(),
          stackTrace: stackTrace,
        ),
      ),
      data: (data) {
        if (data.items.isEmpty) {
          return Center(
            child: Text(S.of(context).noProductsMatchingYourSelection),
          );
        }

        return AppPaginationWidget(
          key:
              widgetKey, // Forces a fresh pagination widget when selection changes

          onLoading:
              ref.read(itemGroupItemsControllerProvider.notifier).onLoading,
          enablePullDown: true,
          onRefresh: () =>
              ref.read(itemGroupItemsControllerProvider.notifier).onRefresh(),
          child: ItemsGrid(
            items: data.items,
            childAspectRatio: childAspectRatio,
          ),
        );
      },
    );
  }
}
