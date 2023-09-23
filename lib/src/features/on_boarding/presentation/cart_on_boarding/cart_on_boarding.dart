import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:widam/src/features/on_boarding/presentation/step_widget.dart';

import '../../../../../generated/l10n.dart';
import 'is_first_cart_open_controller.dart';

class CartOnBoadring extends ConsumerWidget {
  const CartOnBoadring({super.key, required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstCartOpen = ref.watch(isFirstCartOpenControllerProvider);
    return isFirstCartOpen
        ? _CartOnBoardingBody(child: child)
        : child();
  }
}

class _CartOnBoardingBody extends StatefulWidget {
  const _CartOnBoardingBody({required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  State<_CartOnBoardingBody> createState() => _CartOnBoardingBodyState();
}

class _CartOnBoardingBodyState extends State<_CartOnBoardingBody> {
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
        titleText: S.of(context).nearestTimeSlot,
        bodyText: S.of(context).nearestTimeSlotDescription,
        labelBoxPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        stepBuilder: (context, renderInfo) {
          return StepWidget(
            title: renderInfo.titleText,
            body: renderInfo.bodyText,
            nextStep: renderInfo.nextStep,
            close: renderInfo.close,
          );
        },
      ),
      OnboardingStep(
        focusNode: focusNodes.last,
        titleText: '',
        bodyText: S.of(context).proceedToCheckoutDescription,
        labelBoxPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        stepBuilder: (context, renderInfo) {
          return Consumer(
            builder: (context, ref, child) {
              return StepWidget(
                arrowAlignment: AlignmentDirectional.bottomStart,
                body: renderInfo.bodyText,
                close: () {
                  renderInfo.close();
                  ref
                      .read(isFirstCartOpenControllerProvider.notifier)
                      .setIsFirstCartOpen();
                },
              );
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
