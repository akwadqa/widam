import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../addresses/domain/address/warehouse.dart';
import '../../../tags/domain/tag/tag.dart';
import '../additional_image/additional_image.dart';
import '../item_specification/item_specification.dart';
import '../attribute_variant.dart';
import '../item/price.dart';
import '../mubadara_details/mubadara_details.dart';
import '../pickup_points_details/pickup_points_details.dart';

part 'item_details.freezed.dart';
part 'item_details.g.dart';

@freezed
class ItemDetails with _$ItemDetails {
  const factory ItemDetails(
      {required String websiteItemId,
      required String stockUom,
      required String websiteItemType,
      required String status,
      required int requiresPreparation,
      required double minQty,
      required double maxQty,
      required num? qtyInCart,
      required int popularity,
      required int? defaultVariant,
      required String? websiteTemplateId,
      required List<AttributeVariant>? websiteItemAttributes,
      required List<AttributeVariant>? attributeVariants,
      required String websiteItemName,
      required String? websiteItemShortName,
      required String description,
      required String shortDescription,
      required String webLongDescription,
      required int isExpressItem,
      required Price price,
      required int inStock,
      required List<Tag> tags,
      required List<AdditionalImage> additionalImages,
      required List<ItemSpecification> websiteSpecifications,
      required MubadaraDetails? mubadaraDetails,
      required String? row,
      required int? isPriceModifier,
      required double? priceModifier,
      required String? priceModifierTitle,
      required String? customerQid,
      required PickupPointsDetails? pickupPoints,
      required int? isUdhiyaItem,
      required Warehouse warehouse
      }) = _ItemDetails;

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);
}
