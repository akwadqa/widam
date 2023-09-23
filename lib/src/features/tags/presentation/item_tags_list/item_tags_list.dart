import 'package:flutter/material.dart';
import 'package:widam/src/features/tags/presentation/tags_dialog/tags_dialog.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../domain/tag/tag.dart';

class ItemTagsList extends StatelessWidget {
  const ItemTagsList({Key? key, required this.tags, this.size = 30})
      : super(key: key);
  final List<Tag> tags;
  final double size;
  @override
  Widget build(BuildContext context) {
    final newTags = tags.where((element) => element.productLabel == 0).toList();
    return ListView.separated(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: TagsDialog(),
                      ));
            },
            child: AppCachedNetworkImage(
                imageUrl: newTags[index].icon!,
                fit: BoxFit.fitHeight,
                height: size,
                width: size));
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 4),
      itemCount: newTags.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }
}
