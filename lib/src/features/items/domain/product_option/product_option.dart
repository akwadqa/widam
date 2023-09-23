import 'package:freezed_annotation/freezed_annotation.dart';

import 'radio_group_option.dart';

part 'product_option.freezed.dart';
part 'product_option.g.dart';

@freezed
class ProductOption with _$ProductOption {
  factory ProductOption({
    required String optionName,
    required String optionType,
    required String title,
    required int isPriceModifier,
    required double priceModifierAmount,
    required String viewOption,
    required int isMandatory,
    required String hint,
    required List<RadioGroupOption> radioGroupOption,
  }) = _ProductOption;

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);
}
