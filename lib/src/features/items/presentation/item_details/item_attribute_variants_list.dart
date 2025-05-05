import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/features/items/presentation/item_details/selected_variant_controller.dart';
import '../../../../common_widgets/app_stacked_loading_indicator.dart';

import '../../domain/attribute_value/attribute_value.dart';
import '../../domain/attribute_variant.dart';
import '../../../../theme/app_colors.dart';
import 'option_label.dart';

class ItemAttributeVariantsList extends FormField<String> {
  ItemAttributeVariantsList(
      {super.key,
      required List<AttributeVariant> variants,
      required String itemId,
      required bool isLoading,
      required Function(String) onVariantsChange})
      : super(validator: (value) {
          if (variants.isEmpty) return null;
          if (value == null || value.isEmpty) {
            return S.current.required;
          }
          return null;
        }, builder: (FormFieldState<String> state) {
          return AppStackedLoadingIndicator(
            isLoading: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _VariantsList(
                    variants: variants,
                    itemId: itemId,
                    onVariantsChange: (value) {
                      state.didChange(value);
                      onVariantsChange(value);
                    }),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  )
              ],
            ),
          );
        });
}

class _VariantsList extends StatelessWidget {
  const _VariantsList(
      {required this.variants,
      required this.itemId,
      required this.onVariantsChange});

  final List<AttributeVariant> variants;
  final String itemId;
  final Function(String) onVariantsChange;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, parentIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            OptionLabel(label: variants[parentIndex].attributeTitle),
            SizedBox(
              height: variants[parentIndex].attributeStyle == 'Icon' ? 120 : 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: (variants[parentIndex].attributeValue
                        as List<AttributeValue>)
                    .length,
                itemBuilder: (context, index) {
                  return _AttributeValueItem(
                      attributeValue:
                          variants[parentIndex].attributeValue[index],
                      itemId: itemId,
                      onVariantsChange: onVariantsChange,
                      withIcon: variants[parentIndex].attributeStyle == 'Icon');
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 12.0),
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20.0),
      itemCount: variants.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );
  }
}

class _AttributeValueItem extends ConsumerWidget {
  const _AttributeValueItem(
      {required this.attributeValue,
      required this.itemId,
      required this.onVariantsChange,
      required this.withIcon});

  final AttributeValue attributeValue;
  final String itemId;
  final Function(String) onVariantsChange;
  final bool withIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVariant = ref.watch(selectedVariantControllerProvider);
    final isSelected = selectedVariant == attributeValue.websiteItemId;
    return FilterChip(
        label: withIcon
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppCachedNetworkImage(
                      imageUrl: attributeValue.icon!,
                      fit: BoxFit.fitHeight,
                      width: 60,
                      height: 60),
                  const SizedBox(height: 8.0),
                  Text(attributeValue.valueTitle)
                ],
              )
            : Text(attributeValue.valueTitle),
        padding: withIcon ? const EdgeInsets.all(4.0) : null,
        selected: isSelected,
        side: isSelected
            ? const BorderSide(color: AppColors.darkBlue, width: 1)
            : null,
        labelStyle: isSelected
            ? const TextStyle(
                color: AppColors.darkBlue, fontWeight: FontWeight.w600)
            : null,
        onSelected: attributeValue.inStock == 1
            ? (value) {
                if (value) {
                  onVariantsChange(attributeValue.websiteItemId!);
                  ref
                      .read(selectedVariantControllerProvider.notifier)
                      .onVariantsChange(attributeValue.websiteItemId!);
                }
              }
            : null);
  }
}
