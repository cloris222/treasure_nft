// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/common/user_change_password_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_info_setting_page.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/login_api.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/login_bolder_button_widget.dart';
import '../../custom_appbar_view.dart';
import '../../main_page.dart';

///MARK: 個人設置
class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    Widget space = const SizedBox(height: 15);
    return CustomAppbarView(
        needCover: true,
        needScrollView: true,
        title: tr('account'),
        type: AppNavigationBarType.typePersonal,
        body: Column(children: [
          PersonalSubUserInfoView(
              enableModify: true, onViewUpdate: () => setState(() {})),
          Container(
            padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5),
                UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5.5), 0),
            child: _getGrayBolderButton(context, true),
          ),
          space,
          Container(
            padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5), 0,
                UIDefine.getScreenWidth(5.5), 0),
            child: _getGrayBolderButton(context, false),
          ),
          space,
          Container(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5), 0,
                  UIDefine.getScreenWidth(5.5), 0),
              child: LoginBolderButtonWidget(
                  btnText: tr('logout'),
                  onPressed: () => _onPressLogout(context))),
          SizedBox(height: UIDefine.getScreenHeight(10))
        ]));
  }

  Widget _getGrayBolderButton(BuildContext context, bool bLockIcon) {
    return GestureDetector(
      onTap: () => bLockIcon ? _goChangePwd(context) : _goUserSetting(context),
      child: Container(
          decoration: const BoxDecoration(
              color: AppColors.bolderGrey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                  decoration: (const BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
                  child: Padding(
                      padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                bLockIcon
                                    ? Image.asset(
                                        'assets/icon/icon/icon_lock_02.png',
                                        width: UIDefine.getScreenWidth(6),
                                        height: UIDefine.getScreenWidth(6))
                                    : Image.asset(
                                        'assets/icon/icon/icon_user_02.png',
                                        width: UIDefine.getScreenWidth(6),
                                        height: UIDefine.getScreenWidth(6)),
                                SizedBox(width: UIDefine.getScreenWidth(3)),
                                Flexible(
                                  child: Text(
                                    bLockIcon
                                        ? tr('changePassword')
                                        : tr('userInfo'),
                                    style: TextStyle(
                                        color: AppColors.textBlack,
                                        fontSize: UIDefine.fontSize14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                              'assets/icon/btn/btn_arrow_right_01_nor.png',
                              width: UIDefine.getScreenWidth(6),
                              height: UIDefine.getScreenWidth(6))
                        ],
                      ))))),
    );
  }

  void _goChangePwd(BuildContext context) {
    BaseViewModel().pushPage(context, UserChangePasswordPage());
  }

  void _goUserSetting(BuildContext context) {
    BaseViewModel().pushPage(context, UserInfoSettingPage());
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
