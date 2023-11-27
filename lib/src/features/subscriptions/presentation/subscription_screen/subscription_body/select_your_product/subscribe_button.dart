import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/item_details_options.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/product_option_selector_form_field.dart';
import '../../../../../../utils/utils.dart';
import '../../../../domain/attribute.dart';
import 'subscription_item_details_controller.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../../../common_widgets/submit_button.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../items/domain/item/item.dart';
import '../../../../../items/presentation/item_details/item_attribute_variants_list.dart';
import '../../../../domain/subscription_item.dart';

final selectedSubscriptionItemsProvider =
    StateProvider.autoDispose<List<SubscriptionItem>>((ref) => []);

class SubscribeButton extends ConsumerWidget {
  const SubscribeButton({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubscriptionItems =
        ref.watch(selectedSubscriptionItemsProvider);
    final isSubscribed = selectedSubscriptionItems
        .any((element) => element.id == item.websiteItemId);
    return ElevatedButton(
        onPressed: () {
          if (isSubscribed) {
            _removeSubscriptionItem(item.websiteItemId, ref);
          } else {
            if (item.websiteItemType == 'V' || item.hasProductOptions == 1) {
              _showItemAttributesSelector(context, ref, item);
            } else {
              _addSubscriptionItem(item.websiteItemId, ref);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSubscribed ? AppColors.primary : Colors.white,
          foregroundColor: isSubscribed ? Colors.white : AppColors.primary,
          fixedSize: const Size(double.infinity, 24),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.primary, width: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Text(isSubscribed
            ? S.of(context).unsubscribe
            : item.websiteItemType == 'V'
                ? S.of(context).selectOptions
                : S.of(context).subscribe));
  }

  void _showItemAttributesSelector(
      BuildContext context, WidgetRef ref, Item item) {
    showAdaptiveModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: _ItemAttributesSelector(item: item)));
  }

  void _addSubscriptionItem(String itemId, WidgetRef ref) {
    ref.read(selectedSubscriptionItemsProvider.notifier).state = [
      ...ref.watch(selectedSubscriptionItemsProvider),
      SubscriptionItem(id: item.websiteItemId, quantity: 1)
    ];
  }

  void _removeSubscriptionItem(String itemId, WidgetRef ref) {
    final selectedSubscriptionItems =
        ref.read(selectedSubscriptionItemsProvider);
    ref.read(selectedSubscriptionItemsProvider.notifier).state =
        selectedSubscriptionItems
            .where((element) => element.id != itemId)
            .toList();
  }
}

class _ItemAttributesSelector extends ConsumerStatefulWidget {
  const _ItemAttributesSelector({required this.item});

  final Item item;

  @override
  ConsumerState<_ItemAttributesSelector> createState() =>
      _ItemAttributesSelectorState();
}

class _ItemAttributesSelectorState
    extends ConsumerState<_ItemAttributesSelector> {
  @override
  void initState() {
    Future(() {
      ref
          .read(subscriptionItemDetailsControllerProvider.notifier)
          .getItemDetails(
              itemId: widget.item.websiteItemId,
              mubadaraId: widget.item.mubadaraId);
    });
    super.initState();
  }

  final _optionsFormKey = GlobalKey<FormState>();
  final _attributesFormKey = GlobalKey<FormState>();
  final List<({String productOptionName, int valueId})> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final itemDetailsDataAsync =
              ref.watch(subscriptionItemDetailsControllerProvider);
          return itemDetailsDataAsync.when(
              data: (data) {
                if (data == null) {
                  return const SizedBox.shrink();
                }
                final itemDetails = data.itemDetails;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: _attributesFormKey,
                            child: ItemAttributeVariantsList(
                              variants: itemDetails.attributeVariants!,
                              itemId: itemDetails.websiteItemId,
                              isLoading: data.isLoading,
                              onVariantsChange: (itemId) => ref
                                  .read(
                                      subscriptionItemDetailsControllerProvider
                                          .notifier)
                                  .onVariantsChange(itemId),
                            ),
                          ),
                          if (itemDetails.productOptions.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            Form(
                              key: _optionsFormKey,
                              child: ItemDetailsOptions(
                                  onSaved: (data) =>
                                      _selectedOptions.add(data!),
                                  productOptionType:
                                      ProductOptionType.subscription,
                                  productOptions: itemDetails.productOptions),
                            ),
                            const SizedBox(height: 200),
                          ],
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20 + getBottomPadding(context),
                      left: 0,
                      right: 0,
                      child: SubmitButton(
                          text: S.of(context).subscribe,
                          onPressed: data.isLoading
                              ? null
                              : () {
                                  if (_attributesFormKey.currentState!
                                      .validate()) {
                                    if (_optionsFormKey.currentState!
                                        .validate()) {
                                      _optionsFormKey.currentState!.save();
                                      ref
                                          .read(
                                              selectedSubscriptionItemsProvider
                                                  .notifier)
                                          .state = [
                                        ...ref.read(
                                            selectedSubscriptionItemsProvider),
                                        SubscriptionItem(
                                            id: widget.item.websiteItemId,
                                            quantity: 1,
                                            attributes: itemDetails
                                                .websiteItemAttributes!
                                                .map((e) => Attribute(
                                                    id: e.attributeId,
                                                    value: e.attributeValue
                                                        .valueId))
                                                .toList(),
                                            productOptions:
                                                _selectedOptions.isEmpty
                                                    ? null
                                                    : _selectedOptions
                                                        .map((e) => {
                                                              'product_option_name':
                                                                  e.productOptionName,
                                                              'product_option_value':
                                                                  e.valueId
                                                            })
                                                        .toList())
                                      ];
                                      context.popRoute();
                                    }
                                  }
                                }),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Column(
                  children: [
                    AppBanner(
                        message: error.toString(), stackTrace: stackTrace),
                  ],
                );
              },
              loading: () => const FadeCircleLoadingIndicator());
        }),
      ),
    );
  }
}
