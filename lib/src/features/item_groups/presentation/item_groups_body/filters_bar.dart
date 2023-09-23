import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/filters_drop_down/filters_drop_down_button_form_field.dart';

import 'item_groups_search_field/item_groups_search_field.dart';

class FiltersBar extends ConsumerWidget {
  const FiltersBar({Key? key, this.focusNode}) : super(key: key);
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(child: FiltersDropdownButtonFormField()),
        const SizedBox(width: 8),
        Expanded(
            flex: 2,
            child: Focus(
                focusNode: focusNode, child: const ItemGroupsSearchField()))
      ],
    );
  }
}
