import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:widam/src/common_widgets/app_step_progress_indicator.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/features/cart/application/cart_service.dart';
import 'package:widam/src/features/cart/domain/cart/cart.dart';
import 'package:widam/src/features/cart/presentation/cart_banner/cart_banner.dart';
import 'package:widam/src/features/cart/presentation/cart_body/unavailable_items.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/theme/app_colors.dart';
import '../../../../common_widgets/total_container.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/forward_submit_button.dart';
import '../../../../utils/utils.dart';
import '../../../addresses/domain/address/address.dart';
import '../../../addresses/presentation/addresses/addresses_selector/addresses_selector.dart';
import '../../../recommendations/presentation/similar_items/similar_items.dart';
import '../../domain/cart/cart_content.dart';
import 'custom_delivery_container.dart';
import 'pickup_list.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../auth/application/user_data_provider.dart';
import 'cart_controller.dart';

class CartBody extends ConsumerWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userDataProvider) != null;
    return isLoggedIn ? const AuthenticatedCart() : const UnAthenticatedCart();
  }
}

class UnAthenticatedCart extends StatelessWidget {
  const UnAthenticatedCart({super.key});

  @override
  Widget build(BuildContext context) {
    return CartBanner(
      title: S.of(context).cartUnathorizedDesc,
      buttonText: S.of(context).loginOrRegister,
      onPressed: () => context.pushRoute(const LoginScreen()),
    );
  }
}

class AuthenticatedCart extends ConsumerWidget {
  const AuthenticatedCart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartControllerProvider);
    return cartAsync.when(
      data: (cart) {
        if (cart == null) {
          return CartBanner(
              title: S.of(context).yourCartIsEmpty,
              subtitle: S.of(context).cartEmptyDesc,
              buttonText: S.of(context).returnToShop,
              onPressed: () => context.tabsRouter.setActiveIndex(0));
        }
        return _NonEmptyCart(cart: cart);
      },
      error: (error, stack) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
            child: AppBanner(message: error.toString(), stackTrace: stack)),
      ),
      loading: () => const FadeCircleLoadingIndicator(),
    );
  }
}

class _NonEmptyCart extends StatelessWidget {
  const _NonEmptyCart({required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final expressDelivery =
        cart.pickup != 1 ? cart.cartContent.expressDelivery : null;
    final normalDelivery =
        cart.pickup != 1 ? cart.cartContent.normalDelivery : null;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 70.0)),
              SliverToBoxAdapter(
                child: SimiliarItems(quotationId: cart.quotationId),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              SliverToBoxAdapter(
                  child: Text(S.of(context).yourCartDetails,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0))),
              const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
              if (cart.pickup == 1)
                PickupList(cart: cart)
              else
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  if (normalDelivery != null)
                    CustomDeliveryContainer(
                        deliveryType: normalDelivery,
                        currency: cart.currency,
                        total: cart.total),
                  const SizedBox(height: 20.0),
                  if (expressDelivery != null)
                    CustomDeliveryContainer(
                        deliveryType: expressDelivery,
                        total: cart.total,
                        timeSlotWidget: Row(
                          children: [
                            Assets.icons.truckTimeIcon.svg(),
                            const SizedBox(width: 5.0),
                            Text(S.of(context).asSoonAsPossible,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                    color: Colors.black))
                          ],
                        ),
                        currency: cart.currency)
                ])),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              SliverToBoxAdapter(
                  child: RecentlyViewd(quotationId: cart.quotationId)),
              const SliverToBoxAdapter(child: SizedBox(height: 180.0)),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TotalContainer(
                orderTotal: cart.total,
                button: Consumer(
                  builder: (context, ref, child) {
                    ref.listen(updateCartProvider, (previous, next) {
                      if (next is AsyncError) {
                        showAppBannerDialog(
                            context, next.error.toString(), next.stackTrace);
                      }
                    });
                    final orderTotal = cart.orderTotal;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (orderTotal.remainderAmount > 0) ...[
                          AppStepProgressIndicator(
                            size: 4,
                            totalSteps: orderTotal.minimumOrderAmount.toInt(),
                            currentStep: orderTotal.remainderAmount > 0
                                ? (orderTotal.minimumOrderAmount -
                                        orderTotal.remainderAmount)
                                    .toInt()
                                : orderTotal.minimumOrderAmount.toInt(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                              '${S.of(context).minimumOrderAmount} ${cart.orderTotal.minimumOrderAmount} ${S.of(context).qar}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 16),
                        ],
                        ForwardSubmitButton(
                            onPressed: orderTotal.remainderAmount > 0
                                ? null
                                : () {
                                    if (ref
                                        .read(canVibrateProvider)
                                        .requireValue) {
                                      Vibrate.feedback(FeedbackType.light);
                                    }
                                    if ((cart.cartContent as CartContent)
                                        .normalDelivery!
                                        .websiteItems
                                        .any((element) =>
                                            element.inStock == 0)) {
                                      showAdaptiveModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const UnavailableItems();
                                          });
                                    } else if (cart.shippingAddressDetails ==
                                        null) {
                                      showAdaptiveModalBottomSheet<Address?>(
                                        context: context,
                                        builder: (context) =>
                                            const AddressesSelector(),
                                      ).then((address) {
                                        if (address != null) {
                                          ref
                                              .read(updateCartProvider.notifier)
                                              .updateCart(
                                                  shippingAddressId:
                                                      address.addressId)
                                              .then((value) {
                                            if (value) {
                                              context.pushRoute(
                                                  const CheckoutScreen());
                                            }
                                          });
                                        }
                                      });
                                    } else {
                                      context.pushRoute(const CheckoutScreen());
                                    }
                                  },
                            title: S.of(context).proceedToCheckout),
                      ],
                    );
                  },
                ),
                cart: cart))
      ],
    );
  }
}
