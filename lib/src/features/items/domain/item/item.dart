import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../tags/domain/tag/tag.dart';
import 'price.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  factory Item({
    required String websiteItemId,
    required String websiteItemName,
    required String? websiteItemShortName,
    required String websiteItemType,
    required num maxQty,
    required num minQty,
    required String stockUom,
    required String websiteItemImage,
    required String? itemGroup,
    required int isExpressItem,
    required Price price,
    required List<Tag> tags,
    required int inStock,
    required int? isMubadara,
    required String? mubadaraId,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
