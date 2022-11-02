import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../constant/theme/app_colors.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_center_button.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/appbar/custom_app_bar.dart';

///MARK:用於部分有瀏海的頁面
class CustomAppbarView extends StatelessWidget {
  const CustomAppbarView(
      {Key? key,
      required this.title,
      required this.body,
      this.onPressed,
      this.type,
      required this.needScrollView})
      : super(key: key);
  final String title;
  final Widget body;
  final VoidCallback? onPressed;
  final AppNavigationBarType? type;
  final bool needScrollView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.getOnlyArrowAppBar(
            onPressed ??
                () {
                  Navigator.pop(context);
                },
            title),
        body: Stack(children: [
          needScrollView
              ? SingleChildScrollView(
                  child: Column(children: [
                  const SizedBox(height: 5),
                  body,
                  const SizedBox(height: 5+GlobalData.navigationBarPadding),
                ]))
              : Container(
                  height:
                      UIDefine.getHeight() - MediaQuery.of(context).padding.top,
                  width: UIDefine.getWidth(),
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5+GlobalData.navigationBarPadding),
                  child: body),
          Positioned(
              top: 0,
              child: Container(
                  height: 20,
                  width: UIDefine.getWidth(),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      color: AppColors.mainThemeButton)))
        ]),
        extendBody: true,
        bottomNavigationBar: AppBottomNavigationBar(
            initType: type ?? GlobalData.mainBottomType));
  }
}
