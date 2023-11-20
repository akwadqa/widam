import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_options/saved_options_provider.dart';
import 'package:widam/src/features/recommendations/data/recommendations_repository.dart';
import 'package:widam/src/features/recommendations/presentation/frequently_bought_together/frequently_bought_together_controller.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd_controller.dart';
import 'package:widam/src/features/recommendations/presentation/similar_items/similar_items_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../auth/application/user_data_provider.dart';
import '../../../../../routing/app_router.gr.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import 'mubadara_fields.dart';
import 'quantity_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../common_widgets/submit_button.dart';
import '../../../../cart/application/cart_service.dart';
import '../item_details_controller.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget(
      {super.key,
      required this.itemId,
      required this.optionsFromKey,
      this.attributionToken});
  final String itemId;
  final GlobalKey<FormState> optionsFromKey;
  final String? attributionToken;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(-2, -2),
              blurRadius: 16,
            ),
          ],
        ),
        padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 20 + getBottomPadding(context)),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(itemDetailsControllerProvider);
            final userToken = ref.watch(userDataProvider);
            ref.listen(updateCartProvider, (previous, next) async {
              if (next is AsyncError) {
                showAppBannerDialog(
                    context, next.error.toString(), next.stackTrace);
              } else if (next is AsyncData) {
                context.popRoute();
                ref.read(goToTabControllerProvider.notifier).showCartDialog();
              }
            });
            final updateCartState = ref.watch(updateCartProvider);
            if (updateCartState is AsyncLoading) {
              return const FadeCircleLoadingIndicator();
            }
            return SubmitButton(
              text: S.of(context).addToCart,
              onPressed: userToken == null
                  ? () => context.pushRoute(const LoginScreen())
                  : state is AsyncData &&
                          state.asData?.value != null &&
                          state.asData!.value!.isLoading
                      ? null
                      : () {
                          if (ref.read(canVibrateProvider)) {
                            Vibrate.feedback(FeedbackType.heavy);
                          }
                          if (optionsFromKey.currentState != null) {
                            if (optionsFromKey.currentState!.validate()) {
                              optionsFromKey.currentState!.save();
                              final productOptions =
                                  ref.read(savedOptionsProvider);
                              final savedOptions = productOptions.isNotEmpty
                                  ? productOptions
                                  : null;
                              _addToCart(
                                  ref: ref,
                                  savedOptions: savedOptions,
                                  attributionToken: attributionToken);
                            }
                          } else {
                            _addToCart(
                                ref: ref, attributionToken: attributionToken);
                          }
                        },
            );
          },
        ));
  }

  void _addToCart(
      {required WidgetRef ref,
      List<({int isPriceModifier, String productOptionId, int radioOptionId})>?
          savedOptions,
      String? attributionToken}) {
    final mubadaraFormKey = ref.read(mubadaraFormKeyProvider);
    if (mubadaraFormKey.currentState != null) {
      if (mubadaraFormKey.currentState!.validate() == false) {
        return;
      } else {
        ref.read(mubadaraFormKeyProvider).currentState!.save();
        ref.read(updateCartProvider.notifier).updateCart(
              attributionToken: attributionToken,
              itemId: itemId,
              quantity: ref.read(quantityProvider),
              qid: ref.read(qidNumberProvider).isEmpty
                  ? null
                  : ref.read(qidNumberProvider),
              file: ref.read(qidAttachmentProvider),
              productOptions: savedOptions,
            );
      }
    } else {
      ref.read(updateCartProvider.notifier).updateCart(
          itemId: itemId,
          quantity: ref.read(quantityProvider),
          productOptions: savedOptions,
          attributionToken: attributionToken);
    }
    ref.invalidate(recentlyViewdControllerProvider);
    ref.invalidate(similarItemsControllerProvider);
    ref.invalidate(recommendationsProvider);
    ref
        .read(frequentlyBoughtTogetherControllerProvider.notifier)
        .getFrequencyBoughtTogether(itemId, ref.read(quantityProvider));
  }
}
