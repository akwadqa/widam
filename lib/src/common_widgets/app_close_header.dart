import 'package:flutter/material.dart';

import 'app_close_button.dart';

class AppCloseHeader extends StatelessWidget {
  const AppCloseHeader(
      {super.key,
      required this.title,
      required this.content,
      this.withDivider = true});

  final String title;
  final Widget content;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18)),
                )),
            const Expanded(
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: AppCloseButton(width: 40, height: 40)))
          ],
        ),
        if (withDivider) const Divider(),
        content
      ]),
    );
  }
}
