import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_theme.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../views/login/circle_network_icon.dart';

class CustomAppBar {
  const CustomAppBar._();

  static AppBar _getCustomAppBar(
      {required List<Widget> actions,
      double? appBarHeight,
      ShapeBorder? shape,
      Color color = Colors.white,
      Color? fillColor,
      EdgeInsetsGeometry? margin,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: color,
        toolbarHeight: appBarHeight,
        shape: shape,
        actions: <Widget>[
          Flexible(
              child: Container(
                  margin: margin,
                  color: fillColor,
                  constraints: const BoxConstraints.expand(),
                  child: Row(
                      mainAxisAlignment: mainAxisAlignment, children: actions)))
        ]);
  }

  static AppBar getCustomAppBar({required List<Widget> actions}) {
    return _getCustomAppBar(actions: actions);
  }

  static AppBar getServerAppBar() {
    return _getCustomAppBar(
        color: AppColors.mainThemeButton,
        appBarHeight: 30,
        mainAxisAlignment: MainAxisAlignment.end,
        actions: [Text('X'), SizedBox(width: UIDefine.getScreenHeight(3))]);
  }

  ///MARK: 常用Bar
  static AppBar getCommonAppBar(VoidCallback onTap, String title) {
    return getCornerAppBar(onTap, title,
        fontSize: UIDefine.fontSize24,
        arrowFontSize: UIDefine.fontSize34,
        circular: 30,
        appBarHeight:
            UIDefine.getHeight() / 6 > 80 ? 80 : UIDefine.getHeight() / 6);
  }

  ///MARK: 僅Bar&Arrow
  static AppBar getOnlyArrowAppBar(VoidCallback onTap, String title) {
    return _getCustomAppBar(
      actions: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(title,
                      style: TextStyle(
                          fontSize: UIDefine.fontSize24,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: onTap,
                    icon: Image.asset(AppImagePath.appBarLeftArrow,
                        fit: BoxFit.contain,
                        width: UIDefine.fontSize34,
                        height: UIDefine.fontSize34)),
              ),
            ],
          ),
        )
      ],
      fillColor: AppColors.mainThemeButton,
      color: AppColors.mainThemeButton,
    );
  }

  /// 圓角app bar
  static AppBar getCornerAppBar(
    VoidCallback onTap,
    String title, {
    double appBarHeight = 100,
    double circular = 50,
    double leftPadding = 5,
    double? fontSize,
    double? arrowFontSize,
  }) {
    return _getCustomAppBar(
        color: AppColors.mainThemeButton,
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

  static AppBar mainAppBar({
    required VoidCallback searchAction,
    required VoidCallback serverAction,
    required VoidCallback avatarAction,
    required VoidCallback globalAction,
    required VoidCallback mainAction,
  }) {
    var space = const SizedBox(width: 5);
    return _getCustomAppBar(
        margin:EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(3)),
        actions: [
          InkWell(
              onTap: mainAction,
              child: Image.asset(AppImagePath.mainAppBarLogo)),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: searchAction,
                        child: const Icon(Icons.search,
                            color: Colors.grey, size: 30)),
                    space,
                    InkWell(
                        onTap: serverAction,
                        child: Image.asset(AppImagePath.serverImage,
                            width: 30, height: 30, fit: BoxFit.cover)),
                    space,
                    InkWell(
                        onTap: avatarAction,
                        child: Container(
                            decoration: AppTheme.style.baseGradient(radius: 15),
                            padding: const EdgeInsets.all(1),
                            child: BaseViewModel().isLogin() &&
                                    GlobalData.userInfo.photoUrl.isNotEmpty
                                ? CircleNetworkIcon(
                                    networkUrl: GlobalData.userInfo.photoUrl,
                                    radius: 15)
                                : Image.asset(AppImagePath.avatarImg,
                                    width: 25, height: 25))),
                    space,
                    InkWell(
                        onTap: globalAction,
                        child: Image.asset(AppImagePath.globalImage,
                            width: 30, height: 30, fit: BoxFit.cover))
                  ]))
        ]);
  }
}
