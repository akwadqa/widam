import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute_value.freezed.dart';
part 'attribute_value.g.dart';

@freezed
class AttributeValue with _$AttributeValue {
  const factory AttributeValue({
    required String valueId,
    required String valueTitle,
    String? websiteItemId,
    String? icon,
    int? inStock,
  }) = _AttributeValue;

  factory AttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueFromJson(json);
}
