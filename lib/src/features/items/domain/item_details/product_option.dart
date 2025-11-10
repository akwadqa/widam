import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_option.freezed.dart';
part 'product_option.g.dart';

@freezed
class ProductOption with _$ProductOption {
  const factory ProductOption({
    @JsonKey(name: 'option_name') required String? optionName,
    @JsonKey(name: 'option_type') required String? optionType,
    @JsonKey(name: 'title') required String? title,
    @JsonKey(name: 'is_price_modifier') required int? isPriceModifier,
    @JsonKey(name: 'price_modifier_amount') required dynamic priceModifierAmount,
    @JsonKey(name: 'view_option') required String? viewOption,
    @JsonKey(name: 'is_mandatory') required int? isMandatory,
    @JsonKey(name: 'hint') required String? hint,
    @JsonKey(name: 'weightage') required String? weightage,
    @JsonKey(name: 'radio_group_option') required List<dynamic>? radioGroupOption,
  }) = _ProductOption;

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);
}
