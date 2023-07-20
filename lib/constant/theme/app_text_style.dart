import 'dart:ui';

import 'package:flutter/material.dart';

import '../enum/style_enum.dart';
import 'app_colors.dart';

class AppTextStyle{
  const AppTextStyle._();

  static TextStyle homeTitleStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? textDecoration,
  TextOverflow? overflow,
  })
  {
    return TextStyle(
    color: color?? AppColors.textBlack,
    fontSize: fontSize?? 14,
    fontWeight: fontWeight?? FontWeight.w600,
    fontStyle: fontStyle?? FontStyle.normal,
    decoration: textDecoration,
    overflow: overflow);
  }

  static baseStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
  })
  {
    return TextStyle(
      color: color?? Color(0xFF666666),
      fontSize: fontSize?? 12,
      fontWeight: fontWeight?? FontWeight.w400,
      fontStyle: fontStyle?? FontStyle.normal,
      decoration: textDecoration,
      overflow: overflow);
  }
}