import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class SwitchContainer extends StatelessWidget {
  const SwitchContainer(
      {super.key,
      required this.title,
      required this.description,
      required this.onPressed});

  final String title;
  final String description;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.orange.shade50,
      ),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 5),
            child: Text(
              description,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500),
              maxLines: 2,
              softWrap: true,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              foregroundColor: AppColors.carminePink,
              textStyle:
                  const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
          child: Text(title),
        )
      ]),
    );
  }
}
