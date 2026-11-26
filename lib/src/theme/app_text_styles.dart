import 'package:flutter/material.dart';

/// Shared text styles named `Weight + Size`.
///
/// The font family is not part of the name because it comes from the theme
/// and switches with the app language (Qatar for Arabic, Montserrat for
/// English).
abstract final class AppTextStyles {
  static const TextStyle medium11 =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
  static const TextStyle bold11 =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w700);
  static const TextStyle medium12 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle bold12 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
  static const TextStyle regular14 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle bold15 =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
  static const TextStyle bold16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
}
