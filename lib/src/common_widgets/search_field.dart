import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      this.suffixIcon,
      this.fillColor = AppColors.cultured,
      this.hintText,
      this.height = 40,
      this.controller,
      this.onFieldSubmitted,
      this.readOnly = false,
      this.onTap,
      this.autofocus = false});
  final Widget? suffixIcon;
  final Color fillColor;
  final String? hintText;
  final double? height;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        autofocus: autofocus,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? S.of(context).search,
          hintStyle: const TextStyle(color: AppColors.darkGray, fontSize: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Assets.icons.searchIcon.svg(),
          ),
          filled: true,
          fillColor: fillColor,
          border: _outlineInputBorder,
          enabledBorder: _outlineInputBorder,
          suffixIcon: suffixIcon,
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      );
}
