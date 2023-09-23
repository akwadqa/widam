import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_models/response/app_response.dart';
import '../../data/loyalty_points_repository.dart';
import '../../domain/loyalty_points_log/loyalty_points_log.dart';

part 'points_history_controller.g.dart';

@riverpod
class PointsHistoryController extends _$PointsHistoryController {
  LoyaltyPointsRepository get _loyaltyPointsRepository =>
      ref.watch(loyaltyPointsRepositoryProvider);

  @override
  FutureOr<AppResponse<List<LoyaltyPointsLog>>> build() {
    return _loyaltyPointsRepository.getloyaltyPointsLog(1);
  }

  Future<bool> onLoading(int pageNo) async {
    if (pageNo > state.asData!.value.pagination!.totalPages) {
      return false;
    }
    try {
      final response =
          await _loyaltyPointsRepository.getloyaltyPointsLog(pageNo);
      state = AsyncData(state.asData!.value.copyWith(
        data: [...state.asData!.value.data, ...response.data],
      ));
      return true;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return false;
    }
  }
}
