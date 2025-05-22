import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../items/application/item_details_service.dart';
import '../../items/domain/item_details/item_details.dart';

part 'item_details_sheet_controller.g.dart';

@Riverpod(keepAlive: true)
class ItemDetailsSheetController extends _$ItemDetailsSheetController {
  @override
  FutureOr<({ItemDetails itemDetails, String? attributionToken})?> build() =>
      null;

  Future<void> getDetails(
      {required String itemId, String? attributionToken}) async {
    state = const AsyncLoading();

    try {
      final itemDetails = await ref
          .watch(itemDetailsServiceProvider)
          .getItemDetails(
              itemId: itemId, attributionToken: attributionToken, ref: ref);
      state = AsyncData(
          (itemDetails: itemDetails, attributionToken: attributionToken));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
