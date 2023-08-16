
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/views/personal/common/user_info_setting_page.dart';
import '../../../../constant/call_back_function.dart';
import '../../../../constant/enum/login_enum.dart';
import '../../../../models/data/validate_result_data.dart';
import '../../../../models/http/api/auth_api.dart';
import '../../../../models/http/parameter/user_info_data.dart';
import '../../../../widgets/dialog/simple_custom_dialog.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../models/http/parameter/blacklist_config_data.dart';
import '../../../views/main_page.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../base_view_model.dart';
import '../../gobal_provider/global_tag_controller_provider.dart';
import '../../gobal_provider/user_info_provider.dart';


class ModifyEmailViewModel extends BaseViewModel {
  ModifyEmailViewModel(this.ref, this.blacklistConfigData, {required this.setState});
  final ViewChange setState;
  final WidgetRef ref;
  final BlacklistConfigData blacklistConfigData;


  TextEditingController passwordController = TextEditingController();
  TextEditingController googleCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();
  final String tagEmailCode = "emailCode";
  bool isProcess = false;
  UserInfoData get userInfo => ref.watch(userInfoProvider);

  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData googleCodeData = ValidateResultData();
  ValidateResultData emailData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();


  void initResult(String tag) {
    ref.read(globalValidateDataProvider(tag).notifier)
        .update((state) => ValidateResultData());
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) {
    AuthAPI(onConnectFail: (errorMessage)
    => onBaseConnectFail(context, errorMessage))
        .sendAuthActionMail(action: LoginAction.updateEmail, email: emailController.text,userInfo: userInfo).then((value) {
      if(value.message =="SUCCESS"){
        SimpleCustomDialog(context, mainText:tr('pleaseGotoMailboxReceive')).show();
      }
    });
  }


  /// 確認更改信箱
  void onPressConfirm(BuildContext context) {
    if (!checkEmptyController()) {
      googleCodeData = ValidateResultData(result: googleCodeController.text.isNotEmpty);
      passwordData = ValidateResultData(result: passwordController.text.isNotEmpty);
      emailData = ValidateResultData(result: emailController.text.isNotEmpty);
      emailCodeData = ValidateResultData(result: emailCodeController.text.isNotEmpty);
      setState((){});
      return;
    } else {
      UserInfoAPI(
          onConnectFail: (message)=> showFailedDialog(context, message))
          .modifyEmail(googleCodeController.text,
          passwordController.text,
          emailController.text,
          emailCodeController.text)
          .then((value) => showSuccessDialog(context));

    }
  }


  bool checkEmptyController() {
    return passwordController.text.isNotEmpty &&
        googleCodeController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailCodeController.text.isNotEmpty;
  }

  void onEmailChange(String value) {
    emailCodeData = ValidateResultData();
    emailData = ValidateResultData();
    setState((){});
  }


  void showSuccessDialog(BuildContext context) {
    CommonCustomDialog(context,
        title: tr("changeSuccess"),
        content: "",
        type: DialogImageType.success,
        rightBtnText: tr('confirm'),
        onLeftPress: () {}, onRightPress: () => {
          pushPage(context,const MainPage(type:AppNavigationBarType.typePersonal)),
          pushPage(context, UserInfoSettingPage(blacklistConfigData)),
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