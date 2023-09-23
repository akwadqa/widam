import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_modifiers_provider.g.dart';

@riverpod
class PriceModifiers extends _$PriceModifiers {
  @override
  List<({String id, double value})> build() {
    return [];
  }

  void addPriceModifier(({String id, double value}) priceModifier) {
    state = [...state, priceModifier];
  }

  void removePriceModifier(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  void initPriceModifiers(List<({String id, double value})> priceModifiers) {
    state = priceModifiers;
  }
}
