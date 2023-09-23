import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/checkout/domain/order/order.dart';

import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';
import '../../../items/domain/item_details/item_details.dart';
import 'check_circle_widget.dart';

@RoutePage()
class OrderedSuccessfullyScreen extends StatelessWidget {
  const OrderedSuccessfullyScreen({super.key, required this.order, this.pun});

  final Order order;
  final String? pun;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).confirmation),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CheckCircleWidget(),
            const SizedBox(height: 10),
            Text(
              S.of(context).orderedSuccessfully,
              style: _textStyle(),
            ),
            if (pun != null) ...[
              const SizedBox(height: 2),
              Text('pun: $pun',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CustomContainer(
                    title: S.of(context).orderAmount,
                    subtitle: '${order.currency} ${order.grandTotal}'),
                const SizedBox(width: 10),
                _CustomContainer(
                    title: S.of(context).orderNumber, subtitle: order.orderId),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(builder: (context, ref, child) {
                    return SubmitButton(
                        text: S.of(context).keepShopping,
                        onPressed: () {
                          ref
                              .read(goToTabControllerProvider.notifier)
                              .goToHome();

                          context.router.popUntilRoot();
                        });
                  }),
                  const SizedBox(height: 30),
                  Text(
                    S.of(context).orderSummary,
                    style: _textStyle(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              color: AppColors.lightGrayishBlue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).itemsInYourOrder,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return _OrderItem(
                            itemDetails: order.websiteItems[index]);
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      itemCount: order.websiteItems.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    DefaultTextStyle.merge(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).subTotal),
                              Text(order.subTotal.toString())
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).shippingFee),
                              Text(order.deliveryCharges.toString())
                            ],
                          ),
                          const SizedBox(height: 12),
                          DefaultTextStyle.merge(
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.midnightBlue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${S.of(context).total} ${order.currency}'),
                                Text(order.grandTotal.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 80),
            TextButton(
                onPressed: () => context.pushRoute(
                    TermsConditionsAndPrivacyPolicyScreen(
                        title: S.of(context).privacyPolicy)),
                child: Text(S.of(context).privacyPolicy,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            TextButton(
                onPressed: () =>
                    context.pushRoute(TermsConditionsAndPrivacyPolicyScreen()),
                child: Text(S.of(context).termsAndConditions,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(height: 30),
            Text(S.of(context).allRightsReserved,
                style: const TextStyle(color: AppColors.philippineSilver)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
}

class _CustomContainer extends StatelessWidget {
  const _CustomContainer({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.midnightBlue, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          children: [
            Text(title),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ));
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({required this.itemDetails});
  final ItemDetails itemDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(color: AppColors.taupeGray, fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemDetails.websiteItemName,
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text('${itemDetails.qtyInCart} ${itemDetails.stockUom}'),
              const SizedBox(height: 3),
              Text(itemDetails.price.discountedPrice.toString())
            ],
          ),
        ),
        Text(itemDetails.price.discountedPrice.toString(),
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600))
      ],
    );
  }
}
