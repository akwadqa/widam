import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/mubadara_fields/qid_attachment_controller.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_form_field/slotter_fees_controller.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_form_field/slotter_fees_form_field.dart';
import 'package:widam/src/features/recommendations/presentation/frequently_bought_together/frequently_bought_together_controller.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd_controller.dart';
import 'package:widam/src/features/recommendations/presentation/similar_items/similar_items_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../auth/application/user_data_provider.dart';
import '../../../../../routing/app_router.gr.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import 'mubadara_fields/mubadara_fields.dart';
import 'mubadara_fields/qid_number_controller.dart';
import 'quantity_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/submit_button.dart';
import '../../../../cart/application/cart_service.dart';
import '../item_details_controller.dart';

enum FormType { variants, options }

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    required this.itemId,
    this.attributionToken,
    required this.hasVariants,
    required this.attributesFormKey,
    required this.onInvalidForm,
  });

  final String itemId;
  final String? attributionToken;
  final GlobalKey<FormState> attributesFormKey;
  final bool hasVariants;
  final Function(FormType) onInvalidForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: _buildPadding(context),
      child: Consumer(
        builder: (context, ref, child) => _buildSubmitButton(context, ref),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(-2, -2),
          blurRadius: 16,
        ),
      ],
    );
  }

  EdgeInsets _buildPadding(BuildContext context) {
    return EdgeInsets.only(
      top: 20,
      right: 20,
      left: 20,
      bottom: 20 + getBottomPadding(context),
    );
  }

  Widget _buildSubmitButton(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailsControllerProvider);
    final updateCartState = ref.watch(updateCartProvider);

    _listenForUpdateCart(ref, context);

    if (updateCartState is AsyncLoading) {
      return const FadeCircleLoadingIndicator();
    }

    return SubmitButton(
      text: S.of(context).addToCart,
      onPressed: _determineButtonAction(state, ref, context),
    );
  }

  VoidCallback? _determineButtonAction(
      AsyncValue state, WidgetRef ref, BuildContext context) {
    final userToken = ref.watch(userDataProvider);
    if (userToken == null) {
      return () => context.pushRoute(const LoginScreen());
    }

    if (state is AsyncData &&
        state.asData?.value != null &&
        state.asData!.value!.isLoading) {
      return null;
    }

    return () => _onSubmitPressed(ref);
  }

  void _onSubmitPressed(WidgetRef ref) {
    if (ref.read(canVibrateProvider).requireValue) {
      Vibrate.feedback(FeedbackType.heavy);
    }

    if (attributesFormKey.currentState?.validate() ?? true) {
      _addToCart(ref: ref, attributionToken: attributionToken);
    } else {
      onInvalidForm(FormType.variants);
    }
  }

  void _addToCart({
    required WidgetRef ref,
    String? attributionToken,
  }) {
    final slotterFeesFormKey = ref.read(slotterFeesFormKeyProvider);
    if (slotterFeesFormKey.currentState != null &&
        !slotterFeesFormKey.currentState!.validate()) {
      return;
    }

    final mubadaraFormKey = ref.read(mubadaraFormKeyProvider);
    if (mubadaraFormKey.currentState != null &&
        !mubadaraFormKey.currentState!.validate()) {
      return;
    }

    mubadaraFormKey.currentState?.save();

    ref.read(updateCartProvider.notifier).updateCart(
        itemId: itemId,
        quantity: ref.read(quantityProvider),
        qid: ref.read(qidNumberControllerProvider).isEmpty
            ? null
            : ref.read(qidNumberControllerProvider),
        file: ref.read(qidAttachmentControllerProvider),
        attributionToken: attributionToken,
        isPriceModifier: ref.read(slotterFeesControllerProvider));

    _invalidateRecommendationProviders(ref);
  }

  void _invalidateRecommendationProviders(WidgetRef ref) {
    if (ref.exists(recentlyViewdControllerProvider(itemId))) {
      ref.invalidate(recentlyViewdControllerProvider);
      ref.invalidate(similarItemsControllerProvider);
    }
    ref
        .read(frequentlyBoughtTogetherControllerProvider.notifier)
        .getFrequencyBoughtTogether(itemId, ref.read(quantityProvider));
  }

  void _listenForUpdateCart(WidgetRef ref, BuildContext context) {
    ref.listen(updateCartProvider, (previous, next) async {
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      } else if (next is AsyncData) {
        context.maybePop();
        ref.read(goToTabControllerProvider.notifier).showCartDialog();
      }
    });
  }
}
