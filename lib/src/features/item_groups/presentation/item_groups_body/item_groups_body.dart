import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/on_boarding/presentation/item_groups_on_boarding/item_groups_on_boarding.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../utils/utils.dart';
import '../../data/item_groups_repository.dart';
import '../../../items/presentation/item_group_items_grid.dart';
import 'item_groups_list/item_groups_list.dart';
import 'sub_item_groups_list/sub_item_groups_list.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/item_group/item_group.dart';
import 'filters_bar.dart';

class ItemGroupsBody extends ConsumerWidget {
  const ItemGroupsBody({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenItemDetailsSheet(ref, context);
    final allItemGroups = ref.watch(getAllItemGroupsProvider);
    return allItemGroups.when(
        data: (allItemGroups) {
          final itemGroups = allItemGroups.data.copyWith(subCategories: [
            ItemGroup(
                itemGroupId: Strings.allItemGroup,
                itemGroupName: S.of(context).all,
                itemGroupImage: Assets.icons.categoryIcon.path,
                subItemGroups: []),
            ...allItemGroups.data.subCategories
          ]).subCategories;
          return ItemGroupsOnBoadring(
              child: ({List<FocusNode>? focusNodes}) =>
                  _Body(itemGroups: itemGroups, focusNodes: focusNodes));
        },
        error: (error, stack) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  AppBanner(message: error.toString(), stackTrace: stack),
                ],
              ),
            ),
        loading: () => const FadeCircleLoadingIndicator());
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.itemGroups,
    this.focusNodes,
  });

  final List<ItemGroup> itemGroups;
  final List<FocusNode>? focusNodes;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future<void>.delayed(const Duration(seconds: 3), () {
      final showOnBoarding =
          widget.focusNodes != null && context.tabsRouter.activeIndex == 1;
      if (showOnBoarding) {
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null) {
          onboarding.show();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FiltersBar(focusNode: widget.focusNodes?.first),
        ),
        const SizedBox(height: 10),
        const SubItemGroupsList(),
        Expanded(
          child: Row(children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cultured,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ItemGroupList(
                      itemGroups: widget.itemGroups,
                      focusNode: widget.focusNodes?.last)),
            ),
            const Expanded(
                flex: 4, child: ItemGroupItemsGrid(childAspectRatio: 0.49)),
          ]),
        ),
      ],
    );
  }
}
