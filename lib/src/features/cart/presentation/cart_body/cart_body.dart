import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:widam/main.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/features/cart/application/cart_service.dart';
import 'package:widam/src/features/cart/domain/cart/cart.dart';
import 'package:widam/src/features/cart/presentation/cart_banner/cart_banner.dart';
import 'package:widam/src/features/cart/presentation/cart_body/unavailable_items.dart';
import 'package:widam/src/features/on_boarding/presentation/cart_on_boarding/cart_on_boarding.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd.dart';
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
  const CartBody({Key? key}) : super(key: key);

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
        return CartOnBoadring(
            child: ({List<FocusNode>? focusNodes}) =>
                _NonEmptyCart(cart: cart, focusNodes: focusNodes));
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

class _NonEmptyCart extends StatefulWidget {
  const _NonEmptyCart({required this.cart, this.focusNodes});
  final Cart cart;
  final List<FocusNode>? focusNodes;

  @override
  State<_NonEmptyCart> createState() => _NonEmptyCartState();
}

class _NonEmptyCartState extends State<_NonEmptyCart> {
  @override
  void initState() {
    Future<void>.delayed(const Duration(seconds: 3), () {
      final showOnBoarding =
          widget.focusNodes != null && context.tabsRouter.activeIndex == 3;
      if (showOnBoarding) {
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null) {
          onboarding.show();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expressDelivery = widget.cart.pickup != 1
        ? widget.cart.cartContent.expressDelivery
        : null;
    final normalDelivery =
        widget.cart.pickup != 1 ? widget.cart.cartContent.normalDelivery : null;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              //TODO: Uncomment this when express delivery is implemented
              // if (cart.split == 0) ...[
              //   const SliverToBoxAdapter(
              //     child: ExpressContainer(),
              //   ),
              //   const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
              // ],
              const SliverToBoxAdapter(child: SizedBox(height: 70.0)),
              SliverToBoxAdapter(
                child: SimiliarItems(quotationId: widget.cart.quotationId),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              SliverToBoxAdapter(
                  child: Text(S.of(context).yourCartDetails,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0))),
              const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
              if (widget.cart.pickup == 1)
                PickupList(cart: widget.cart)
              else
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  if (normalDelivery != null)
                    CustomDeliveryContainer(
                        focusNode: widget.focusNodes?.first,
                        deliveryType: normalDelivery,
                        currency: widget.cart.currency),
                  const SizedBox(height: 20.0),
                  if (expressDelivery != null)
                    CustomDeliveryContainer(
                        deliveryType: expressDelivery,
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
                        currency: widget.cart.currency)
                ])),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              SliverToBoxAdapter(
                  child: RecentlyViewd(quotationId: widget.cart.quotationId)),
              const SliverToBoxAdapter(child: SizedBox(height: 150.0)),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TotalContainer(
                button: Consumer(
                  builder: (context, ref, child) {
                    ref.listen(updateCartProvider, (previous, next) {
                      if (next is AsyncError) {
                        showAppBannerDialog(
                            context, next.error.toString(), next.stackTrace);
                      }
                    });
                    return Focus(
                      focusNode: widget.focusNodes?.last,
                      child: ForwardSubmitButton(
                          onPressed: () {
                            if (ref.read(canVibrateProvider)) {
                              Vibrate.feedback(FeedbackType.light);
                            }
                            if ((widget.cart.cartContent as CartContent)
                                .normalDelivery!
                                .websiteItems
                                .any((element) => element.inStock == 0)) {
                              showAdaptiveModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const UnavailableItems();
                                  });
                            } else if (widget.cart.shippingAddressDetails ==
                                null) {
                              showAdaptiveModalBottomSheet<Address?>(
                                context: context,
                                builder: (context) => const AddressesSelector(),
                              ).then((address) {
                                if (address != null) {
                                  ref
                                      .read(updateCartProvider.notifier)
                                      .updateCart(
                                          shippingAddressId: address.addressId)
                                      .then((value) {
                                    if (value) {
                                      context.pushRoute(const CheckoutScreen());
                                    }
                                  });
                                }
                              });
                            } else {
                              context.pushRoute(const CheckoutScreen());
                            }
                          },
                          title: S.of(context).proceedToCheckout),
                    );
                  },
                ),
                cart: widget.cart))
      ],
    );
  }
}
