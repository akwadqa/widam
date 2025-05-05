import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_close_button.dart';

class AppDropDownBottomSheet<T> extends StatelessWidget {
  const AppDropDownBottomSheet(
      {super.key,
      required this.onTap,
      required this.items,
      required this.title});
  final void Function(T item) onTap;
  final List<T> items;
  final String Function(T item) title;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: AppCloseButton()),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(title(items[index]),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    onTap: () {
                      onTap(items[index]);
                      context.maybePop();
                    },
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: items.length,
                shrinkWrap: true),
            const SizedBox(height: 10)
          ]),
        ),
      ),
    );
  }
}
