import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_controller.dart';

import '../../../../../common_widgets/search_field.dart';
import '../../../../../theme/app_colors.dart';

class ItemGroupsSearchField extends ConsumerStatefulWidget {
  const ItemGroupsSearchField({Key? key, this.autofocus = false})
      : super(key: key);

  final bool autofocus;

  @override
  ConsumerState<ItemGroupsSearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<ItemGroupsSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(itemGroupsSearchControllerProvider);
    return SearchField(
      autofocus: widget.autofocus,
      controller: _controller,
      suffixIcon: searchQuery != null && searchQuery.isNotEmpty
          ? IconButton(
              onPressed: () {
                _controller.clear();
                ref.read(itemGroupsSearchControllerProvider.notifier).set(null);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(Icons.clear, color: AppColors.darkGray),
            )
          : null,
      onFieldSubmitted: (value) =>
          ref.read(itemGroupsSearchControllerProvider.notifier).set(value),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
