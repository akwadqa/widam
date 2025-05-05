import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widam/src/features/checkout/domain/payment_result/payment_result.dart';

@RoutePage()
class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key, required this.redirectUrl});

  final String redirectUrl;

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) => _onPageFinished(url),
      ))
      ..loadRequest(Uri.parse(widget.redirectUrl));
    super.initState();
  }

  Future<void> _onPageFinished(String url) async {
    debugPrint('Page started loading: $url');
    final bodyText = await controller.runJavaScriptReturningResult(
      "document.body.innerText",
    );
    debugPrint('Page finished loading: $bodyText');
    if ((bodyText as String).contains('payment_success')) {
      _handleResult(bodyText);
    }
  }

  void _handleResult(String bodyText) {
    if (Platform.isAndroid) {
      bodyText = json.decode(bodyText);
    }
    final Map<String, dynamic> parsedTextBody = json.decode(bodyText);
    final paymentResult = PaymentResult.fromJson(parsedTextBody);
    context.maybePop(paymentResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: WebViewWidget(controller: controller));
  }
}
