import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../models/http/parameter/sign_in_data.dart';
import '../widgets/button/action_button_widget.dart';

///MARK: 每日簽到
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.data}) : super(key: key);
  final SignInData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: _buildItem,
          itemCount: data.finishedDateList.length,
        ),
      ),
      ActionButtonWidget(
          btnText: tr('checkin'), onPressed: () => _onPressSignIn(context))
    ])));
  }

  Widget _buildItem(BuildContext context, int index) {
    return Text(data.finishedDateList[index]);
  }

  void _onPressSignIn(BuildContext context) {
    GlobalData.signInInfo = null;
    BaseViewModel().popPage(context);
  }
}
