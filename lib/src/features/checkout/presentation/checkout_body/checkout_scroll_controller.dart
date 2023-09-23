import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_scroll_controller.g.dart';

@riverpod
class CheckoutScrollController extends _$CheckoutScrollController {
  @override
  ScrollController build() {
    return ScrollController();
  }

  Future<void> scrollToTheEndOfTheScreen() async {
    await state.animateTo(state.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
