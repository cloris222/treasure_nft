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
  baseGradient() {
    return const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.mainThemeButton, AppColors.subThemePurple]));
  }

  BoxDecoration styleColorBorderBackground(
      {double radius = 15.0, Color color = Colors.grey}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: Colors.white,
      border: Border.all(color: color, width: 1),
    );
  }
}
