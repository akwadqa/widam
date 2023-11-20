import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class TimeSlotContainer extends StatelessWidget {
  const TimeSlotContainer(
      {super.key,
      required this.formattedDate,
      required this.formattedTime,
      this.onTap});

  final String formattedDate;
  final String formattedTime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.paleGray,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsetsDirectional.only(
            start: 2, end: 4, top: 4, bottom: 4),
        child: TimeSlotRow(
            formattedDate: formattedDate,
            formattedTime: formattedTime,
            onTap: onTap));
  }
}

class TimeSlotRow extends StatelessWidget {
  const TimeSlotRow({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
    this.onTap,
  });

  final String formattedDate;
  final String formattedTime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            padding: const EdgeInsets.all(4),
            child: Text(_getFormattedDate(formattedDate, context),
                style: const TextStyle(
                    color: AppColors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          const SizedBox(width: 8),
          Text(formattedTime,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          if (onTap != null) ...[
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, color: Colors.black, size: 16)
          ]
        ],
      ),
    );
  }

  String _getFormattedDate(String fulldate, BuildContext context) {
    if (fulldate.isEmpty) return '';
    List<String> parts = fulldate.split(', ');
    String day = parts[0];
    String date = parts[1].split(' ')[0];
    return '$day${Directionality.of(context) == TextDirection.rtl ? '،' : ','} $date';
  }
}
