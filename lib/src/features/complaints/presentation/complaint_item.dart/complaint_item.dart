import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/complaints/domain/complaint/complaint.dart';
import 'package:widam/src/theme/app_colors.dart';

class ComplaintItem extends StatelessWidget {
  const ComplaintItem({super.key, required this.complaint});
  final Complaint complaint;
  @override
  Widget build(BuildContext context) {
    final complaintDateTime =
        '${complaint.openingDate}  ${complaint.openingTime}';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(complaint.issueId,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
      const SizedBox(height: 5),
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.londonRain, width: 0.5)),
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(complaint.issueType,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.londonRain)),
              const SizedBox(height: 10.0),
              _ChatBubble(
                  description: complaint.description,
                  date: complaintDateTime,
                  type: BubbleType.sendBubble),
              if (complaint.resolutionDetails != null) ...[
                const SizedBox(height: 15.0),
                _ChatBubble(
                    description: complaint.resolutionDetails!,
                    date: complaintDateTime,
                    type: BubbleType.receiverBubble),
              ]
            ]),
          ),
          PositionedDirectional(
              top: -10,
              end: 10,
              child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: AppColors.londonRain,
                      borderRadius: BorderRadius.circular(2.0)),
                  child: Text(complaint.status,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))))
        ],
      )
    ]);
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble(
      {required this.type, required this.description, required this.date});
  final BubbleType type;
  final String description;
  final String date;
  @override
  Widget build(BuildContext context) {
    final isReceiver = type == BubbleType.receiverBubble;
    return ChatBubble(
        elevation: 0,
        clipper: ChatBubbleClipper3(type: type),
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        backGroundColor:
            isReceiver ? AppColors.pattensBlue2 : AppColors.whisper,
        child: Column(
          children: [
            if (isReceiver) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(S.of(context).widam,
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ),
              const SizedBox(height: 5.0)
            ],
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(description,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: _textColor(isReceiver))),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(date,
                  style:
                      TextStyle(fontSize: 12.0, color: _textColor(isReceiver))),
            )
          ],
        ));
  }

  Color _textColor(bool isReceiver) {
    return isReceiver ? AppColors.gray : Colors.black;
  }
}
