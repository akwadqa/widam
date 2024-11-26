import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../addresses/application/local_location_info.dart';
import '../data/item_details_repository.dart';
import '../domain/item_details/item_details.dart';

part 'item_details_service.g.dart';

class ItemDetailsService {
  final ItemDetailsRepository _itemDetailsRepository;

  const ItemDetailsService(this._itemDetailsRepository);

  Future<ItemDetails> getItemDetails(
      {required String itemId,
      String? mubadaraId,
      String? attributionToken,
      required Ref ref}) async {
    final itemDetails = await _getItemDetails(
        itemId: itemId,
        mubadaraId: mubadaraId,
        attributionToken: attributionToken,
        ref: ref);
    return itemDetails;
  }

  Future<ItemDetails> _getItemDetails(
      {required String itemId,
      String? mubadaraId,
      String? attributionToken,
      required Ref ref}) async {
    final warehouseId = ref.watch(localLocationInfoProvider).warehouseId;
    final repository = _itemDetailsRepository;
    return repository.getItemDetails(
        itemId: itemId,
        mubadaraId: mubadaraId,
        attributionToken: attributionToken,
        warehouseId: warehouseId);
  }

  Future<ItemDetails> onVariantsChange(
      {required String itemId, String? mubadaraId, required Ref ref}) async {
    final itemDetails =
        await _getItemDetails(itemId: itemId, mubadaraId: mubadaraId, ref: ref);
    return itemDetails;
  }
}

@Riverpod(keepAlive: true)
ItemDetailsService itemDetailsService(ItemDetailsServiceRef ref) =>
    ItemDetailsService(ref.watch(itemDetailsRepositoryProvider));

class ItemDetailsData {
  final ItemDetails itemDetails;
  final bool isLoading;
  final AsyncError? onVariantsChangeError;

  const ItemDetailsData(this.itemDetails,
      {this.isLoading = false, this.onVariantsChangeError});

  ItemDetailsData copyWith(
      {ItemDetails? itemDetails,
      bool? isLoading,
      AsyncError? onVariantsChangeError}) {
    return ItemDetailsData(itemDetails ?? this.itemDetails,
        isLoading: isLoading ?? this.isLoading,
        onVariantsChangeError:
            onVariantsChangeError ?? this.onVariantsChangeError);
  }
}
