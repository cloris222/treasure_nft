import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';

class CustomAppBar {
  const CustomAppBar._();

  static AppBar _getCustomAppBar({required List<Widget> actions,
    double? appBarHeight,
    ShapeBorder? shape,
    Color color = Colors.white,
    EdgeInsetsGeometry? margin,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return AppBar(
        elevation: 0,
        backgroundColor: color,
        toolbarHeight: appBarHeight,
        shape: shape,
        actions: <Widget>[
          Flexible(
              child: Container(
                  margin: margin,
                  constraints: const BoxConstraints.expand(),
                  child: Row(
                      mainAxisAlignment: mainAxisAlignment, children: actions)))
        ]);
  }

  static AppBar getCustomAppBar({required List<Widget> actions}) {
    return _getCustomAppBar(actions: actions);
  }

  /// 圓角app bar
  static AppBar getCornerAppBar(VoidCallback onTap,
      String title, {
        double appBarHeight = 100,
        double circular = 50,
        double leftPadding = 5,
        double? fontSize,
        double? arrowFontSize,
      }) {
    return _getCustomAppBar(
        appBarHeight: appBarHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(circular),
          ),
        ),
        actions: [
          Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.mainThemeButton,
                    borderRadius: BorderRadius.circular(50)),
                constraints: const BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize ?? UIDefine.fontSize18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: leftPadding),
                      child: IconButton(
                          onPressed: onTap,
                          icon: Image.asset(AppImagePath.appBarLeftArrow,
                              width: arrowFontSize ?? UIDefine.fontSize18,
                              fit: BoxFit.contain)),
                    ),
                  ],
                ),
              ))
        ]);
  }

  static AppBar mainAppBar() {
    return _getCustomAppBar(actions: [Flexible(child: Container(child:Row(children: [
Row(children: [],)
    ],),))]);
  }
}
