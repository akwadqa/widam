import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/item_details_service.dart';

part 'item_details_controller.g.dart';

@riverpod
class ItemDetailsController extends _$ItemDetailsController {
  @override
  FutureOr<ItemDetailsData?> build() => null;

  ItemDetailsService get _itemDetailsService =>
      ref.watch(itemDetailsServiceProvider);

  Future<void> getItemDetails(
      {required String itemId,
      String? mubadaraId,
      String? attributionToken}) async {
    try {
      state = const AsyncLoading();
      final itemDetails = await _itemDetailsService.getItemDetails(
          itemId: itemId,
          mubadaraId: mubadaraId,
          attributionToken: attributionToken,
          ref: ref);
      state = AsyncData(ItemDetailsData(itemDetails));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> onVariantsChange(String itemId) async {
    state = AsyncData(state.asData!.value!.copyWith(isLoading: true));
    try {
      final itemDetails = await _itemDetailsService.getItemDetails(
          itemId: itemId,
          mubadaraId:
              state.asData!.value!.itemDetails.mubadaraDetails?.mubadaraId,
          ref: ref);
      state = AsyncData(ItemDetailsData(itemDetails));
    } catch (error, stackTrace) {
      state = AsyncData(state.asData!.value!.copyWith(
          isLoading: false,
          onVariantsChangeError: AsyncError(error, stackTrace)));
    }
  }
}
