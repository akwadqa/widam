import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_specification.freezed.dart';
part 'item_specification.g.dart';

@freezed
class ItemSpecification with _$ItemSpecification {
  const factory ItemSpecification({
    required String label,
    required String description,
  }) = _ItemSpecification;

  factory ItemSpecification.fromJson(Map<String, dynamic> json) =>
      _$ItemSpecificationFromJson(json);
}
