import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF0050B3);
  static const Color darkBlue = Color(0xFF003B82);
  static const Color secondary = Color(0xFF2BB9ED);
  static const Color gray = Color(0xFF707070);
  static const Color paleGray = Color(0xFFF7F6FA);
  static const Color red = Color(0xFFEF3E42);
  static const Color darkGray = Color(0xFF444444);
  static const Color lightGray = Color(0xFFF9F9F9);
  static const Color orange = Color(0xFFF78F1E);
  static const Color darkOrange = Color(0xFFeb8c42);
  static const Color pink = Color(0xFFB90044);
  static const Color raisinBlack = Color(0xFF232323);
  static const Color whisper = Color(0xFFE9E9E9);
  static const Color cultured = Color(0xFFF6F6F6);
  static const Color brightGray = Color(0xFFEEEEEE);
  static const Color screamingGrey = Color(0xFFAAAAAA);
  static const Color lightGrayishRed = Color(0xFFFCDDD6);
  static const Color taupeGray = Color(0xFF888888);
  static const Color sunsetOrange = Color(0xFFFF4848);
  static const Color lightGrayishCyan = Color(0xFFEFF8FB);
  static const Color spanishGray = Color(0xFF949494);
  static const Color redOrange = Color(0xFFF5866C);
  static const Color midnightBlue = Color(0xFF004990);
  static const Color antiFlashWhite = Color(0xFFF1F1F1);
  static const Color blue = Color(0xFFF8FCFD);
  static const Color silver = Color(0xFFBBBBBB);
  static const Color lapisBlue = Color(0xFF00488F);
  static const Color gainsboro = Color(0xFFDDDDDD);
  static const Color vividCerulean = Color(0xFF00AEEF);
  static const Color cyan = Color(0xFFB9C5CA);
  static const Color londonRain = Color(0xFF0055BB);
  static const Color whiteSmoke = Color(0xFFF5F5F5);
  static const Color carminePink = Color(0xFFEF3E42);
  static const Color babyBlue = Color(0xFFD8EEFE);
  static const Color philippineSilver = Color(0xFFB4B4B4);
  static const Color veryLightcyan = Color(0xFFF4FBFB);
  static const Color mediumGray = Color(0xFFBEBEBE);
  static const Color lightBlue = Color(0xFFF4FCFE);
  static const Color lightGrayishBlue = Color(0xFFF7F9FE);
  static const Color feijoa = Color(0xFFB4D88B);
  static const Color aliceBlue = Color(0xFFE7F4F9);
  static const Color summerdayBlue = Color(0xFF47C0EC);
  static const Color goldenBrown = Color(0xFFDDA33E);
  static const Color ghostWhite = Color(0xFFF5FBFF);
  static const Color pattensBlue = Color(0xFFDDEAF2);
  static const Color candyAppleRed = Color(0xFFFF313B);
  static const Color customBlue = Color(0xFFCEEAFD);
  static const Color lightgrayishBlue = Color(0xFFE7F2F9);

  static Color hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

extension ColorExtension on Color {
  MaterialColor toMaterialColor() {
    return MaterialColor(value, {
      50: withOpacity(0.1),
      100: withOpacity(0.2),
      200: withOpacity(0.3),
      300: withOpacity(0.4),
      400: withOpacity(0.5),
      500: withOpacity(0.6),
      600: withOpacity(0.7),
      700: withOpacity(0.8),
      800: withOpacity(0.9),
      900: withOpacity(1),
    });
  }
}
