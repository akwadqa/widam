import 'attribute.dart';

class SubscriptionItem {
  final String id;
  final List<Attribute>? attributes;
  final String? name;
  final num? quantity;
  final String? image;
  final List<Map<String, dynamic>>? productOptions;

  const SubscriptionItem(
      {required this.id,
      this.quantity,
      this.attributes,
      this.name,
      this.image,
      this.productOptions});

  Map<String, dynamic> toJson() {
    return {
      'website_item_id_template': id,
      'quantity': quantity,
      if (attributes != null && attributes!.isNotEmpty)
        'attributes': attributes,
      'product_options': productOptions
    };
  }

  SubscriptionItem.fromJson(Map<String, dynamic> json)
      : id = json['website_item_id'],
        quantity = json['quantity'],
        name = json['website_item_name'],
        attributes = [],
        productOptions = [],
        image = json['website_item_image'];
}
