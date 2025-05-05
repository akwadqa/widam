import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_transaction.freezed.dart';
part 'wallet_transaction.g.dart';

@freezed
class WalletTransaction with _$WalletTransaction {
  factory WalletTransaction({
    required String id,
    required String customer,
    required String logType,
    required String availableWalletBalance,
    required String amount,
    required String transactionDate,
    required String transactionTime,
    required String referenceDocument,
    required String referenceName,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
