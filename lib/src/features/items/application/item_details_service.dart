import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/item_details_repository.dart';
import '../domain/item_details/item_details.dart';

part 'item_details_service.g.dart';

class ItemDetailsService {
  final ItemDetailsRepository _itemDetailsRepository;

  const ItemDetailsService(this._itemDetailsRepository);

  Future<ItemDetails> getItemDetails({
    required String itemId,
    String? mubadaraId,
    String? attributionToken,
  }) async {
    final itemDetails = await _getItemDetails(
        itemId: itemId,
        mubadaraId: mubadaraId,
        attributionToken: attributionToken);
    return itemDetails;
  }

  Future<ItemDetails> _getItemDetails(
      {required String itemId,
      String? mubadaraId,
      String? attributionToken}) async {
    final repository = _itemDetailsRepository;
    return repository.getItemDetails(
        itemId: itemId,
        mubadaraId: mubadaraId,
        attributionToken: attributionToken);
  }

  Future<ItemDetails> onVariantsChange(
      {required String itemId, String? mubadaraId}) async {
    final itemDetails =
        await _getItemDetails(itemId: itemId, mubadaraId: mubadaraId);
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
