// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_common_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_level_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_order_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_team_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/theme/app_colors.dart';
import '../../view_models/personal/personal_main_viewmodel.dart';

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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    PersonalSubLevelView(
                      userProperty: viewModel.userProperty,
                      levelInfo: viewModel.levelInfo,
                    ),
                    _buildLine(),
                    PersonalSubOrderView(
                        userOrderInfo: viewModel.userOrderInfo),
                    _buildLine(),
                    PersonalSubTeamView(levelInfo: viewModel.levelInfo),
                    _buildLine(),
                    const PersonalSubCommonView(),
                  ]))
            ])));
  }

  Widget _buildLine() {
    return const Divider(color: AppColors.searchBar);
  }
}
