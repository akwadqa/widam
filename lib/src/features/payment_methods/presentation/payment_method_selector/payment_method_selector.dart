import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import 'package:widam/src/features/payment_methods/domain/payment_methods_data/payment_method.dart';
import 'package:widam/src/features/payment_methods/domain/payment_methods_data/saved_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';

import '../../../../common_widgets/app_cached_network_image.dart';
import '../../data/payment_methods_repository.dart';

class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector(
      {super.key,
      required this.selectedPaymentMethodId,
      this.selectedPaymentTokenId,
      required this.isMubadara,
      required this.hasMoreDeliveryMethods});

  final String? selectedPaymentMethodId;
  final String? selectedPaymentTokenId;
  final bool isMubadara;
  final bool hasMoreDeliveryMethods;

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  bool _isWalletSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).changeYourPaymentMethod,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final appData = ref.watch(appDataControllerProvider);
                final walletBalance = appData.asData?.value.walletBalance ?? 0;
                if (double.parse(walletBalance.toString()) > 0) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _WalletSwitch(
                                  onChanged: (value) =>
                                      _isWalletSelected = value),
                              const SizedBox(width: 14),
                              Text(S.of(context).widamWallet,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                          Text('$walletBalance ${S.of(context).qar}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                      const Divider()
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            _PaymentMethodsList(
                isMubadara: widget.isMubadara,
                hasMoreDeliveryMethods: widget.hasMoreDeliveryMethods,
                isWalletSelected: _isWalletSelected,
                selectedPaymentMethodId: widget.selectedPaymentMethodId,
                selectedPaymentTokenId: widget.selectedPaymentTokenId),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodsList extends ConsumerWidget {
  const _PaymentMethodsList(
      {required this.selectedPaymentMethodId,
      this.selectedPaymentTokenId,
      required this.isWalletSelected,
      required this.isMubadara,
      required this.hasMoreDeliveryMethods});

  final String? selectedPaymentMethodId;
  final String? selectedPaymentTokenId;
  final bool isWalletSelected;
  final bool isMubadara;
  final bool hasMoreDeliveryMethods;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethodsAsync = ref.watch(paymentMethodsProvider);
    return paymentMethodsAsync.when(
        data: (paymentMethodsList) {
          List<PaymentMethod> paymentMethods =
              paymentMethodsList.where((element) {
            if (Platform.isAndroid) {
              return element.paymentType != 'Apple Pay';
            } else {
              return element.paymentType != 'Google Pay';
            }
          }).toList();

          if (isMubadara || hasMoreDeliveryMethods) {
            paymentMethods = paymentMethods
                .where((element) => element.processor != 'Offline')
                .toList();
          }
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _PaymentMethodItem(
                    paymentMethod: paymentMethods[index],
                    selectedPaymentMethodId: selectedPaymentMethodId,
                    selectedPaymentTokenId: selectedPaymentTokenId,
                    isWalletSelected: isWalletSelected);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: paymentMethods.length);
        },
        loading: () => const FadeCircleLoadingIndicator(),
        error: (error, stackTrace) =>
            AppBanner(message: error.toString(), stackTrace: stackTrace));
  }
}

class _PaymentMethodItem extends StatelessWidget {
  const _PaymentMethodItem(
      {required this.paymentMethod,
      this.selectedPaymentMethodId,
      this.selectedPaymentTokenId,
      required this.isWalletSelected});
  final PaymentMethod paymentMethod;
  final String? selectedPaymentMethodId;
  final String? selectedPaymentTokenId;
  final bool isWalletSelected;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentMethod>(
      title: Padding(
        padding: paymentMethod.paymentType == 'Payment Token'
            ? const EdgeInsets.only(top: 21)
            : const EdgeInsets.only(top: 0),
        child: Row(children: [
          AppCachedNetworkImage(imageUrl: paymentMethod.icon, height: 20.0),
          const SizedBox(width: 10),
          Text(paymentMethod.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold))
        ]),
      ),
      value: paymentMethod,
      groupValue: paymentMethod.paymentMethodId == selectedPaymentMethodId
          ? paymentMethod
          : null,
      onChanged: paymentMethod.paymentType == 'Payment Token'
          ? null
          : (value) => context.maybePop<(bool, String, String?)?>(
              (isWalletSelected, paymentMethod.paymentMethodId, null)),
      subtitle: paymentMethod.paymentType == 'Payment Token'
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile<SavedCard>(
                  title: Row(children: [
                    AppCachedNetworkImage(
                        imageUrl: paymentMethod.savedCards![index].icon,
                        height: 10.0),
                    const SizedBox(width: 10),
                    Text(
                        '${S.of(context).cardEndingIn} ${paymentMethod.savedCards![index].cardNumber.substring(paymentMethod.savedCards![index].cardNumber.length - 4)}',
                        style: const TextStyle(fontSize: 12))
                  ]),
                  value: paymentMethod.savedCards![index],
                  groupValue: paymentMethod.savedCards![index].paymentTokenId ==
                          selectedPaymentTokenId
                      ? paymentMethod.savedCards![index]
                      : null,
                  onChanged: (value) =>
                      context.maybePop<(bool, String, String?)?>((
                    isWalletSelected,
                    paymentMethod.paymentMethodId,
                    paymentMethod.savedCards![index].paymentTokenId
                  )),
                );
              },
              itemCount: paymentMethod.savedCards!.length)
          : null,
    );
  }
}

class _WalletSwitch extends StatefulWidget {
  const _WalletSwitch({required this.onChanged});

  final void Function(bool)? onChanged;

  @override
  State<_WalletSwitch> createState() => _WalletSwitchState();
}

class _WalletSwitchState extends State<_WalletSwitch> {
  bool _value = true;

  @override
  void initState() {
    widget.onChanged?.call(_value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged?.call(value);
        });
  }
}
