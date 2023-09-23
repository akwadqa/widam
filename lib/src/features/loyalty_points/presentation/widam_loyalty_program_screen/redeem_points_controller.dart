import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/loyalty_points/data/loyalty_points_repository.dart';

part 'redeem_points_controller.g.dart';

@riverpod
class RedeemPointsController extends _$RedeemPointsController {
  @override
  FutureOr<String?> build() => null;

  Future<void> redeemPoints() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.watch(loyaltyPointsRepositoryProvider).redeemPoints());
  }
}
