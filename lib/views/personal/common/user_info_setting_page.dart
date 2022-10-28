import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/appbar/custom_app_bar.dart';

class UserInfoSettingPage extends StatefulWidget {
  const UserInfoSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoSettingPage();

}

class _UserInfoSettingPage extends State<UserInfoSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: CustomAppBar.getCornerAppBar(
            () {
          BaseViewModel().popPage(context);
        },
        tr("userInfo"),
        fontSize: UIDefine.fontSize24,
        arrowFontSize: UIDefine.fontSize34,
        circular: 40,
        appBarHeight: UIDefine.getScreenWidth(20),
      ),


    );
  }

}