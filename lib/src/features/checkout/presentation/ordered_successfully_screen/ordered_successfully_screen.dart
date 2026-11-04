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
  const OrderedSuccessfullyScreen({
    super.key,
    required this.order,
    this.pun,
  });

  final Order order;
  final String? pun;
  List<String> get _orderIds {
    return order.orderId
        .split(',')
        .map((id) => id.trim())
        .where((id) => id.isNotEmpty)
        .toList();
  }

  bool get _hasMultipleOrders => _orderIds.length > 1;

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

            if (_hasMultipleOrders) ...[
              const SizedBox(height: 12),
              _MultipleOrdersNotice(
                orderIds: _orderIds,
              ),
            ],

            if (pun != null) ...[
              const SizedBox(height: 2),
              Text(
                'pun: $pun',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Keep shopping stays exactly where it is.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return SubmitButton(
                        text: S.of(context).keepShopping,
                        onPressed: () {
                          ref
                              .read(
                                goToTabControllerProvider.notifier,
                              )
                              .goToHome();

                          context.router.popUntilRoot();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    S.of(context).orderSummary,
                    style: _textStyle(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Existing order UI repeated for every order.
            _OrderSection(
              order: order,
              orderIds: _orderIds,
              hasMultipleOrders: _hasMultipleOrders,
            ),

            const SizedBox(height: 80),

            // Keep the rest exactly as you already have it.
            TextButton(
              onPressed: () => context.pushRoute(
                TermsConditionsAndPrivacyPolicyScreen(
                  title: S.of(context).privacyPolicy,
                ),
              ),
              child: Text(
                S.of(context).privacyPolicy,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            TextButton(
              onPressed: () => context.pushRoute(
                TermsConditionsAndPrivacyPolicyScreen(),
              ),
              child: Text(
                S.of(context).termsAndConditions,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              S.of(context).allRightsReserved,
              style: const TextStyle(
                color: AppColors.philippineSilver,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }
}

class _MultipleOrdersNotice extends StatelessWidget {
  const _MultipleOrdersNotice({
    required this.orderIds,
  });

  final List<String> orderIds;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrayishBlue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.midnightBlue,
          width: 0.7,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.midnightBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${orderIds.length} orders created',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.midnightBlue,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Your items have been divided into separate orders for delivery.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.taupeGray,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: orderIds.map((id) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.midnightBlue,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        id,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.midnightBlue,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderSection extends StatelessWidget {
  const _OrderSection({
    required this.order,
    required this.orderIds,
    required this.hasMultipleOrders,
  });

  final Order order;
  final List<String> orderIds;
  final bool hasMultipleOrders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (hasMultipleOrders)
        //   _OrderHeader(
        //     orderIds: orderIds,
        //   ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomContainer(
              title: S.of(context).orderAmount,
              subtitle:
                  '${order.currency} ${order.grandTotal.toStringAsFixed(2)}',
            ),
            const SizedBox(width: 10),
            _CustomContainer(
              title: hasMultipleOrders
                  ? 'Order Numbers'
                  : S.of(context).orderNumber,
              subtitle: hasMultipleOrders
                  ? '${orderIds.length} Orders'
                  : orderIds.first,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          color: AppColors.lightGrayishBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          child: _OrderDetails(
            order: order,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    required this.orderIds,
  });

  final List<String> orderIds;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrayishBlue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.midnightBlue,
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.midnightBlue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${orderIds.length} ORDERS',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  'Orders created from this checkout',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: orderIds.map(
              (id) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.midnightBlue,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    id,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.midnightBlue,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
class _OrderDetails extends StatelessWidget {
  const _OrderDetails({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).itemsInYourOrder,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListView.separated(
          itemBuilder: (context, index) {
            return _OrderItem(
              itemDetails: order.websiteItems[index],
            );
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
            fontWeight: FontWeight.w600,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).subTotal),
                  Text(
                    order.subTotal.toStringAsFixed(2),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).deliveryFee),
                  Text(
                    order.deliveryCharges.toStringAsFixed(2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.midnightBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${S.of(context).total} ${order.currency}',
                    ),
                    Text(
                      order.grandTotal.toStringAsFixed(2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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
              Text(itemDetails.price.discountedPrice.toStringAsFixed(2))
            ],
          ),
        ),
        Text(itemDetails.price.discountedPrice.toStringAsFixed(2),
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600))
      ],
    );
  }
}
