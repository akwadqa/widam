import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../items/domain/item/item.dart';
import '../item_group/item_group.dart';

part 'item_group_details.freezed.dart';
part 'item_group_details.g.dart';

@freezed
class ItemGroupDetails with _$ItemGroupDetails {
  const factory ItemGroupDetails({
    required String itemGroupId,
    required String itemGroupName,
    required String? itemGroupImage,
    required int isGroup,
    required List<ItemGroup> subCategories,
    required List<Item> websiteItems,
  }) = _ItemGroupDetails;

  factory ItemGroupDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemGroupDetailsFromJson(json);
}
