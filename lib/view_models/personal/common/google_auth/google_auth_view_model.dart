import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constant/call_back_function.dart';
import '../../../../models/http/api/user_info_api.dart';
import '../../../../views/main_page.dart';
import '../../../../views/personal/common/user_setting_page.dart';
import '../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../widgets/dialog/common_custom_dialog.dart';
import '../../../../widgets/dialog/simple_custom_dialog.dart';
import '../../../base_view_model.dart';
import 'google_auth_provider.dart';

class GoogleAuthViewModel extends BaseViewModel {
  GoogleAuthViewModel(this.ref, {required this.setState});
  final ViewChange setState;
  final WidgetRef ref;
  bool clickSuccess = false;

  TextEditingController verifyController = TextEditingController();
  bool get isProcess => ref.watch(googleProcessProvider);

  /// 綁定按鈕
  Future<void> onPressSave(BuildContext context) async {
    if (verifyController.text == "") {
      SimpleCustomDialog(context, isSuccess: false, mainText: tr('enterGoogleVerification')).show();
      return;
    }
    switchProcess();
    await UserInfoAPI(onConnectFail: (message) => {onBaseConnectFail(context, message), switchProcess()})
        .bindGoogleAuth(verifyController.text)
        .then((value) => {
              if (value == "SUCCESS")
                {
                  CommonCustomDialog(context,
                      title: tr("bind-successfully"),
                      content: "",
                      type: DialogImageType.success,
                      rightBtnText: tr('confirm'),
                      onLeftPress: () {},
                      onRightPress: () => {
                            clickSuccess = true,
                            pushPage(context, const MainPage(type: AppNavigationBarType.typePersonal)),
                            pushPage(context, const UserSettingPage()),
                            switchProcess(),
                          }).show(),
                  Future.delayed(Duration(seconds: 2)).then((time) {
                    if (!clickSuccess) {
                      pushPage(context, const MainPage(type: AppNavigationBarType.typePersonal));
                      pushPage(context, const UserSettingPage());
                      switchProcess();
                    }
                  }),
                }
            });
  }

  void switchProcess() {
    ref.read(googleProcessProvider.notifier).update((state) => !isProcess);
  }
}
