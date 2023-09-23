import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'saved_options_provider.g.dart';

@riverpod
class SavedOptions extends _$SavedOptions {
  @override
  List<({String productOptionId, int radioOptionId, int isPriceModifier})>
      build() {
    return [];
  }

  void addSavedOption(
      ({
        String productOptionId,
        int radioOptionId,
        int isPriceModifier
      }) option) {
    state = [...state, option];
  }
}
