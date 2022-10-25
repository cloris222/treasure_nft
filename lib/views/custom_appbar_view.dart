import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';

///MARK:用於部分有瀏海的頁面
class CustomAppbarView extends StatelessWidget {
  const CustomAppbarView(
      {Key? key,
      required this.title,
      required this.widget,
      this.onPressed,
      this.type})
      : super(key: key);
  final String title;
  final Widget widget;
  final VoidCallback? onPressed;
  final AppNavigationBarType? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(fontSize: UIDefine.fontSize24),
            ),
            backgroundColor: AppColors.mainThemeButton,
            elevation: 0,
            leading: IconButton(
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                icon: Image.asset(AppImagePath.appBarLeftArrow,
                    fit: BoxFit.contain))),
        body: Stack(children: [
          SingleChildScrollView(
              child: Column(children: [
            const SizedBox(
              height: 5,
            ),
            widget
          ])),
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
        bottomNavigationBar: AppBottomNavigationBar(
            initType: type ?? GlobalData.mainBottomType));
  }
}
