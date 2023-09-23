class Attribute {
  final String id;
  final String value;

  const Attribute({required this.id, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'attribute_id': id,
      'attribute_value': value,
    };
  }
}
