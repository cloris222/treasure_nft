import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/ui_define.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/title_app_bar.dart';
import '../../custom_appbar_view.dart';

class UserLineSettingPage extends ConsumerStatefulWidget {
  const UserLineSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserLineSettingPageState();
}

class _UserLineSettingPageState extends ConsumerState<UserLineSettingPage> {
  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typePersonal,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleAppBar(title: tr('settingLine'), needCloseIcon: false),
          ],
        ),
      ),
    );
  }
}
