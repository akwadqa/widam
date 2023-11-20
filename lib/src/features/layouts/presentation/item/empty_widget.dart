import 'dart:developer';

import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({super.key, this.message, this.stackTrace});

  final String? message;
  final StackTrace? stackTrace;

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  void initState() {
    if (widget.message != null) log(widget.message!);
    if (widget.stackTrace != null) log(widget.stackTrace.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
