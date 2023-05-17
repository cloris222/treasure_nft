
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/call_back_function.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';
import '../../base_view_model.dart';
import 'google_auth_provider.dart';


class GoogleAuthViewModel extends BaseViewModel {
  GoogleAuthViewModel(this.ref, {required this.setState});
  final ViewChange setState;
  final WidgetRef ref;

  TextEditingController verifyController = TextEditingController();
  bool get isProcess => ref.watch(googleProcessProvider);

  /// 綁定按鈕
  Future<void> onPressSave(BuildContext context) async{
    if (verifyController.text == "") {
      SimpleCustomDialog(context,
          isSuccess: false, mainText: tr('enterGoogleVerification')).show();
      return;
    }
    switchProcess();
    await UserInfoAPI(
        onConnectFail:(message) => {
          onBaseConnectFail(context, message),
          switchProcess()
        })
        .bindGoogleAuth(verifyController.text)
        .then((value) => {popPage(context), switchProcess()});
  }

  void switchProcess() {
    ref.read(googleProcessProvider.notifier).update((state) => !isProcess);
  }
}