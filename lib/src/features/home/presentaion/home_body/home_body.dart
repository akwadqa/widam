import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/features/order_review/presentation/order_review_bottom_sheet/order_review_bottom_sheet.dart';
import 'package:widam/src/features/sales_orders/data/sales_orders_repository.dart';
import 'package:widam/src/features/sales_orders/presentaion/pending_order_card/pending_order_card.dart';

import '../../../../utils/utils.dart';
import '../../../cart/presentation/cart_item_added_dialog/cart_item_added_dialog.dart';
import '../../../layouts/presentation/blocks_list.dart';
import 'buttons_row.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(itemGroupItemsControllerProvider, (previous, next) {});

    listenItemDetailsSheet(ref, context);
    ref.listen(goToTabControllerProvider, (previous, next) {
      switch (next) {
        case Initial():
          break;
        case GoToCart():
          context.tabsRouter.setActiveIndex(3);
          break;
        case GoToHome():
          context.tabsRouter.setActiveIndex(0);
          break;
        case ShowCartDialog():
          Future.delayed(const Duration(milliseconds: 300), () {
            _showCartDialog(context);
          });
      }
    });
    ref.listen(processingOrderProvider, (previous, next) {
      if (next is AsyncData && next.value?.reviewingOrders != null) {
        showAdaptiveModalBottomSheet(
            context: context,
            builder: (context) {
              return OrderReviewBottomSheet(
                  orderId: next.value!.reviewingOrders!);
            });
      }
    });
    return RefreshIndicator.adaptive(
      onRefresh: () async => ref.invalidate(layoutProvider(LayoutType.home)),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ButtonsRow(),
            ),
          ),
          if (ref
                  .watch(processingOrderProvider)
                  .asData
                  ?.value
                  .hasProcessingOrders ==
              true)
            const SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: PendingOrderCard(),
            )),
          const BlocksList(layoutType: LayoutType.home),
        ],
      ),
    );
  }

  void _showCartDialog(BuildContext context) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) => _SlideDownDialog(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: SingleChildScrollView(
                  child: TapRegion(
                      onTapOutside: (_) => context.popRoute(),
                      child: const CartItemAddedDialog()),
                ),
              ),
            ));
  }
}

class _SlideDownDialog extends StatefulWidget {
  final Widget child;

  const _SlideDownDialog({required this.child});

  @override
  State<_SlideDownDialog> createState() => _SlideDownDialogState();
}

class _SlideDownDialogState extends State<_SlideDownDialog>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 400),
            )..forward(),
            curve: Curves.easeInOut,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
