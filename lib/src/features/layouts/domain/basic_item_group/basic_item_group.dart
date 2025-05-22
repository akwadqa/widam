import 'package:freezed_annotation/freezed_annotation.dart';
import '../block_data.dart';

part 'basic_item_group.freezed.dart';
part 'basic_item_group.g.dart';

@freezed
class BasicItemGroup with _$BasicItemGroup implements BlockData {
  const factory BasicItemGroup({
    required String itemGroupId,
    required String itemGroupName,
    required String itemGroupImage,
    required String? parameters,
  }) = _BasicItemGroup;

  factory BasicItemGroup.fromJson(Map<String, dynamic> json) =>
      _$BasicItemGroupFromJson(json);
}
