import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import 'app_colors.dart';
import 'app_style.dart';

@immutable //不可變物件
class AppTheme {
  const AppTheme._();

  static final style = AppStyle();

  ///MARK: 可以放一些測試資料

  ///MARK: 從女權拿來的
  static ThemeData define() {
    return ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        primaryIconTheme: const IconThemeData(color: Colors.black),
        primaryTextTheme: TextTheme(subtitle1: AppTextStyle.getBaseStyle(fontSize: 12)),
        textTheme: TextTheme(subtitle1: AppTextStyle.getBaseStyle(fontSize: 12)));
  }

  static ThemeData defineDemo() {
    return ThemeData(
      //深色还是浅色
      brightness: Brightness.light,
      //主题颜色样本，见下面介绍
      // primarySwatch: Colors.pink,
      //主色，决定导航栏颜色
      primaryColor: Colors.amberAccent,
      //卡片颜色 ->影響狀態列 深色狀態下影響action bar
      cardColor: AppColors.textBlack,
      //分割线颜色
      dividerColor: Colors.blueGrey,
      //按钮主题 RaisedButton
      buttonTheme: const ButtonThemeData(
          minWidth: 100,
          buttonColor: AppColors.textWhite,
          disabledColor: AppColors.textBlack,
          textTheme: ButtonTextTheme.primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              textStyle: AppTextStyle.getBaseStyle(
                fontStyle: FontStyle.italic,
                fontSize: 24,
              ))),
      //对话框背景颜色
      dialogBackgroundColor: AppColors.textBlack,
      //文字字体 https://doc.flutterchina.club/custom-fonts/
      // fontFamily: 'Raleway',
      // 字体主题，包括标题、body等文字样式
      // textTheme: TextTheme(button:CustomTextStyle.getBaseStyle(fontStyle: Colors.pink)),
      // IconThemeData iconTheme, // Icon的默认样式
      // TargetPlatform platform, //指定平台，应用特定平台控件风格
      // ColorScheme ? colorScheme,
      // ...
    );
  }
}
