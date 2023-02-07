// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_common_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_level_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_order_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_team_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/personal/personal_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../server_web_page.dart';
import '../setting_language_page.dart';

class PersonalMainView extends StatefulWidget {
  const PersonalMainView({Key? key, required this.onViewChange})
      : super(key: key);
  final onClickFunction onViewChange;

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
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagePath.backgroundUser),
                    fit: BoxFit.fill)),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
                  child: PersonalNewSubUserInfoView(
                    onViewUpdate: () {
                      setState(() {});
                      widget.onViewChange();
                    },
                    showDailyTask: true,
                    enableModify: true,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: UIDefine.getScreenWidth(3.5)),
                  child: Column(children: [
                    // PersonalSubLevelView( // 第一版UI
                    //   userProperty: GlobalData.userProperty,
                    //   levelInfo: GlobalData.userLevelInfo,
                    //   onViewUpdate: _onViewUpdate,
                    // ),
                    PersonalNewSubLevelView(
                      userProperty: GlobalData.userProperty,
                      levelInfo: GlobalData.userLevelInfo,
                      onViewUpdate: _onViewUpdate,
                    ),
                    // _buildLine(),
                    // PersonalSubOrderView(
                    //     userOrderInfo: GlobalData.userOrderInfo),
                    // _buildLine(),
                    PersonalNewSubOrderView(
                        userOrderInfo: GlobalData.userOrderInfo),
                    // PersonalSubTeamView(levelInfo: GlobalData.userLevelInfo),
                    // _buildLine(),
                    PersonalNewSubTeamView(levelInfo: GlobalData.userLevelInfo),
                    // PersonalSubCommonView(onViewUpdate: () {
                    //   setState(() {});
                    //   widget.onViewChange();
                    // }),
                    PersonalNewSubCommonView(onViewUpdate: () {
                      setState(() {});
                      widget.onViewChange();
                    }),
                    const SizedBox(height: 10)
                  ]))
            ])));
  }

  Widget _buildLine() {
    return const Divider(color: AppColors.searchBar, thickness: 1);
  }

  void _onViewUpdate() {
    ///MARK: 先更新已更新的資料狀態
    setState(() {});
    viewModel.updateData();
  }

}
