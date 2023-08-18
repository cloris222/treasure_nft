import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../../../constant/enum/route_setting_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/title_app_bar.dart';
import '../../../widgets/list_view/line_setting/line_server_item.dart';
import '../../custom_appbar_view.dart';

class UserLineSettingPage extends ConsumerStatefulWidget {
  const UserLineSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserLineSettingPageState();
}

class _UserLineSettingPageState extends ConsumerState<UserLineSettingPage> {
  int chooseItem = 0;

  @override
  void initState() {
    super.initState();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child: TitleAppBar(title: tr('lineSettings'), needCloseIcon: false),
          ),
          Expanded(
              child: Container(
            color: AppColors.defaultBackgroundSpace,
            child: ListView(
              padding: EdgeInsets.only(
                top: UIDefine.getPixelWidth(6),
                bottom: UIDefine.navigationBarPadding,
                left: UIDefine.getPixelWidth(20),
                right: UIDefine.getPixelWidth(20),
              ),
              children: List<Widget>.generate(
                RouteSetting.values.length,
                (index) => _buildItem(RouteSetting.values[index]),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildItem(RouteSetting type) {
    bool enable = GlobalData.appLineSetting == type;
    return GestureDetector(
        onTap: () {
          setState(() {
            GlobalData.appLineSetting = type;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: LineServerItem(name: format(tr("settingLineNumber"), {"num": type.index}), server: type, enable: enable));
  }
}
