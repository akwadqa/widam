import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/select_your_product/selected_subscription_items/selected_subscription_items_controller.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../../common_widgets/app_pagination_widget.dart';
import '../../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../../../common_widgets/forward_submit_button.dart';
import '../block_title.dart';
import 'subscription_items_list.dart';
import 'subscription_items_notifier.dart';

import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../common_widgets/app_cached_network_image.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../item_groups/domain/item_group/item_group.dart';
import '../../../../data/subscriptions_repository.dart';
import '../../subscription_screen.dart';

class SelectYourProduct extends ConsumerWidget {
  const SelectYourProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(getAllItemGroupsSubscriptionsProvider);
    return asyncData.when(
        data: (data) {
          final itemGroups = data.data.copyWith(subCategories: [
            ItemGroup(
                itemGroupId: Strings.allItemGroup,
                itemGroupName: S.of(context).all,
                itemGroupImage: Assets.icons.categoryIcon.path,
                subItemGroups: []),
            ...data.data.subCategories
          ]).subCategories;
          return Column(
            children: [
              Expanded(
                child: AppPaginationWidget(
                  onLoading: ref
                      .read(subscriptionsItemsNotifierProvider.notifier)
                      .onLoading,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlockTitle(title: S.of(context).categories),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  itemCount: itemGroups.length,
                                  itemBuilder: (context, index) {
                                    return _ItemGroup(
                                        itemGroup: itemGroups[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 15),
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Consumer(
                                builder: (context, ref, child) {
                                  final selectedSubscriptionsItemGroupId =
                                      ref.watch(
                                          selectedSubscriptionsItemGroupIdProvider);
                                  return BlockTitle(
                                      title: selectedSubscriptionsItemGroupId ==
                                              Strings.allItemGroup
                                          ? S.of(context).allProducts
                                          : data.data.subCategories
                                              .firstWhere((element) =>
                                                  element.itemGroupId ==
                                                  selectedSubscriptionsItemGroupId)
                                              .itemGroupName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SubscriptionItemsList(),
                      const SliverToBoxAdapter(child: SizedBox(height: 40.0)),
                    ],
                  ),
                ),
              ),
              Consumer(builder: (context, WidgetRef ref, Widget? child) {
                final selectedSubscriptionItems =
                    ref.watch(selectedSubscriptionItemsControllerProvider);
                return ForwardSubmitButton(
                  onPressed: selectedSubscriptionItems.isEmpty
                      ? null
                      : () {
                          ref.read(stepIndexProvider.notifier).state = 1;
                        },
                  title: S.of(context).setUpYourPlan,
                );
              }),
              SizedBox(height: 20 + getBottomPadding(context)),
            ],
          );
        },
        error: (error, stack) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppBanner(message: error.toString(), stackTrace: stack),
            ),
        loading: () => const FadeCircleLoadingIndicator());
  }
}

final selectedSubscriptionsItemGroupIdProvider =
    StateProvider.autoDispose<String>((ref) => Strings.allItemGroup);

class _ItemGroup extends ConsumerWidget {
  const _ItemGroup({required this.itemGroup});
  final ItemGroup itemGroup;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectedSubscriptionsItemGroupIdProvider) ==
        itemGroup.itemGroupId;
    return InkWell(
      onTap: () => ref
          .read(selectedSubscriptionsItemGroupIdProvider.notifier)
          .state = itemGroup.itemGroupId,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
                border:
                    isSelected ? Border.all(color: AppColors.secondary) : null),
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: itemGroup.itemGroupId == Strings.allItemGroup
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Assets.icons.categoryIcon.svg(),
                  )
                : AppCachedNetworkImage(
                    imageUrl: itemGroup.itemGroupImage, height: 40, width: 40),
          ),
          const SizedBox(height: 6),
          Text(itemGroup.itemGroupName,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.secondary : Colors.black),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
