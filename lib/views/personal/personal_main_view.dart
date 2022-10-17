import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
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
    GlobalData.userToken = '';
    BaseViewModel().pushAndRemoveUntil(context, const MainPage());
  }
}
