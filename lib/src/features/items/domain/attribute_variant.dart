import 'attribute_value/attribute_value.dart';

class AttributeVariant {
  final String attributeId;
  final String attributeTitle;
  final String attributeStyle;
  final dynamic attributeValue;

  AttributeVariant({
    required this.attributeId,
    required this.attributeTitle,
    required this.attributeStyle,
    required this.attributeValue,
  });

  factory AttributeVariant.fromJson(Map<String, dynamic> json) {
    dynamic attributeValues;
    if (json['attribute_value'] is List) {
      final List<dynamic> values = json['attribute_value'];
      attributeValues =
          values.map((value) => AttributeValue.fromJson(value)).toList();
    } else {
      attributeValues = AttributeValue.fromJson(json['attribute_value']);
    }
    return AttributeVariant(
      attributeId: json['attribute_id'],
      attributeTitle: json['attribute_title'],
      attributeStyle: json['attribute_style'],
      attributeValue: attributeValues,
    );
  }
}
