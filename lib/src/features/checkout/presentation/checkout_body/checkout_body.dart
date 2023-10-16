import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/checkout_scroll_controller.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/saved_card_switch.dart';
import 'package:widam/src/features/time_slots/domain/geofence_details/time_slot.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../common_widgets/app_stacked_loading_indicator.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../utils/utils.dart';
import '../../../coupons/presentaion/coupon_code_selector/coupon_code_selector.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/change_button.dart';
import '../../../../common_widgets/total_container.dart';
import '../../../../theme/app_colors.dart';
import '../../../addresses/domain/address/address.dart';
import '../../../addresses/presentation/addresses/address_card.dart';
import '../../../addresses/presentation/addresses/addresses_selector/addresses_selector.dart';
import '../../../cart/application/cart_service.dart';
import '../../../cart/domain/cart/cart.dart';
import '../../../cart/domain/cart/cart_content.dart';
import '../../../cart/presentation/cart_body/cart_controller.dart';
import '../../../time_slots/presentation/time_slots_selector/time_slots_selector.dart';
import 'checkout_button.dart';
import 'delivery_container.dart';
import 'order_summary_container.dart';
import '../../../payment_methods/presentation/payment_method_selector/payment_method_selector.dart';

class CheckoutBody extends ConsumerStatefulWidget {
  const CheckoutBody({super.key});
  @override
  ConsumerState<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends ConsumerState<CheckoutBody> {
  @override
  void initState() {
    Future(() {
      final cart = ref.read(cartControllerProvider).asData!.value!;
      showAdaptiveModalBottomSheet<({TimeSlot timeSlot, String deliveryDate})?>(
          context: context,
          builder: (ctx) {
            return TimeSlotsSelector(
                deleiveryType: (cart.cartContent as CartContent)
                    .normalDelivery!
                    .deliveryMethodTitle,
                initialDate: (cart.cartContent as CartContent)
                    .normalDelivery!
                    .deliveryDate
                    .date,
                initialTimeSlot:
                    (cart.cartContent as CartContent).normalDelivery!.timeSlot);
          }).then((value) {
        if (value != null) {
          ref.read(updateCartProvider.notifier).updateCart(
              timeSlot: value.timeSlot.timeSlotId,
              deliveryDate: value.deliveryDate);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartControllerProvider);
    return cartAsync.when(
        data: (cart) {
          return ProviderScope(
            overrides: [
              updateCartProvider.overrideWith(() => UpdateCart()),
            ],
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    controller: ref.watch(checkoutScrollControllerProvider),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _UpdatableCartContentContainer(
                            cart: cart!,
                            titlesTextStyle: _textStyle()),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).orderSummary,
                                  style: _textStyle()),
                              const SizedBox(height: 8.0),
                              OrderSummaryContainer(cart: cart),
                              const SizedBox(height: 20.0),
                              Text(S.of(context).reviewYourOrder,
                                  style: _textStyle()),
                              const SizedBox(height: 8.0),
                              if (cart.cartContent is CartContent) ...[
                                if ((cart.cartContent as CartContent)
                                        .normalDelivery !=
                                    null) ...[
                                  DeliveryContainer(
                                      currency: cart.currency,
                                      deliveryType:
                                          (cart.cartContent as CartContent)
                                              .normalDelivery!),
                                  const SizedBox(height: 15.0),
                                ],
                                if ((cart.cartContent as CartContent)
                                        .expressDelivery !=
                                    null) ...[
                                  DeliveryContainer(
                                      currency: cart.currency,
                                      deliveryType:
                                          (cart.cartContent as CartContent)
                                              .expressDelivery!),
                                  const SizedBox(height: 15.0),
                                ],
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 150.0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TotalContainer(
                        orderTotal: cart.grandTotal,
                        button: CheckoutButton(cart: cart),
                        cart: cart))
              ],
            ),
          );
        },
        error: (error, st) =>
            AppBanner(message: error.toString(), stackTrace: st),
        loading: () => const FadeCircleLoadingIndicator());
  }

  TextStyle _textStyle() => const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15.0);
}

class _UpdatableCartContentContainer extends ConsumerStatefulWidget {
  const _UpdatableCartContentContainer(
      {required this.cart,
      required this.titlesTextStyle});
  final Cart cart;
  final TextStyle titlesTextStyle;
  @override
  ConsumerState<_UpdatableCartContentContainer> createState() =>
      _UpdatableCartContentContainerState();
}

class _UpdatableCartContentContainerState
    extends ConsumerState<_UpdatableCartContentContainer> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppStackedLoadingIndicator(
      isLoading: ref.watch(updateCartProvider).isLoading,
      child: _UpdatableCartContent(
        key: _key,
        cart: widget.cart,
        titlesTextStyle: widget.titlesTextStyle,
      ),
    );
  }
}

class _UpdatableCartContent extends ConsumerWidget {
  const _UpdatableCartContent(
      {super.key,
      required this.cart,
      required this.titlesTextStyle});
  final Cart cart;
  final TextStyle titlesTextStyle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(updateCartProvider, (previous, next) {
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).shipTo, style: titlesTextStyle),
                  ChangeButton(onPressed: () {
                    showAdaptiveModalBottomSheet<Address?>(
                            context: context,
                            builder: (ctx) => const AddressesSelector())
                        .then((Address? address) {
                      if (address != null) {
                        ref
                            .read(updateCartProvider.notifier)
                            .updateCart(
                              shippingAddressId: address.addressId,
                            )
                            .then((value) {
                          if (value == true) {
                            if (context.mounted) {
                              showAdaptiveModalBottomSheet<
                                      ({
                                        TimeSlot timeSlot,
                                        String deliveryDate
                                      })?>(
                                  context: context,
                                  builder: (ctx) {
                                    return TimeSlotsSelector(
                                        deleiveryType:
                                            (cart.cartContent as CartContent)
                                                .normalDelivery!
                                                .deliveryMethodTitle,
                                        initialDate:
                                            (cart.cartContent as CartContent)
                                                .normalDelivery!
                                                .deliveryDate
                                                .date,
                                        initialTimeSlot:
                                            (cart.cartContent as CartContent)
                                                .normalDelivery!
                                                .timeSlot);
                                  }).then((value) {
                                if (value != null) {
                                  ref
                                      .read(updateCartProvider.notifier)
                                      .updateCart(
                                          timeSlot: value.timeSlot.timeSlotId,
                                          deliveryDate: value.deliveryDate);
                                }
                              });
                            }
                          }
                        });
                      }
                    });
                  })
                ],
              ),
              const SizedBox(height: 5.0),
              AddressCard(address: cart.shippingAddressDetails!),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).paymentMethod, style: titlesTextStyle),
                  if (cart.paymentMethod != null)
                    ChangeButton(
                        onPressed: () =>
                            _showPaymentMethodSelector(context, ref))
                ],
              ),
              const SizedBox(height: 5.0),
              InkWell(
                onTap: () => _showPaymentMethodSelector(context, ref),
                child: _PaymentMethodCard(cart: cart),
              ),
              if (cart.paymentMethod?.gatewaySettings ==
                      'CyberSource Secure Acceptance Settings' &&
                  cart.savedCard == null) ...[
                const SizedBox(height: 10),
                const SavedCardSwitch(),
              ]
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        InkWell(
          onTap: cart.couponCode == null
              ? () {
                  showAdaptiveModalBottomSheet<String?>(
                          context: context,
                          builder: (context) => const CouponCodeSelector())
                      .then((couponCodeId) {
                    if (couponCodeId != null) {
                      ref
                          .read(updateCartProvider.notifier)
                          .updateCart(couponCode: couponCodeId);
                    }
                  });
                }
              : null,
          child: Container(
            color: AppColors.cultured,
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Assets.icons.discountIcon.svg(),
                  const SizedBox(width: 10.0),
                  Text(cart.couponCode ?? S.of(context).applyCoupon,
                      style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  if (cart.couponCode != null) ...[
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          ref
                              .read(updateCartProvider.notifier)
                              .updateCart(couponCode: '');
                        },
                        child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.red,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 14)))
                  ]
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPaymentMethodSelector(BuildContext context, WidgetRef ref) {
    showAdaptiveModalBottomSheet<(bool, String, String?)?>(
            context: context,
            builder: (context) => PaymentMethodSelector(
                selectedPaymentMethodId: cart.paymentMethod?.paymentMethodId,
                selectedPaymentTokenId: cart.savedCard?.paymentTokenId))
        .then(((bool, String, String?)? paymentData) {
      if (paymentData != null) {
        ref.read(updateCartProvider.notifier).updateCart(
            useWalletBalance: paymentData.$1 ? 1 : 0,
            paymentMethodId: paymentData.$2,
            paymentTokenId: paymentData.$3,
            paymentToken: paymentData.$3 != null ? 1 : null);
      }
    });
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        border: Border.all(color: AppColors.primary, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        children: [
          cart.paymentMethod != null
              ? AppCachedNetworkImage(
                  imageUrl: cart.savedCard?.icon ?? cart.paymentMethod!.icon,
                  height: 20.0)
              : Assets.icons.cardIcon.svg(),
          const SizedBox(width: 10.0),
          Text(
              cart.savedCard != null
                  ? '${S.of(context).cardEndingIn} ${cart.savedCard!.cardNumber.substring(cart.savedCard!.cardNumber.length - 4)}'
                  : cart.paymentMethod?.title ??
                      S.of(context).addAPaymentMethod,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))
        ],
      ),
    );
  }
}
