// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/common/user_change_password_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_info_setting_page.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/bottom_sheet/page_bottom_sheet.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/login_api.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../../main_page.dart';

///MARK: 個人設置
class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  void _initPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: UIDefine.getScreenWidth(4));
    return CustomAppbarView(
        needCover: true,
        needScrollView: true,
        type: AppNavigationBarType.typePersonal,
        backgroundColor: AppColors.defaultBackgroundSpace,
        body: Column(children: [
          BackgroundWithLand(
              mainHeight: 230,
              bottomHeight: 100,
              onBackPress: () => BaseViewModel().popPage(context),
              body: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                decoration: AppStyle().styleNewUserSetting(),
                child: PersonalNewSubUserInfoView(
                    showId: false,
                    enableModify: true,
                    onViewUpdate: () => setState(() {})),
              )),
          Container(
            decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
            margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
            padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
            child: Row(
              children: [
                Expanded(
                  child: _getGrayBolderButton(context, true),
                ),
                Expanded(
                  child: _getGrayBolderButton(context, false),
                ),
              ],
            ),
          ),
          space,
          Container(
              // 版本號
              margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5.5)),
              alignment: Alignment.centerLeft,
              child: Text('${tr('version')} v$version',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textGrey))),
          space,
          SizedBox(height: UIDefine.getPixelHeight(100)),
          Container(
              // 登出按鈕
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5), 0,
                  UIDefine.getScreenWidth(5.5), 0),
              child: LoginButtonWidget(
                  btnText: tr('logout'),
                  radius: 22,
                  onPressed: () => _onPressLogout(context))),
          space,
          Container(
              // 登出按鈕
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5.5), 0,
                  UIDefine.getScreenWidth(5.5), 0),
              child: LoginButtonWidget(
                  btnText: tr('deleteAccount'),
                  radius: 22,
                  onPressed: () => _onPressDeleteAccount(context))),
          space,
          SizedBox(height: UIDefine.navigationBarPadding)
        ]));
  }

  Widget _getGrayBolderButton(BuildContext context, bool bLockIcon) {
    return GestureDetector(
      onTap: () => bLockIcon ? _goChangePwd(context) : _goUserSetting(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bLockIcon
              ? Image.asset(AppImagePath.lockIcon,
                  width: UIDefine.getPixelWidth(30),
                  height: UIDefine.getPixelWidth(30),
                  fit: BoxFit.contain)
              : Image.asset(AppImagePath.personalSettingIcon,
                  width: UIDefine.getPixelWidth(30),
                  height: UIDefine.getPixelWidth(30),
                  fit: BoxFit.contain),
          Text(
            bLockIcon ? tr('changePassword') : tr('userInfo'),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textBlack, fontSize: UIDefine.fontSize12),
          )
        ],
      ),
    );
  }

  void _goChangePwd(BuildContext context) {
    PageBottomSheet(context, page: const UserChangePasswordPage()).show();
    // BaseViewModel().pushPage(context, const UserChangePasswordPage());
  }

  void _goUserSetting(BuildContext context) {
    PageBottomSheet(context, page: const UserInfoSettingPage()).show();
  }

  void _onPressLogout(BuildContext context) {
    LoginAPI(
            onConnectFail: (message) =>
                BaseViewModel().onBaseConnectFail(context, message))
        .logout()
        .then((value) async {
      await BaseViewModel().clearUserLoginInfo();
      BaseViewModel().pushAndRemoveUntil(
          context, const MainPage(type: AppNavigationBarType.typeLogin));
    });
  }

  void _onPressDeleteAccount(BuildContext context) {
    BaseViewModel viewModel = BaseViewModel();
    CommonCustomDialog(context,
        bOneButton: false,
        type: DialogImageType.warning,
        title: tr('deleteAccount'),
        content: tr('deleteAccountHint'),
        leftBtnText: tr('cancel'),
        rightBtnText: tr('confirm'), onLeftPress: () {
      viewModel.popPage(context);
    }, onRightPress: () {
      viewModel.popPage(context);
      UserInfoAPI().deleteAccount().then((value) async {
        await SimpleCustomDialog(context, isSuccess: true).show();
        await viewModel.clearUserLoginInfo();
        viewModel.pushPage(
            context, const MainPage(type: AppNavigationBarType.typeMain));
      });
    }).show();
  }
}
