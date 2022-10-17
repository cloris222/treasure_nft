// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';

import '../../widgets/button/login_bolder_button_widget.dart';
import '../main_page.dart';

class PersonalMainView extends StatelessWidget {
  const PersonalMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GradientText('暫時的登出!'),
      LoginBolderButtonWidget(
          btnText: tr('logout'), onPressed: () => _onPressLogout(context)),
    ]);
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
