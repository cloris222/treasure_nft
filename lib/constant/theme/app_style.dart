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

  /// 漸層色紫藍色
  BoxDecoration baseFlipGradient(
      {double radius = 0, Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: 1),
        gradient: const LinearGradient(
            colors: [AppColors.subThemePurple, AppColors.mainThemeButton]));
  }

  BoxDecoration styleColorBorderBackground(
      {double radius = 20.0,
      Color color = Colors.grey,
      Color backgroundColor = Colors.white,
      double borderLine = 1}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: backgroundColor,
      border: Border.all(color: color, width: borderLine),
    );
  }

  BoxDecoration styleColorsRadiusBackground(
      {Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
    );
  }

  ///MARK: 陰影底
  BoxDecoration styleShadowBorderBackground(
      {double radius = 15.0,
      Color borderBgColor = Colors.white,
      Color borderColor = Colors.grey,
      double borderWidth = 3,
      double offsetX = 0,
      double offsetY = 2,
      Color shadowColor = Colors.black12,
      double blurRadius = 0.7,
      double spreadRadius = 2}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.white,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              offset: Offset(offsetX, offsetY), //陰影y軸偏移量
              blurRadius: blurRadius, //陰影模糊程度
              spreadRadius: spreadRadius //陰影擴散程度
              )
        ]);
  }

  BoxDecoration styleUserSetting() {
    return styleColorBorderBackground(
        color: AppColors.searchBar,
        radius: 15,
        backgroundColor: Colors.transparent);
  }

  ///MARK: 登入用
  OutlineInputBorder styleTextEditBorderBackground(
      {double radius = 15.0, Color color = Colors.grey}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
