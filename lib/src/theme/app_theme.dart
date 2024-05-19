import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';

import '../../gen/fonts.gen.dart';
import 'app_colors.dart';

part 'app_theme.g.dart';

abstract class AppTheme {
  static ThemeData lightTheme(String fontFamily) {
    return ThemeData(
      useMaterial3: false,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.raisinBlack,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: AppColors.raisinBlack,
              fontSize: 18,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) =>
              states.contains(WidgetState.disabled)
                  ? AppColors.silver
                  : AppColors.primary),
          textStyle: WidgetStatePropertyAll(TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: fontFamily,
              fontSize: 16)),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        hintStyle: TextStyle(
            color: AppColors.gray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: fontFamily),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle:
                  WidgetStateProperty.all(TextStyle(fontFamily: fontFamily)))),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primary),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.primary.toMaterialColor())
          .copyWith(secondary: AppColors.secondary),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: AppColors.lightGrayishCyan,
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 14, fontFamily: fontFamily),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(
          color: AppColors.silver,
          width: 0.5,
        ),
        showCheckmark: false,
        disabledColor: AppColors.brightGray,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.darkBlue,
        unselectedLabelColor: Colors.black,
        labelStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, fontFamily: fontFamily),
        unselectedLabelStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w400, fontFamily: fontFamily),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.darkBlue,
            width: 2,
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.secondary),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      )),
    );
  }

  static UnderlineInputBorder get _outlineInputBorder =>
      const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.darkBlue,
          width: 0.5,
        ),
      );
}

@Riverpod(keepAlive: true)
ThemeData themeData(ThemeDataRef ref) =>
    AppTheme.lightTheme(ref.watch(fontFamilyProvider));

@Riverpod(keepAlive: true)
String fontFamily(FontFamilyRef ref) =>
    (ref.watch(currentLanguageProvider) == 'en'
        ? FontFamily.montserrat
        : FontFamily.qatar);
