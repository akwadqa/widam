import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/open_orders.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/past_orders.dart';

@RoutePage()
class SalesOrdersScreen extends StatelessWidget {
  const SalesOrdersScreen({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myOrders),
      ),
      body: DefaultTabController(
        initialIndex: initialIndex,
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(text: S.of(context).pastOrdersTitle),
              Tab(text: S.of(context).openOrders)
            ]),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TabBarView(children: [
                  PastOrders(),
                  OpenOrders(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
