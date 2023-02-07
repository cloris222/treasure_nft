import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/utils/observer_pattern/custom/language_observer.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/server_web_page.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/appbar/custom_app_bar.dart';

///MARK:用於部分有瀏海的頁面
class CustomAppbarView extends StatefulWidget {
  const CustomAppbarView(
      {Key? key,
      required this.body,
      this.onPressed,
      this.type,
      required this.needScrollView,
      this.needCover = false,
      this.backgroundColor = Colors.white,
      this.needAppBar = true,
      this.needBottom = true,
      required this.onLanguageChange})
      : super(key: key);
  final Widget body;
  final VoidCallback? onPressed;
  final AppNavigationBarType? type;
  final bool needScrollView;
  final bool needCover;
  final Color backgroundColor;
  final bool needAppBar;
  final bool needBottom;
  final onClickFunction onLanguageChange;

  @override
  State<CustomAppbarView> createState() => _CustomAppbarViewState();
}

class _CustomAppbarViewState extends State<CustomAppbarView> {
  late LanguageObserver languageObserver;

  @override
  void initState() {
    languageObserver = LanguageObserver(SubjectKey.keyChangeLanguage,
        onNotify: (notification) {
      if (mounted) {
        setState(() {});
        widget.onLanguageChange();
      }
    });
    GlobalData.languageSubject.registerObserver(languageObserver);
    super.initState();
  }

  @override
  void dispose() {
    GlobalData.languageSubject.unregisterObserver(languageObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.backgroundColor,
        appBar: widget.needAppBar
            ? CustomAppBar.mainAppBar(
                serverAction: () => _serverAction(context),
                globalAction: () => _globalAction(context),
                mainAction: () => _mainAction(context))
            : null,
        body: GestureDetector(
          onTap: () => BaseViewModel().clearAllFocus(),
          child: Stack(children: [
            Container(
                color: widget.backgroundColor,
                height: UIDefine.getHeight(),
                width: UIDefine.getWidth(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        UIDefine.getScreenWidth(1.38)),
                child: widget.needScrollView
                    ? SingleChildScrollView(child: widget.body)
                    : widget.body),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: widget.needBottom
                    ? AppBottomNavigationBar(
                        initType: widget.type ?? GlobalData.mainBottomType)
                    : const SizedBox())
          ]),
        ),
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
