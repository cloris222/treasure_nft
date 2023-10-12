import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_count_provider.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../button/menu_button_widget.dart';

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
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize24,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: onTap,
                    icon: Image.asset(AppImagePath.arrowLeft,
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
                    style: AppTextStyle.getBaseStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize ?? UIDefine.fontSize18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: leftPadding),
                  child: IconButton(
                      onPressed: onTap,
                      icon: Image.asset(AppImagePath.arrowLeft,
                          width: arrowFontSize ?? UIDefine.fontSize18,
                          fit: BoxFit.contain)),
                ),
              ],
            ),
          ))
        ]);
  }

  static AppBar mainAppBar({
    required VoidCallback serverAction,
    required VoidCallback globalAction,
    required VoidCallback mainAction,
    required VoidCallback airdropAction,
    required VoidCallback announcementAction,
    bool isMainPage = false,
    bool isShowNotice = true,
  }) {
    var space = const SizedBox(width: 8);
    double iconSize = 28;
    return _getCustomAppBar(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: mainAction,
                  child: Image.asset(AppImagePath.mainAppBarLogo,
                      height: 35, fit: BoxFit.fitHeight)),
            ),

          const Expanded(child:SizedBox(width: 1)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 公告欄
                Visibility(
                    visible: isShowNotice,
                    child:GestureDetector(
                      onTap: announcementAction,
                      child: Stack(
                        children: [
                      Image.asset(
                        AppImagePath.noticeIcon,
                        color: AppColors.textBlack,
                        scale: 0.95,
                      ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Consumer(builder: (BuildContext context,
                                WidgetRef ref, Widget? child) {
                              // bool hasNew = ref.watch(hasNewAnnounceProvider);
                              return const CircleAvatar(
                                maxRadius: 5,
                                backgroundColor: Colors.red,
                                child:SizedBox(),
                              );
                            }),
                          ),
                      ]),
                    )),
                /// appbar寶箱
                // GestureDetector(
                //   onTap: airdropAction,
                //   child: Stack(
                //     children: [
                //       Container(
                //           padding: EdgeInsets.fromLTRB(
                //               UIDefine.getPixelWidth(10),
                //               UIDefine.getPixelWidth(5),
                //               UIDefine.getPixelWidth(15),
                //               UIDefine.getPixelWidth(5),
                //           ),
                //           color: Colors.transparent,
                //           child: GradientThirdText(tr("airdrop"),styleHeight: 1.1,textDecoration: TextDecoration.underline)),
                //       Positioned(
                //         right: 0,
                //         top: 0,
                //         child: Consumer(builder: (BuildContext context,
                //             WidgetRef ref, Widget? child) {
                //           int counts = ref.watch(
                //               airdropCountProvider(BaseViewModel().isLogin()));
                //           return counts > 0
                //               ? CircleAvatar(
                //                   maxRadius: 8,
                //                   backgroundColor: Colors.red,
                //                   child: Text("$counts",
                //                       style: AppTextStyle.getBaseStyle(
                //                           color: Colors.white,
                //                           fontSize: UIDefine.fontSize8)),
                //                 )
                //               : const SizedBox();
                //         }),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(width: UIDefine.getPixelWidth(5)),
                MenuButtonWidget(
                    serverAction: serverAction,
                    globalAction: globalAction,
                    mainAction: mainAction,
                    iconSize: iconSize,
                    isMainPage: isMainPage)
              ]
              // [
              //    SocialMediaButtonWidget(
              //        padding: EdgeInsets.zero,
              //        footer: HomeFooter.Telegram,
              //        size: iconSize),
              //    space,
              //    LanguageButtonWidget(
              //        iconSize: iconSize, isMainPage: isMainPage),
              //    space,
              //    GestureDetector(
              //        onTap: serverAction,
              //        child: Container(
              //          color: Colors.transparent,
              //          child: Image.asset(AppImagePath.serverImage,
              //              width: iconSize,
              //              height: iconSize,
              //              fit: BoxFit.contain),
              //        )),
              //    space,
              //    GestureDetector(
              //        onTap: mainAction,
              //        child: Container(
              //          color: Colors.transparent,
              //          child: Image.asset(AppImagePath.homeImage,
              //              width: iconSize,
              //              height: iconSize,
              //              fit: BoxFit.contain),
              //        )),
              //  ]
              )
        ]);
  }

  /// 只有Logo + 多國設定 + 客服
  static AppBar mainNewAppBar({
    required VoidCallback serverAction,
    required VoidCallback globalAction,
    required VoidCallback mainAction,
  }) {
    var space = const SizedBox(width: 8);
    double iconSize = 28;
    return _getCustomAppBar(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  onTap: mainAction,
                  child: Image.asset(AppImagePath.mainAppBarLogo,
                      height: 35, fit: BoxFit.fitHeight)),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: globalAction,
                    child: Image.asset(AppImagePath.globalImage,
                        width: iconSize, height: iconSize, fit: BoxFit.cover)),
                space,
                InkWell(
                    onTap: serverAction,
                    child: Image.asset(AppImagePath.serverImage,
                        width: iconSize, height: iconSize, fit: BoxFit.cover))
              ])
        ]);
  }
}
