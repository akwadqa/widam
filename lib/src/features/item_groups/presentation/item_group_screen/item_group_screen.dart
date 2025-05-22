import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/filters_drop_down/filters_drop_down_button_form_field.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_field.dart';
import 'package:widam/src/features/main/presentation/main_screen/app_bottom_navigation_bar.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../../common_widgets/address_and_delivery_widget.dart';
import '../../../../utils/utils.dart';
import '../../../items/presentation/item_group_items_grid.dart';
import '../../../main/presentation/item_details_sheet_controller.dart';
import '../item_groups_body/sub_item_groups_list/sub_item_groups_list.dart';

@RoutePage()
class ItemGroupScreen extends ConsumerStatefulWidget {
  const ItemGroupScreen(
      {super.key, this.autoFocus = false, required this.itemGroupId});
  final bool autoFocus;
  final String itemGroupId;

  @override
  ConsumerState<ItemGroupScreen> createState() => _ItemGroupScreenState();
}

class _ItemGroupScreenState extends ConsumerState<ItemGroupScreen> {
  @override
  void initState() {
    Future(() {
      ref
          .read(selectedItemGroupControllerProvider.notifier)
          .onCategorySelected(widget.itemGroupId);
    });
    StatusBarControl.setStyle(StatusBarStyle.DARK_CONTENT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding =
        ref.watch(topPaddingProvider(MediaQuery.paddingOf(context).top));
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: topPadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: AddressAndDeliveryWidget(),
          ),
          Expanded(
            child: ProviderScope(overrides: [
              itemDetailsSheetControllerProvider
                  .overrideWith(() => ItemDetailsSheetController())
            ], child: _ItemGroupsBody(autoFocus: widget.autoFocus)),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            context.maybePop(index);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    StatusBarControl.setStyle(StatusBarStyle.LIGHT_CONTENT);
    super.dispose();
  }
}

class _ItemGroupsBody extends ConsumerStatefulWidget {
  const _ItemGroupsBody({this.autoFocus = false});
  final bool autoFocus;
  @override
  ConsumerState<_ItemGroupsBody> createState() => _ItemGroupsBodyState();
}

class _ItemGroupsBodyState extends ConsumerState<_ItemGroupsBody> {
  @override
  Widget build(BuildContext context) {
    listenItemDetailsSheet(ref, context);
    return Column(
      children: [
        Row(
          children: [
            const AdaptiveBackButton(width: 40.0, height: 40.0),
            Expanded(
                child: ItemGroupsSearchField(
              autofocus: widget.autoFocus,
            )),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                FiltersDropdownButtonFormField(
                  height: 30,
                  width: 130,
                ),
                SubItemGroupsList(shrinkWrap: true, withoutBottomPadding: true)
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Expanded(
          child: ItemGroupItemsGrid(childAspectRatio: 0.67),
        ),
      ],
    );
  }
}
