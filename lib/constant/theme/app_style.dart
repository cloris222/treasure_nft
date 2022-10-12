import 'package:flutter/material.dart';

import 'app_colors.dart';

///MARK: 放會重複用到的Style
class AppStyle {
  Widget styleFillText(String text,
      {TextStyle style = const TextStyle(),
      double minHeight = 20,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      AlignmentGeometry alignment = Alignment.centerLeft,
      GlobalKey? key}) {
    return Container(
        key: key,
        alignment: alignment,
        margin: margin,
        constraints: BoxConstraints(minHeight: minHeight),
        child: Text(
          text,
          style: style,
        ));
  }

  /// 漸層色藍紫色
  BoxDecoration baseGradient(
      {double radius = 0, Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: 1),
        gradient: const LinearGradient(
            colors: [AppColors.mainThemeButton, AppColors.subThemePurple]));
  }

  BoxDecoration styleColorBorderBackground(
      {double radius = 20.0, Color color = Colors.grey}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: Colors.white,
      border: Border.all(color: color, width: 1),
    );
  }
  BoxDecoration styleColorsRadiusBackground(
      {Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
    );
  }
  ///MARK: 登入用
  OutlineInputBorder styleTextEditBorderBackground(
      {double radius = 15.0, Color color = Colors.grey}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
