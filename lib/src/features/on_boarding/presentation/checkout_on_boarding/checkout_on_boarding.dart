import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/checkout_scroll_controller.dart';

import '../../../../../generated/l10n.dart';
import '../step_widget.dart';
import 'is_first_checkout_open_controller.dart';

class CheckoutOnBoadring extends ConsumerWidget {
  const CheckoutOnBoadring({super.key, required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstCheckoutOpen =
        ref.watch(isFirstCheckoutOpenControllerProvider);
    return isFirstCheckoutOpen
        ? _CheckoutOnBoardingBody(child: child)
        : child(focusNodes: null);
  }
}

class _CheckoutOnBoardingBody extends ConsumerStatefulWidget {
  const _CheckoutOnBoardingBody({required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  ConsumerState<_CheckoutOnBoardingBody> createState() =>
      _CheckoutOnBoardingBodyState();
}

class _CheckoutOnBoardingBodyState
    extends ConsumerState<_CheckoutOnBoardingBody> {
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    focusNodes = List<FocusNode>.generate(
      2,
      (int i) => FocusNode(debugLabel: 'Onboarding Focus Node $i'),
      growable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Onboarding(steps: [
      OnboardingStep(
        focusNode: focusNodes.first,
        titleText: '',
        bodyText: S.of(context).paymentMethodDescription,
        labelBoxPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        stepBuilder: (context, renderInfo) {
          return StepWidget(
            body: renderInfo.bodyText,
            nextStep: () async {
              await ref
                  .read(checkoutScrollControllerProvider.notifier)
                  .scrollToTheEndOfTheScreen();
              renderInfo.nextStep();
            },
            close: renderInfo.close,
          );
        },
      ),
      OnboardingStep(
        focusNode: focusNodes.last,
        titleText: '',
        bodyText: S.of(context).timeSlotChangerDescription,
        labelBoxPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        stepBuilder: (context, renderInfo) {
          return StepWidget(
            arrowAlignment: AlignmentDirectional.bottomEnd,
            body: renderInfo.bodyText,
            close: () {
              renderInfo.close();
              ref
                  .read(isFirstCheckoutOpenControllerProvider.notifier)
                  .setIsFirstCartOpen();
            },
          );
        },
      ),
    ], child: widget.child(focusNodes: focusNodes));
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
