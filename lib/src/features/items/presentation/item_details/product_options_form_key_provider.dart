// product_options_form_key_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_options_form_key_provider.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<FormState> productOptionsFormKey(Ref ref) =>
    GlobalKey<FormState>();
