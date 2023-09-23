import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/wallet/domain/wallet_transaction/wallet_transaction.dart';
import 'package:widam/src/network/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';

part 'wallet_repository.g.dart';

@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) {
  return WalletRepository(ref.watch(networkServiceProvider()));
}

class WalletRepository {
  final NetworkService _networkService;

  WalletRepository(this._networkService);

  Future<AppResponse<List<WalletTransaction>>> getWalletTransactions(
      int pageNo) async {
    final response = await _networkService
        .get(EndPoints.walletTransaction, queryParameters: {
      'page_no': pageNo,
    });

    AppResponse<List<WalletTransaction>> appResponse = AppResponse.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => WalletTransaction.fromJson(e)).toList());

    if (appResponse.error == 1) {
      throw Exception(appResponse.message);
    }

    return appResponse;
  }
}
