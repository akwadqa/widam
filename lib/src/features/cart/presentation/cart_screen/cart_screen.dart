import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../cart_body/cart_body.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CartBody(),
    );
  }
}
