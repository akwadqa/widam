import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';

part 'barcode_controller.g.dart';

@Riverpod(keepAlive: true)
class BarcodeController extends _$BarcodeController {
  @override
  String? build() {
    return null;
  }

  void set(String? value) {
    state = value;
    ref.read(itemGroupItemsControllerProvider.notifier).getItems();
  }
}
