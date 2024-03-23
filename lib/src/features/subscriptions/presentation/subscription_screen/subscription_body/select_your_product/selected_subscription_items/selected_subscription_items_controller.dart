import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../domain/subscription_item.dart';

part 'selected_subscription_items_controller.g.dart';

@riverpod
class SelectedSubscriptionItemsController
    extends _$SelectedSubscriptionItemsController {
  @override
  List<SubscriptionItem> build() => [];

  void addSubscriptionItemById(String itemId) {
    state = [...state, SubscriptionItem(id: itemId, quantity: 1)];
  }

  void addSubscriptionItem(SubscriptionItem item) {
    state = [...state, item];
  }

  void removeSubscriptionItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }
}
