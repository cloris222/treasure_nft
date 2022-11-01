import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../constant/global_data.dart';
import '../constant/theme/app_image_path.dart';
import '../views/main_page.dart';
import 'app_bottom_navigation_bar.dart';

class AppBottomCenterButton extends StatelessWidget {
  const AppBottomCenterButton(
      {Key? key,
      this.bottomFunction,
      this.type = AppNavigationBarType.typeTrade})
      : super(key: key);
  final AppBottomFunction? bottomFunction;
  final AppNavigationBarType type;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.white,
      elevation: 0,
      backgroundColor: Colors.white,
      onPressed: () => _onPress(context),
      child: _buildIcon(),
    );
  }

  Widget _buildIcon() {
    bool isSelect = (GlobalData.mainBottomType == type);
    var sizeWidth = UIDefine.getHeight();
    var asset =
        isSelect ? AppImagePath.mainTypeTrade : AppImagePath.mainTypeTradeOFF;
    return Padding(
      padding: EdgeInsets.all(UIDefine.getScreenHeight(0.5)),
      child: Image.asset(asset,
          fit: BoxFit.contain, width: sizeWidth, height: sizeWidth),
    );
  }

  void _onPress(BuildContext context) {
    GlobalData.mainBottomType = type;
    if (bottomFunction != null) {
      bottomFunction!(GlobalData.mainBottomType);
    } else {
      //清除所有頁面並回到首頁
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                MainPage(type: GlobalData.mainBottomType)),
        ModalRoute.withName('/'),
      );
    }
  }
}
