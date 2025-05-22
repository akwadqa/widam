import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/wallet/presentation/transaction_history_screen/transaction_history_controller.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../common_widgets/app_pagination_widget.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/titled_image.dart';
import '../../domain/wallet_transaction/wallet_transaction.dart';

@RoutePage()
class TransactionHistoryScreen extends ConsumerWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionHistoryAsync =
        ref.watch(transactionHistoryControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).transactionHistory),
      ),
      body: transactionHistoryAsync.when(
          data: (transactionHistory) {
            if (transactionHistory.data.isEmpty) {
              return Center(
                child: TitledImage(
                    title: S.of(context).noTransactionHistory,
                    icon: Assets.images.walletImage.svg()),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppPaginationWidget(
                onLoading: ref
                    .read(transactionHistoryControllerProvider.notifier)
                    .onLoading,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return _TransactionItem(
                          walletTransaction: transactionHistory.data[index]);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: transactionHistory.data.length),
              ),
            );
          },
          error: (error, stackTrace) =>
              AppBanner(message: error.toString(), stackTrace: stackTrace),
          loading: () => const Center(child: FadeCircleLoadingIndicator())),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.walletTransaction,
  });

  final WalletTransaction walletTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          border: Border.all(color: AppColors.brightGray, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 2,
              offset: const Offset(0, 0),
            )
          ]),
      child: ListTile(
        leading: walletTransaction.logType == 'Debit'
            ? const Icon(
                Icons.arrow_upward,
                color: AppColors.carminePink,
              )
            : const Icon(Icons.arrow_outward, color: AppColors.primary),
        title: Text(
            walletTransaction.logType == 'Quotation'
                ? S.of(context).purchase
                : walletTransaction.logType == 'Loyalty Point Redeem'
                    ? S.of(context).redeem
                    : walletTransaction.logType == "Credit"
                        ? S.of(context).credit
                        : walletTransaction.logType == "Debit"
                            ? S.of(context).debit
                            : walletTransaction.logType,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600)),
        subtitle: Text(
            '${walletTransaction.transactionDate}  ${walletTransaction.transactionTime}',
            style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(
            '(${walletTransaction.logType == 'Debit' ? '-' : '+'}${S.of(context).qar} ${walletTransaction.amount})',
            style: TextStyle(
                color: walletTransaction.logType == 'Debit'
                    ? AppColors.carminePink
                    : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
      ),
    );
  }
}
