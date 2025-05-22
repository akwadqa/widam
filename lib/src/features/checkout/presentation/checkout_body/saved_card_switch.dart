import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/saved_card_value_controller.dart';

import '../../../../../generated/l10n.dart';

class SavedCardSwitch extends StatelessWidget {
  const SavedCardSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _Switch(),
        const SizedBox(width: 4),
        Text(S.of(context).saveCardForFutureOrders,
            style: const TextStyle(fontWeight: FontWeight.w500))
      ],
    );
  }
}

class _Switch extends ConsumerWidget {
  const _Switch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(savedCardValueControllerProvider);
    return Switch.adaptive(
        value: value,
        onChanged:
            ref.read(savedCardValueControllerProvider.notifier).onChanged);
  }
}
