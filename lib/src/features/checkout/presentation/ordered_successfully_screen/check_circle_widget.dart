import 'package:flutter/material.dart';

class CheckCircleWidget extends StatelessWidget {
  const CheckCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 43.5,
      backgroundColor: Color(0xFFEDF5FB),
      child: CircleAvatar(
        radius: 34.5,
        backgroundColor: Color(0x242AA6DF),
        child: CircleAvatar(
          radius: 24.0,
          backgroundColor: Color(0xFF2AA6DF),
          child: Icon(
            Icons.check,
            color: Color(0xFFF6F9F6),
            size: 30,
          ),
        ),
      ),
    );
  }
}
