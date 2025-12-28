import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/domain/item_details/product_option.dart';
import 'package:widam/src/features/items/presentation/item_details/product_options_form_key_provider.dart';

import '../../../../theme/app_colors.dart';
import '../../domain/item_details/item_details.dart';


final productOptionsControllerProvider =
    StateProvider<Map<String, String>>((ref) => {});


class ProductOptionsSection extends ConsumerStatefulWidget {
  final List<ProductOption> productOptions;

  const ProductOptionsSection({super.key, required this.productOptions});

  @override
  ConsumerState<ProductOptionsSection> createState() =>
      _ProductOptionsSectionState();
}

class _ProductOptionsSectionState
    extends ConsumerState<ProductOptionsSection> {
  final Map<String, TextEditingController> _controllers = {};

  final _formKey = GlobalKey<FormState>();
  // final Map<String, String> _optionValues = {};

  @override
  void initState() {
    super.initState();
    for (final option in widget.productOptions) {
      final controller = TextEditingController();
      controller.addListener(() {
        ref
            .read(productOptionsControllerProvider.notifier)
            .update((state) => {
                  ...state,
                  option.optionName!: controller.text,
                });
      });
      _controllers[option.optionName!] = controller;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.productOptions;
    if (options.isEmpty) return const SizedBox.shrink();
  final formKey = ref.watch(productOptionsFormKeyProvider);

    return Form(
    key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: options.map((option) => _buildOptionField(option)).toList(),
        ),
      ),
    );
  }

  Widget _buildOptionField(ProductOption option) {
    final controller = _controllers[option.optionName]!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            option.optionName ?? "",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all( 12),
              filled: true,
              hintText: option.hint ?? "...",
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 14, color: AppColors.gray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (option.isMandatory == 1 &&
                  (value == null || value.trim().isEmpty)) {
                return S.of(context).required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
