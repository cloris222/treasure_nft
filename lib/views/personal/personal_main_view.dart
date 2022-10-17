// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_common_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_level_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_order_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_team_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../models/http/parameter/check_level_info.dart';
import '../../view_models/personal/personal_main_viewmodel.dart';
import '../../widgets/button/login_bolder_button_widget.dart';
import '../main_page.dart';

class PersonalMainView extends StatefulWidget {
  const PersonalMainView({Key? key}) : super(key: key);

  @override
  State<PersonalMainView> createState() => _PersonalMainViewState();
}

class _PersonalMainViewState extends State<PersonalMainView> {
  late PersonalMainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PersonalMainViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          const DomainBar(),
          const PersonalSubUserInfoView(showLevelInfo: true),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                PersonalSubLevelView(
                  userProperty: viewModel.userProperty,
                  levelInfo: viewModel.levelInfo,
                ),
                const PersonalSubOrderView(),
                const PersonalSubTeamView(),
                const PersonalSubCommonView(),
                LoginBolderButtonWidget(
                    btnText: tr('logout'),
                    onPressed: () => _onPressLogout(context)),
              ],
            ),
          ),
        ]),
      ),
    );
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
