// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/views/personal/common/user_change_password_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_info_setting_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_line_setting_page.dart';
import 'package:treasure_nft_project/views/personal/common/user_setting_top_view.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/login_api.dart';
import '../../../models/http/parameter/blacklist_config_data.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../view_models/login/wallet_bind_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../../main_page.dart';
import 'google_auth/google_authenticator_page.dart';
import 'google_auth/google_disable_page.dart';

///MARK: 個人設置
class UserSettingPage extends ConsumerStatefulWidget {
  const UserSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends ConsumerState<UserSettingPage> {
  String version = '';
  bool isWalletBind = false;
  bool get isGoogleBind => ref.watch(userInfoProvider).bindGoogle;

  UserInfoData get userInfo {
    return ref.read(userInfoProvider);
  }

  BlacklistConfigData blacklistData = BlacklistConfigData();


  @override
  void initState() {
    super.initState();
    isWalletBind = userInfo.address.isNotEmpty;
    _initPackageInfo();
    /// 取得鎖定時間
    UserInfoAPI().getBlacklistConfig().then((value) => blacklistData = value);
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
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        type: AppNavigationBarType.typePersonal,
        backgroundColor: AppColors.defaultBackgroundSpace,
        body: Column(children: [
          BackgroundWithLand(
              showPreBtn: false,
              mainHeight: 217,
              bottomHeight: 40,
              onBackPress: () => BaseViewModel().popPage(context),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal:UIDefine.getPixelWidth(27)),
                    child: UserSettingTopView(
                        enableModify: true,
                        onViewUpdate: () => setState(() {})),
                  ),
                  SizedBox(height: UIDefine.getPixelWidth(10)),
                  Container(
                    decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
                    margin: EdgeInsets.symmetric(
                        vertical: UIDefine.getPixelWidth(5),
                        horizontal: UIDefine.getPixelWidth(10)),
                    padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                    child: Row(children: [
                      _getWalletBolderButton(),
                      _getGoogleAuthButton(),
                      _getUserSettingButton(),
                    ],),
                  )
                ],
              )),
          Container(
            decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
            margin: EdgeInsets.symmetric(
                vertical: UIDefine.getPixelWidth(5),
                horizontal: UIDefine.getPixelWidth(10)),
            padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
            child: _buildSettingList()
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
          SizedBox(height: UIDefine.getPixelHeight(30)),
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

  Widget _getWalletBolderButton() {
    return Expanded(
        child: GestureDetector(
          onTap: () => _onBindWallet(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImagePath.walletConnectIcon,
                  width: UIDefine.getPixelWidth(30),
                  height: UIDefine.getPixelWidth(30),
                  fit: BoxFit.contain),
              Text(
                tr('bindWallet'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack, fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400),
              ),
              Text(
                isWalletBind ? tr('bound') : tr('unBound'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: isWalletBind
                        ? const Color(0xFF6CCA98)
                        : const Color(0xFFFF0000),
                    fontSize: UIDefine.fontSize10,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ));
  }

  Widget _getGoogleAuthButton() {
    return Expanded(
        child: GestureDetector(
          onTap: () => onGoogleButton(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImagePath.googleAuthIcon,
                  width: UIDefine.getPixelWidth(30),
                  height: UIDefine.getPixelWidth(30),
                  fit: BoxFit.contain),
              Text(
                tr('googleValid'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack, fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400),
              ),
              Text(
                isGoogleBind ? tr('bound') : tr('unBound'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: isGoogleBind
                        ? const Color(0xFF6CCA98)
                        : const Color(0xFFFF0000),
                    fontSize: UIDefine.fontSize10,
                    fontWeight: FontWeight.w400,),
              )
            ],
          ),
        ));
  }

  void onGoogleButton() {
    if (!isGoogleBind) {
      BaseViewModel().pushPage(
          context, const GoogleSettingPage())
          .then((value) => ref.read(userInfoProvider.notifier).update());
    }
    /// 重置google 暫時隱藏
    // else {
    //   _showGoogleReset();
    // }
  }

  Widget _getUserSettingButton() {
    return Expanded(
        child: GestureDetector(
          onTap: () => _goUserSetting(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImagePath.personalSettingIcon,
                  width: UIDefine.getPixelWidth(30),
                  height: UIDefine.getPixelWidth(30),
                  fit: BoxFit.contain),
              Text(
                 tr('userInfo'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack, fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400),
              ),
              Text(
                "",
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize10),
              )
            ],
          ),
        ));
  }

  void _showGoogleReset() {
    CommonCustomDialog(context,
        title: tr("googleCheckTitle"),
        content: format(tr("googleCheckText"),
            {"time": BaseViewModel().formatDuration(
                blacklistData.unableWithdrawByGoogle)}
        ),
        type: DialogImageType.warning,
        rightBtnText: tr('confirm'),
        onLeftPress: () {}, onRightPress: () {
          BaseViewModel().pushPage(context, GoogleDisablePage(blacklistData));
        }).show();
  }


  Widget _buildSettingList() {
    return Column(children: [
      _buildListItem(iconPath: AppImagePath.lockIcon,label: tr('changePassword'),pushPage: const UserChangePasswordPage()),
      _buildLine(),
      _buildListItem(iconPath: AppImagePath.settingLineIcon,label: tr('lineSettings'),pushPage: const UserLineSettingPage()),
      _buildLine(),
    ],);
  }

  Widget _buildListItem({required String iconPath, required String label, required Widget? pushPage}) {
    return GestureDetector(
      onTap: () {
        if (pushPage != null) {
          BaseViewModel().pushPage(context, pushPage);
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding:EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(12)),
        child: Row(
          children: [
            BaseIconWidget(imageAssetPath: iconPath, size: UIDefine.getPixelWidth(24)),
            SizedBox(width: UIDefine.getPixelWidth(10)),
            Text(label, style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w400, fontSize: UIDefine.fontSize16, color: AppColors.textBlack)),
            const Spacer(),
            BaseIconWidget(imageAssetPath: AppImagePath.arrowRightSetting, size: UIDefine.getPixelWidth(20)),
          ],
        ),
      ),
    );
  }
  Widget _buildLine(){
    return Container(
      height: 1,
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleShadowBorderBackground(
        offsetY: -0.5,
        shadowColor: const Color(0xFFEEEEEE),
        blurRadius: 0,
      ),
    );
  }

  void _goChangePwd(BuildContext context) {
    // PageBottomSheet(context, page: const UserChangePasswordPage()).show();
    BaseViewModel().pushPage(context, const UserChangePasswordPage());
  }

  void _goUserSetting(BuildContext context) {
    BaseViewModel().pushPage(context, UserInfoSettingPage(blacklistData));
    // PageBottomSheet(context, page: const UserInfoSettingPage()).show();
  }

  bool waitLoginOut = false;

  void _onPressLogout(BuildContext context) async {
    if (!waitLoginOut) {
      try {
        await LoginAPI(
                onConnectFail: (message) =>
                    BaseViewModel().onBaseConnectFail(context, message))
            .logout()
            .then((value) async {
          await BaseViewModel().clearUserLoginInfo();
          BaseViewModel().pushAndRemoveUntil(
              context, const MainPage(type: AppNavigationBarType.typeLogin));
        });
      } catch (e) {}
      waitLoginOut = true;
    }
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

  void _onBindWallet() async {
    if (!isWalletBind) {
      WalletInfo? walletInfo = await BaseViewModel().pushWalletConnectPage(
        context,
        subTitle: tr('select-wallet'),
        needVerifyAPI: false,
        showBindSuccess: false,
      );
      WalletBindViewModel()
          .bindWallet(context, ref, walletInfo, userInfo)
          .then((value) {
        if (value) {
          setState(() {
            isWalletBind = true;
          });
        }
      });
    }
  }
}
