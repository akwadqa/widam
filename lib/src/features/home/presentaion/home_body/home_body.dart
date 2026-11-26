import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/items/application/item_group_items_controller.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/features/order_review/presentation/order_review_bottom_sheet/order_review_bottom_sheet.dart';
import 'package:widam/src/features/sales_orders/data/sales_orders_repository.dart';

import '../../../../utils/utils.dart';
import '../../../cart/presentation/cart_item_added_dialog/cart_item_added_dialog.dart';
import '../../../layouts/presentation/blocks_list.dart';
import 'widgets/home_body_order_tracking_card.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  /// Content fades out over this height under the header while scrolling.
  static const double _topFadeHeight = 14;

  static Shader _topFadeShader(Rect bounds) {
    final fadeEnd = bounds.height == 0
        ? 0.0
        : (_topFadeHeight / bounds.height).clamp(0.0, 1.0);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [Colors.transparent, Colors.white],
      stops: [0, fadeEnd],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(itemGroupItemsControllerProvider, (previous, next) {});

    listenItemDetailsSheet(ref, context);
    ref.listen(goToTabControllerProvider, (previous, next) {
      switch (next) {
        case Initial():
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
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: _topFadeShader,
        child: const CustomScrollView(
          slivers: [
            // Keeps the first item clear of the fade while not scrolled.
            SliverToBoxAdapter(child: SizedBox(height: _topFadeHeight)),
            SliverToBoxAdapter(child: HomeBodyOrderTrackingCard()),
            BlocksList(layoutType: LayoutType.home),
          ],
        ),
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
                      onTapOutside: (_) => context.maybePop(),
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
