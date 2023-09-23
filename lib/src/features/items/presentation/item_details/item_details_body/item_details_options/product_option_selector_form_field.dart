import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/domain/product_option/product_option.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/price_modifiers_provider.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/saved_options_provider.dart';
import 'package:widam/src/features/items/presentation/item_details/option_label.dart';
import 'package:widam/src/theme/app_colors.dart';

enum ProductOptionType { productDetails, subscription }

class ProductOptionSelectorFormField extends FormField<int> {
  ProductOptionSelectorFormField(
      {super.key,
      required ProductOption productOption,
      required WidgetRef ref,
      ProductOptionType productOptionType = ProductOptionType.productDetails,
      FormFieldSetter<({String productOptionName, int valueId})>? onSaved})
      : super(
            initialValue: productOption.radioGroupOption.first.id,
            onSaved: (value) {
              if (value != null) {
                if (productOptionType == ProductOptionType.productDetails) {
                  ref.read(savedOptionsProvider.notifier).addSavedOption((
                    productOptionId: productOption.optionName,
                    radioOptionId: value,
                    isPriceModifier: productOption.isPriceModifier
                  ));
                } else {
                  onSaved?.call((
                    productOptionName: productOption.optionName,
                    valueId: value
                  ));
                }
              }
            },
            validator: (value) {
              if (productOption.isMandatory == 1 && value == null) {
                return S.current.required;
              }
              return null;
            },
            builder: (FormFieldState<int> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OptionLabel(label: productOption.title),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: productOption.radioGroupOption.length,
                      itemBuilder: (context, index) {
                        final radioOption =
                            productOption.radioGroupOption[index];
                        bool isSelected = state.value == radioOption.id;
                        return FilterChip(
                            label: Text(radioOption.value),
                            padding: null,
                            selected: isSelected,
                            side: isSelected
                                ? const BorderSide(
                                    color: AppColors.darkBlue, width: 1)
                                : null,
                            labelStyle: isSelected
                                ? const TextStyle(
                                    color: AppColors.darkBlue,
                                    fontWeight: FontWeight.w600)
                                : null,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                state.didChange(radioOption.id);
                                if (productOptionType ==
                                    ProductOptionType.productDetails) {
                                  if (!ref.read(priceModifiersProvider).any(
                                      (element) =>
                                          element.id ==
                                          productOption.optionName)) {
                                    ref
                                        .read(priceModifiersProvider.notifier)
                                        .addPriceModifier((
                                      id: productOption.optionName,
                                      value: productOption.priceModifierAmount
                                    ));
                                  }
                                }
                              } else {
                                state.didChange(null);
                                if (productOptionType ==
                                    ProductOptionType.productDetails) {
                                  ref
                                      .read(priceModifiersProvider.notifier)
                                      .removePriceModifier(
                                          productOption.optionName);
                                }
                              }
                            });
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12.0),
                    ),
                  ),
                  if (productOption.hint.isNotEmpty && !state.hasError)
                    Text(productOption.hint,
                        style: const TextStyle(
                            color: AppColors.gray, fontSize: 12)),
                  if (state.hasError)
                    Text(state.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12))
                ],
              );
            });
}
