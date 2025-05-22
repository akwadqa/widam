import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../theme/app_colors.dart';

final quantityProvider = StateProvider<int>((ref) => 1);

class QuantityFormField extends ConsumerWidget {
  const QuantityFormField({
    super.key,
    required this.minQty,
    required this.maxQty,
  });

  final int minQty;
  final int maxQty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: quantity > minQty
                ? () => ref
                    .read(quantityProvider.notifier)
                    .update((state) => state - 1)
                : null,
            icon: const Icon(
              Icons.remove_rounded,
            ),
            color: AppColors.londonRain,
          ),
          const _VerticalDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 0),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.londonRain,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const _VerticalDivider(),
          IconButton(
            onPressed: quantity < maxQty
                ? () => ref
                    .read(quantityProvider.notifier)
                    .update((state) => state + 1)
                : null,
            icon: const Icon(
              Icons.add,
            ),
            color: AppColors.londonRain,
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
        indent: 10, endIndent: 10, color: AppColors.cyan);
  }
}
