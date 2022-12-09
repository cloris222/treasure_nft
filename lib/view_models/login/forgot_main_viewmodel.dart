// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/data/validate_result_data.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

class ForgotMainViewModel extends BaseViewModel {
  ForgotMainViewModel({required this.setState});

  final ViewChange setState;

  // TextEditingController accountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // ValidateResultData accountData = ValidateResultData();
  ValidateResultData emailData = ValidateResultData();

  void dispose() {
    // accountController.dispose();
    emailController.dispose();
  }

  bool checkEmptyController() {
    // return accountController.text.isNotEmpty;
    return emailController.text.isNotEmpty;
  }

  void resetData() {
    // accountData = ValidateResultData();
    emailData = ValidateResultData();
  }

  void onPressCancel() {
    setState(() {
      resetData();
      // accountController.text = '';
      emailController.text = '';
    });
  }

  void onPressConfirm(BuildContext context) {
    if (!checkEmptyController()) {
      setState(() {
        // accountData = ValidateResultData(result: accountController.text.isNotEmpty);
        emailData = ValidateResultData(result: emailController.text.isNotEmpty);
      });
      return;
    } else {
      LoginAPI(onConnectFail: (message) => _onConnectFail(context, message))
          .forgetPassword(email: emailController.text)
          .then((value) async {
        popPage(context);
        SimpleCustomDialog(context,
                mainText: tr('pleaseMailboxReceiveNewPassword'))
            .show();
      });
    }
  }

  _onConnectFail(BuildContext context, String message) {
    SimpleCustomDialog(context,isSuccess: false, mainText: tr('accountOrMailboxError')).show();
  }

  void onTap() {
    setState(() {
      resetData();
    });
  }
}
