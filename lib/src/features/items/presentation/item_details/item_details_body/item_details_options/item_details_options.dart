import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/items/domain/product_option/product_option.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/price_modifiers_provider.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/product_option_selector_form_field.dart';

class ItemDetailsOptions extends ConsumerStatefulWidget {
  const ItemDetailsOptions(
      {super.key,
      required this.productOptions,
      this.productOptionType = ProductOptionType.productDetails,
      this.onSaved});
  final List<ProductOption> productOptions;
  final ProductOptionType productOptionType;
  final FormFieldSetter<({String productOptionName, int valueId})>? onSaved;
  @override
  ConsumerState<ItemDetailsOptions> createState() => _ItemDetailsOptionsState();
}

class _ItemDetailsOptionsState extends ConsumerState<ItemDetailsOptions> {
  @override
  void initState() {
    if (widget.productOptionType == ProductOptionType.productDetails) {
      Future(() => ref.read(priceModifiersProvider.notifier).initPriceModifiers(
          widget.productOptions
              .where((element) => element.isPriceModifier == 1)
              .map((e) => (id: e.optionName, value: e.priceModifierAmount))
              .toList()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, parentIndex) {
        return ProductOptionSelectorFormField(
            onSaved: widget.onSaved,
            productOptionType: widget.productOptionType,
            productOption: widget.productOptions[parentIndex],
            ref: ref);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20.0),
      itemCount: widget.productOptions.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );
  }
}
