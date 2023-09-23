import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
            onPressed: onPressed, style: _buttonStyle(context), child: _text));
  }

  Text get _text => Text(text.toUpperCase());

  ButtonStyle _buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width, 50),
      backgroundColor: backgroundColor);
}
