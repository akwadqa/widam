import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_card_value_controller.g.dart';

@riverpod
class SavedCardValueController extends _$SavedCardValueController {
  @override
  bool build() {
    return true;
  }

  void onChanged(bool value) => state = value;
}
