import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/wallet/data/wallet_repository.dart';
import 'package:widam/src/features/wallet/domain/wallet_transaction/wallet_transaction.dart';

import '../../../../common_models/response/app_response.dart';

part 'transaction_history_controller.g.dart';

@riverpod
class TransactionHistoryController extends _$TransactionHistoryController {
  WalletRepository get _walletRepository => ref.watch(walletRepositoryProvider);

  @override
  FutureOr<AppResponse<List<WalletTransaction>>> build() {
    return _walletRepository.getWalletTransactions(1);
  }

  Future<bool> onLoading(int pageNo) async {
    if (pageNo > state.asData!.value.pagination!.totalPages) {
      return false;
    }
    try {
      final response = await _walletRepository.getWalletTransactions(pageNo);
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
