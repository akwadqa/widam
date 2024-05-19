import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_variant_controller.g.dart';

@riverpod
class SelectedVariantController extends _$SelectedVariantController {
  @override
  String? build() {
    return null;
  }

  void onVariantsChange(String itemId) {
    state = itemId;
  }
}
