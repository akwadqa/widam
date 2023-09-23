import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/cart/domain/cart/cart.dart';
import 'package:widam/src/features/sales_orders/data/sales_orders_repository.dart';

part 'reorder_controller.g.dart';

@riverpod
class ReorderController extends _$ReorderController {
  @override
  FutureOr<Cart?> build() => null;

  Future<void> reorder({required String salesOrderId}) async {
    state = const AsyncLoading();
    final salesOrdersRepository = ref.watch(salesOrderRepositoryProvider);
    state = await AsyncValue.guard(
        () => salesOrdersRepository.reorder(salesOrderId));
  }
}
