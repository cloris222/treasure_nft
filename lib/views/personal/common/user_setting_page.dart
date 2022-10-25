// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../models/http/api/login_api.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/login_bolder_button_widget.dart';
import '../../custom_appbar_view.dart';
import '../../main_page.dart';

///MARK: 個人設置
class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        title: tr('account'),
        type: AppNavigationBarType.typePersonal,
        body: Wrap(runSpacing: 15, children: [
          const PersonalSubUserInfoView(),
          LoginBolderButtonWidget(
              btnText: tr('logout'), onPressed: () => _onPressLogout(context)),
        ]));
  }

  void _onPressLogout(BuildContext context) {
    LoginAPI(
            onConnectFail: (message) =>
                BaseViewModel().onBaseConnectFail(context, message))
        .logout()
        .then((value) async {
      await BaseViewModel().clearUserLoginInfo();
      BaseViewModel().pushAndRemoveUntil(context, const MainPage());
    });
  }
}
