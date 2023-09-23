import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../domain/tag/tag.dart';

class ItemTagLabelList extends StatelessWidget {
  const ItemTagLabelList(
      {super.key, required this.tags, this.oppositeDirection = false});
  final List<Tag> tags;
  final bool oppositeDirection;
  @override
  Widget build(BuildContext context) {
    final newTags = tags.where((element) => element.productLabel == 1).toList();
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.hexToColor(newTags[index].color!),
            borderRadius: oppositeDirection
                ? const BorderRadiusDirectional.only(
                    topStart: Radius.circular(2),
                    bottomStart: Radius.circular(2),
                  )
                : const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(2),
                    bottomEnd: Radius.circular(2),
                  ),
          ),
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Text(newTags[index].title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 4),
      itemCount: newTags.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
