
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import '../../../../constant/call_back_function.dart';
import '../../../../constant/enum/login_enum.dart';
import '../../../../models/data/validate_result_data.dart';
import '../../../../models/http/api/auth_api.dart';
import '../../../../models/http/api/user_info_api.dart';
import '../../../../models/http/parameter/user_info_data.dart';
import '../../../../views/personal/common/user_setting_page.dart';
import '../../../../widgets/dialog/common_custom_dialog.dart';
import '../../../../widgets/dialog/simple_custom_dialog.dart';
import '../../../base_view_model.dart';
import '../../../gobal_provider/global_tag_controller_provider.dart';
import '../../../gobal_provider/user_info_provider.dart';


class GoogleDisableViewModel extends BaseViewModel {
  GoogleDisableViewModel(this.ref, {required this.setState});
  final ViewChange setState;
  final WidgetRef ref;

  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  final String tagEmailCode = "emailCode";
  bool isProcess = false;
  UserInfoData get userInfo => ref.watch(userInfoProvider);

  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();


  void initResult(String tag) {
    ref.read(globalValidateDataProvider(tag).notifier)
        .update((state) => ValidateResultData());
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) {
    AuthAPI(onConnectFail: (errorMessage)
    => onBaseConnectFail(context, errorMessage))
        .sendAuthActionMail(action: LoginAction.unbind, userInfo: userInfo);
    SimpleCustomDialog(context, mainText:tr('pleaseGotoMailboxReceive')).show();
  }

  /// 確認解綁按鈕
  void onPressConfirm(BuildContext context) {
    if (!checkEmptyController()) {
      passwordData = ValidateResultData(result: passwordController.text.isNotEmpty);
      emailCodeData = ValidateResultData(result: verifyController.text.isNotEmpty);
      setState((){});
      return;
    } else {
      UserInfoAPI(
          onConnectFail: (message)=> showFailedDialog(context, message))
          .unBindGoogleAuth(verifyController.text, passwordController.text)
          .then((value) => showSuccessDialog(context));
    }
  }

  bool checkEmptyController() {
    debugPrint("checkEmptyController");
    return passwordController.text.isNotEmpty &&
        verifyController.text.isNotEmpty;
  }

  void showSuccessDialog(BuildContext context) {
    CommonCustomDialog(context,
        title: tr("resetSuccess"),
        content: "",
        type: DialogImageType.success,
        rightBtnText: tr('confirm'),
        onLeftPress: () {}, onRightPress: () => {
          pushPage(context,const MainPage(type:AppNavigationBarType.typePersonal)),
          pushPage(context, const UserSettingPage()),
        }).show();
  }

  void showFailedDialog(BuildContext context, String failReason) {
    CommonCustomDialog(context,
        title: tr("verifyError"),
        content: failReason,
        type: DialogImageType.fail,
        rightBtnText: tr('confirm'),
        onLeftPress: () {}, onRightPress: () => popPage(context)
    ).show();
  }
}