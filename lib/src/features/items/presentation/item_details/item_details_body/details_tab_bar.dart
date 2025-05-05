import 'package:flutter/material.dart';
import '../../../domain/item_details/item_details.dart';
import '../../../domain/item_specification/item_specification.dart';
import '../../../../../theme/app_colors.dart';

import '../../../../../../generated/l10n.dart';

class DetailsTabBar extends StatelessWidget {
  const DetailsTabBar({super.key, required this.itemDetails});
  final ItemDetails itemDetails;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: DefaultTabController(
        length: itemDetails.websiteSpecifications.isEmpty ? 1 : 2,
        child: Container(
          color: AppColors.whiteSmoke,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(tabs: [
                if (itemDetails.shortDescription.isNotEmpty)
                  Tab(text: S.of(context).description),
                if (itemDetails.websiteSpecifications.isNotEmpty)
                  Tab(text: S.of(context).specifications),
              ]),
              Expanded(
                child: TabBarView(children: [
                  if (itemDetails.shortDescription.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: SingleChildScrollView(
                          child: Text(itemDetails.shortDescription,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.raisinBlack,
                                  height: 1.7))),
                    ),
                  if (itemDetails.websiteSpecifications.isNotEmpty)
                    ListView.builder(
                      itemCount: itemDetails.websiteSpecifications.length,
                      itemBuilder: (context, index) {
                        final specification =
                            itemDetails.websiteSpecifications[index];
                        return _RowItem(
                          itemSpecification: specification,
                          color: index.isOdd ? Colors.white : null,
                        );
                      },
                    ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.itemSpecification, this.color});
  final ItemSpecification itemSpecification;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 13, color: Colors.black),
        child: Row(
          children: [
            Expanded(child: Center(child: Text(itemSpecification.label))),
            Expanded(
                child: Center(
                    child: Text(itemSpecification.description,
                        style: const TextStyle(fontWeight: FontWeight.w500)))),
          ],
        ),
      ),
    );
  }
}
