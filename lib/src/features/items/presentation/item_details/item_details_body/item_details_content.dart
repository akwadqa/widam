import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/item_details_options.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/quantity_form_field.dart';

import '../../../domain/item_details/item_details.dart';
import '../item_attribute_variants_list.dart';
import '../item_details_controller.dart';
import '../item_details_header/item_details_header.dart';
import 'add_to_cart_widget.dart';
import 'details_tab_bar.dart';
import 'item_details_info.dart';
import 'mubadara_fields.dart';

class ItemDetailsContent extends ConsumerStatefulWidget {
  const ItemDetailsContent(
      {super.key,
      required this.isLoading,
      required this.itemDetails,
      this.attributionToken});
  final bool isLoading;
  final ItemDetails itemDetails;
  final String? attributionToken;
  @override
  ConsumerState<ItemDetailsContent> createState() => _ItemDetailsContentState();
}

class _ItemDetailsContentState extends ConsumerState<ItemDetailsContent> {
  @override
  void initState() {
    Future(() {
      ref.read(quantityProvider.notifier).state =
          widget.itemDetails.minQty.toInt();
    });
    super.initState();
  }

  final _optionsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ItemDetailsHeader(itemDetails: widget.itemDetails),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ItemDetailsInfo(itemDetails: widget.itemDetails),
            ),
            if (!(widget.itemDetails.shortDescription.isEmpty &&
                widget.itemDetails.shortDescription.isEmpty)) ...[
              const SizedBox(height: 10),
              DetailsTabBar(itemDetails: widget.itemDetails),
            ],
            if (widget.itemDetails.attributeVariants != null &&
                widget.itemDetails.attributeVariants!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ItemAttributeVariantsList(
                  variants: widget.itemDetails.attributeVariants!,
                  itemId: widget.itemDetails.websiteItemId,
                  isLoading: widget.isLoading,
                  onVariantsChange: (itemId) => ref
                      .read(itemDetailsControllerProvider.notifier)
                      .onVariantsChange(itemId),
                ),
              )
            ],
            if (widget.itemDetails.productOptions.isNotEmpty) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _optionsFormKey,
                  child: ItemDetailsOptions(
                      productOptions: widget.itemDetails.productOptions),
                ),
              ),
            ],
            if (widget.itemDetails.mubadaraDetails != null &&
                widget.itemDetails.mubadaraDetails!.qtyPerQid >= 1) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MubadaraFields(
                    mubadaraDetails: widget.itemDetails.mubadaraDetails!),
              )
            ],
            const SizedBox(height: 200),
          ]),
        ),
        KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          if (!isKeyboardVisible) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AddToCartWidget(
                    attributionToken: widget.attributionToken,
                    itemId: widget.itemDetails.websiteItemId,
                    optionsFromKey: _optionsFormKey));
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
