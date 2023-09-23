import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/on_boarding/presentation/item_groups_on_boarding/is_first_item_groups_open_controller.dart';
import 'package:widam/src/features/on_boarding/presentation/step_widget.dart';

class ItemGroupsOnBoadring extends ConsumerWidget {
  const ItemGroupsOnBoadring({super.key, required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstItemGroupsOpen =
        ref.watch(isFirstItemGroupsOpenControllerProvider);
    return isFirstItemGroupsOpen
        ? _ItemGroupsOnBoadringBody(child: child)
        : child(focusNodes: null);
  }
}

class _ItemGroupsOnBoadringBody extends ConsumerStatefulWidget {
  const _ItemGroupsOnBoadringBody({required this.child});

  final Widget Function({List<FocusNode>? focusNodes}) child;

  @override
  ConsumerState<_ItemGroupsOnBoadringBody> createState() =>
      __ItemGroupOnBoadringBodyState();
}

class __ItemGroupOnBoadringBodyState
    extends ConsumerState<_ItemGroupsOnBoadringBody> {
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
        titleText: S.of(context).searchAllProducts,
        bodyText: S.of(context).searchDescription,
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
        titleText: S.of(context).refineYourSearch,
        bodyText: S.of(context).selectItemGroupDescription,
        labelBoxPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        stepBuilder: (context, renderInfo) {
          return StepWidget(
            arrowAlignment: AlignmentDirectional.topStart,
            title: renderInfo.titleText,
            body: renderInfo.bodyText,
            close: () {
              renderInfo.close();
              ref
                  .read(isFirstItemGroupsOpenControllerProvider.notifier)
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
