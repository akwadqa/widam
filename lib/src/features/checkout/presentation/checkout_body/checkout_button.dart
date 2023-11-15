import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:pay/pay.dart';
import 'package:widam/src/features/cart/application/cart_service.dart';
import 'package:widam/src/features/checkout/domain/order/order.dart';
import 'package:widam/src/features/checkout/domain/payment_result/payment_result.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/custom_payment_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/submit_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../cart/domain/cart/cart.dart';
import 'place_order_controller.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../../generated/l10n.dart';

class CheckoutButton extends ConsumerStatefulWidget {
  const CheckoutButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  ConsumerState<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends ConsumerState<CheckoutButton> {
  late final Pay _payClient;

  @override
  void initState() {
    _initializePaymentClient();
    super.initState();
  }

  void _initializePaymentClient() {
    _payClient = Pay({
      if (Platform.isAndroid) PayProvider.google_pay: _googlePayConfig(),
      if (Platform.isIOS) PayProvider.apple_pay: _applePayConfig(),
    });
  }

  PaymentConfiguration _applePayConfig() {
    return PaymentConfiguration.fromJsonString(_defaultApplePayConfigurations);
  }

  PaymentConfiguration _googlePayConfig() {
    return PaymentConfiguration.fromJsonString(_defaultGooglePayConfigurations);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(customPaymentControllerProvider, (previous, next) {
      if (next is AsyncData && next.asData?.value != null) {
        if (next.asData!.value!.paymentSuccess) {
          _handleOrderPlaced(ref, context, next.asData!.value!.soDetails!);
        } else {
          _handlePaymentFailed(context);
        }
      }
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
    });
    ref.listen(placeOrderControllerProvider, (previous, next) {
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      } else if (next is AsyncData) {
        switch (next.value!) {
          case Initial():
            break;
          case OrderPlaced(order: final order):
            _handleOrderPlaced(ref, context, order);
          case RedirectingToPaymentGateway(payment: final payment):
            context
                .pushRoute(PaymentWebView(redirectUrl: payment.redirectUrl!))
                .then((paymentProviderResponse) {
              if (paymentProviderResponse != null) {
                if ((paymentProviderResponse as PaymentResult).paymentSuccess) {
                  _handleOrderPlaced(
                      ref,
                      context,
                      paymentProviderResponse.soDetails!,
                      paymentProviderResponse.pun);
                } else {
                  _handlePaymentFailed(context);
                }
              }
            });
          case SavedCard(quatationId: final quatationId, url: final url):
            if (widget.cart.paymentMethod?.paymentType == 'Google Pay') {
              _payWithGoogle(context, url);
            } else if (widget.cart.paymentMethod?.paymentType == 'Apple Pay') {
              _payWithApple(context, url);
            } else {
              ref
                  .read(customPaymentControllerProvider.notifier)
                  .payWithSavedCard(url, quatationId);
            }
        }
      }
    });
    final paymentType = widget.cart.paymentMethod?.paymentType;
    AsyncValue<PlaceOrderState>? placeOrderAsync;
    if ((paymentType != 'Apple Pay' && paymentType != 'Google Pay')) {
      placeOrderAsync = ref.watch(placeOrderControllerProvider);
    }
    final paySavedCardAsync = ref.watch(customPaymentControllerProvider);
    if (placeOrderAsync is AsyncLoading || paySavedCardAsync is AsyncLoading) {
      return const FadeCircleLoadingIndicator();
    }
    if (paymentType == 'Apple Pay') {
      return FutureBuilder<bool>(
        future: _payClient.userCanPay(PayProvider.apple_pay),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: RawApplePayButton(
                  onPressed: () => ref
                      .read(placeOrderControllerProvider.notifier)
                      .placeOrder(widget.cart.quotationId),
                  type: ApplePayButtonType.buy,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const FadeCircleLoadingIndicator();
          }
        },
      );
    }
    if (paymentType == 'Google Pay') {
      return FutureBuilder<bool>(
        future: _payClient.userCanPay(PayProvider.google_pay),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: RawGooglePayButton(
                  onPressed: () => ref
                      .read(placeOrderControllerProvider.notifier)
                      .placeOrder(widget.cart.quotationId),
                  type: GooglePayButtonType.buy,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const FadeCircleLoadingIndicator();
          }
        },
      );
    }
    return SubmitButton(
        text: S.of(context).placeOrder,
        onPressed: widget.cart.paymentMethod != null &&
                widget.cart.shippingAddressDetails != null
            ? () {
                if (ref.read(canVibrateProvider).requireValue) {
                  Vibrate.feedback(FeedbackType.heavy);
                }
                ref
                    .read(placeOrderControllerProvider.notifier)
                    .placeOrder(widget.cart.quotationId);
              }
            : null,
        backgroundColor: AppColors.red);
  }

  Future<void> _payWithApple(BuildContext context, String url) async {
    final paymentResult = await _payClient.showPaymentSelector(
      PayProvider.apple_pay,
      _paymentItems(context),
    );
    final network = paymentResult['paymentMethod']['network'];
    final type = network == 'Visa' ? '1' : '2';
    final tokenMap = paymentResult['token'];
    _submitToken(url, tokenMap.toString(), ref, type);
  }

  Future<void> _payWithGoogle(BuildContext context, String url) async {
    final paymentResult = await _payClient.showPaymentSelector(
      PayProvider.google_pay,
      _paymentItems(context),
    );
    final jsonToken =
        paymentResult['paymentMethodData']['tokenizationData']['token'];
    await _submitToken(url, jsonToken, ref);
  }

  Future<void> _submitToken(String url, String stringToken, WidgetRef ref,
      [type]) async {
    String token = base64.encode(utf8.encode(stringToken));
    await ref
        .read(customPaymentControllerProvider.notifier)
        .payWithAppleAndGooglePay(
            url: url,
            quatationId: widget.cart.quotationId,
            type: type?.toString(),
            token: token);
  }

  List<PaymentItem> _paymentItems(BuildContext context) {
    return [
      PaymentItem(
          label: 'Widam Food',
          type: PaymentItemType.total,
          amount: widget.cart.grandTotal.toString(),
          status: PaymentItemStatus.final_price)
    ];
  }

  void _handlePaymentFailed(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
          title: Text(S.of(context).paymentFailed),
          actions: [
            TextButton(
                onPressed: () {
                  context.popRoute();
                },
                child: Text(S.of(context).close))
          ]),
    );
  }

  void _handleOrderPlaced(WidgetRef ref, BuildContext context, Order order,
      [String? pun]) {
    ref.read(updateCartProvider.notifier).refreshCart();
    context.router.replace(OrderedSuccessfullyScreen(order: order, pun: pun));
  }

  String get _defaultApplePayConfigurations => '''{
"provider": "apple_pay",
"data": {
  "merchantIdentifier": "merchant.qa.com.widam.app",
  "displayName": "Widam Food",
  "merchantCapabilities": ["3DS", "debit", "credit"],
  "supportedNetworks": ["visa", "masterCard"],
  "countryCode": "QA",
  "currencyCode": "${widget.cart.currency}",
  "requiredBillingContactFields": [],
  "requiredShippingContactFields": [],
  "shippingMethods": []
}
}''';

  String get _defaultGooglePayConfigurations => '''{
  "provider": "google_pay",
  "data": {
    "environment": "PRODUCTION",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [{
      "type": "CARD",
      "tokenizationSpecification": {
        "type": "PAYMENT_GATEWAY",
        "parameters": {
          "gateway": "cybersource",
          "gatewayMerchantId": "qnb_widc_qar"
        }
      },
      "parameters": {
        "allowedCardNetworks": ["VISA", "MASTERCARD"],
        "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        "billingAddressRequired": true,
        "billingAddressParameters": {
          "format": "FULL",
          "phoneNumberRequired": true
        }
      }
    }],
    "merchantInfo": {
      "merchantId": "BCR2DN4TZ252X5QB",
      "merchantName": "Widam Food"
    },
    "transactionInfo": {
      "countryCode": "QA",
      "currencyCode": "${widget.cart.currency}"
    }
  }
}
''';
}
