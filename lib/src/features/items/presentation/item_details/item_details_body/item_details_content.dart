import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/pickup_points_form_field/pickup_points_form_field.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/quantity_form_field.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_form_field/slotter_fees_form_field.dart';
import 'package:widam/src/features/items/presentation/item_details/option_label.dart';

import '../../../domain/item_details/item_details.dart';
import '../item_attribute_variants_list.dart';
import '../item_details_controller.dart';
import '../item_details_header/item_details_header.dart';
import 'add_to_cart_widget.dart';
import 'details_tab_bar.dart';
import 'item_details_info.dart';
import 'mubadara_fields/mubadara_fields.dart';

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
    super.initState();
    _initQuantity();
  }

  void _initQuantity() {
    Future(() {
      ref.read(quantityProvider.notifier).state =
          widget.itemDetails.minQty.toInt();
    });
  }

  final _attributesFormKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  final FocusNode _attributeFocusNode = FocusNode();
  final FocusNode _optionsFocusNode = FocusNode();
  final FocusNode _slotterFeesFocusNode = FocusNode();
  final FocusNode _pickupPointFocusNode = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    _attributeFocusNode.dispose();
    _optionsFocusNode.dispose();
    _slotterFeesFocusNode.dispose();
    _pickupPointFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasVariants = widget.itemDetails.attributeVariants != null &&
        widget.itemDetails.attributeVariants!.isNotEmpty;
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          controller: _scrollController,
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
            if (hasVariants) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _attributesFormKey,
                  child: Focus(
                    focusNode: _attributeFocusNode,
                    child: ItemAttributeVariantsList(
                      variants: widget.itemDetails.attributeVariants!,
                      itemId: widget.itemDetails.websiteItemId,
                      isLoading: widget.isLoading,
                      onVariantsChange: (itemId) => ref
                          .read(itemDetailsControllerProvider.notifier)
                          .onVariantsChange(itemId),
                    ),
                  ),
                ),
              )
            ],
            if (widget.itemDetails.isPriceModifier == 1) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Focus(
                  focusNode: _slotterFeesFocusNode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OptionLabel(
                          label: widget.itemDetails.priceModifierTitle!),
                      Form(
                        key: ref.read(slotterFeesFormKeyProvider),
                        child: SlotterFeesFormField(
                            itemDetails: widget.itemDetails,
                            validator: (value) {
                              if (value == false) {
                                return S.of(context).slotterFeesValidationMsg;
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (widget.itemDetails.pickupPoints != null) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Focus(
                  focusNode: _pickupPointFocusNode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OptionLabel(
                          label: widget.itemDetails.pickupPoints!.label),
                      Form(
                        key: ref.read(pickupPointsFormKeyProvider),
                        child: PickupPointsFormField(
                            itemDetails: widget.itemDetails,
                            validator: (value) {
                              if (value == null) {
                                return S.of(context).pickupPointsValidationMsg;
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (widget.itemDetails.mubadaraDetails != null &&
                widget.itemDetails.mubadaraDetails!.qtyPerQid >= 1) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Focus(
                  focusNode: _optionsFocusNode,
                  child: MubadaraFields(
                      mubadaraDetails: widget.itemDetails.mubadaraDetails!),
                ),
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
                    onInvalidForm: (formType) {
                      if (formType == FormType.variants) {
                        _attributeFocusNode.requestFocus();
                      } else if (formType == FormType.options) {
                        _optionsFocusNode.requestFocus();
                      } else if (formType == FormType.slotterFees) {
                        _slotterFeesFocusNode.requestFocus();
                      } else if (formType == FormType.pickupPoint) {
                        _pickupPointFocusNode.requestFocus();
                      }
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    attributionToken: widget.attributionToken,
                    itemId: widget.itemDetails.websiteItemId,
                    itemWarehouseId: widget.itemDetails.warehouse.warehouseId,
                    hasVariants: hasVariants,
                    attributesFormKey: _attributesFormKey));
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
