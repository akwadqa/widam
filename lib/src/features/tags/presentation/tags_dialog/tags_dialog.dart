import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_close_header.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/tags/data/tags_repository.dart';
import 'package:widam/src/features/tags/presentation/tags_dialog/tag_item.dart';

class TagsDialog extends StatelessWidget {
  const TagsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCloseHeader(
      title: S.of(context).productLabels,
      content: const _ProductLabelsList(),
    );
  }
}

class _ProductLabelsList extends ConsumerWidget {
  const _ProductLabelsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider);
    return tagsAsync.when(
      data: (tags) {
        final newTags =
            tags.where((element) => element.productLabel == 0).toList();
        return SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8,
                mainAxisExtent: 150,
                childAspectRatio: 1 / 4),
            itemBuilder: (context, index) {
              return TagItem(tag: newTags[index], iconSize: 40);
            },
            itemCount: newTags.length,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            shrinkWrap: true,
          ),
        );
      },
      error: (error, stackTrace) =>
          AppBanner(message: error.toString(), stackTrace: stackTrace),
      loading: () => const FadeCircleLoadingIndicator(),
    );
  }
}
