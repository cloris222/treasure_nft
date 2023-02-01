import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/server_web_page.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/appbar/custom_app_bar.dart';

///MARK:用於部分有瀏海的頁面
class CustomAppbarView extends StatelessWidget {
  const CustomAppbarView(
      {Key? key,
      required this.body,
      this.onPressed,
      this.type,
      required this.needScrollView,
      this.needCover = false,
      this.backgroundColor = Colors.white,
      this.needAppBar = true,
      this.needBottom = true})
      : super(key: key);
  final Widget body;
  final VoidCallback? onPressed;
  final AppNavigationBarType? type;
  final bool needScrollView;
  final bool needCover;
  final Color backgroundColor;
  final bool needAppBar;
  final bool needBottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: needAppBar
            ? CustomAppBar.mainAppBar(
                serverAction: () => _serverAction(context),
                globalAction: () => _globalAction(context),
                mainAction: () => _mainAction(context))
            : null,
        body: Stack(children: [
          Container(
              color: backgroundColor,
              height: UIDefine.getHeight(),
              width: UIDefine.getWidth(),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom +
                      UIDefine.getScreenWidth(1.38)),
              child:
                  needScrollView ? SingleChildScrollView(child: body) : body),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: needBottom
                  ? AppBottomNavigationBar(
                      initType: type ?? GlobalData.mainBottomType)
                  : const SizedBox())
        ]),
        extendBody: true);
  }

  void _serverAction(BuildContext context) {
    BaseViewModel().pushPage(context, const ServerWebPage());
  }

  void _globalAction(BuildContext context) async {
    await BaseViewModel().pushPage(context, const SettingLanguagePage());
  }

  void _mainAction(BuildContext context) {
    BaseViewModel().pushAndRemoveUntil(
        context, const MainPage(type: AppNavigationBarType.typeMain));
  }
}
