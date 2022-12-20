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
import 'package:treasure_nft_project/views/personal/personal_sub_common_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_level_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_order_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_team_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_theme.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/personal/personal_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../login/circle_network_icon.dart';
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
    return Stack(
      children: [
    SingleChildScrollView(
    child: Container(
    color: Colors.white,
        child: Column(children: [
          // const DomainBar(),

          ///MARK: 不可以上const
          // PersonalSubUserInfoView( // 第一版UI
          //   showLevelInfo: true,
          //   enableModify: true,
          //   onViewUpdate: () {
          //     setState(() {});
          //     widget.onViewChange();
          //   },
          // ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
              child: PersonalNewSubUserInfoView(
                  onViewUpdate: () {
                    setState(() {});
                    widget.onViewChange();
                  }
              )
          ),

          Container(
              margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(3.5)),
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
                PersonalNewSubOrderView(userOrderInfo: GlobalData.userOrderInfo),
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
        ]))),

        Positioned(
          right: UIDefine.getScreenWidth(20), left: UIDefine.getScreenWidth(20),
            bottom: UIDefine.getScreenWidth(4.15),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            color: AppColors.textWhite,
            child: Container(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(3.5)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () => _globalAction,
                        child: Image.asset(AppImagePath.globalImage,
                            width: UIDefine.getScreenWidth(7.46), height: UIDefine.getScreenWidth(7.46), fit: BoxFit.cover)),
                    const SizedBox(width: 8),
                    InkWell(
                        onTap: () => _serverAction,
                        child: Image.asset(AppImagePath.serverImage,
                            width: UIDefine.getScreenWidth(7.46), height: UIDefine.getScreenWidth(7.46), fit: BoxFit.cover)),
                    const SizedBox(width: 8),
                    InkWell(
                        onTap: () => _avatarAction,
                        child: Container(
                            height: UIDefine.getScreenWidth(6.72),
                            width: UIDefine.getScreenWidth(6.72),
                            decoration: AppTheme.style.baseGradient(radius: 15),
                            padding: const EdgeInsets.all(1),
                            child: BaseViewModel().isLogin() &&
                                GlobalData.userInfo.photoUrl.isNotEmpty
                                ? CircleNetworkIcon(
                                networkUrl: GlobalData.userInfo.photoUrl)
                                : Image.asset(AppImagePath.avatarImg))),
                    const SizedBox(width: 8),
                    InkWell(
                        onTap: () => _searchAction,
                        child:
                        Icon(Icons.search, color: Colors.grey, size: UIDefine.getScreenWidth(7.46)))
                  ])
            ),
          )
        ),

        Positioned(
          top: UIDefine.getScreenWidth(6), right: UIDefine.getScreenWidth(6),
          child: GestureDetector(
            onTap: () => _onDateIcon(),
            child: Image.asset(AppImagePath.dateIcon),
          )
        )
      ],
    );
  }

  Widget _buildLine() {
    return const Divider(color: AppColors.searchBar, thickness: 1);
  }

  void _onViewUpdate() {
    ///MARK: 先更新已更新的資料狀態
    setState(() {});
    viewModel.updateData();
  }

  void _onDateIcon() {
    // test 點擊後待確認
  }

  void _serverAction() {
    viewModel.pushPage(context, const ServerWebPage());
    // viewModel.pushPage(context, const SplashScreenPage());
  }

  void _searchAction() {
    GlobalData.mainBottomType = AppNavigationBarType.typeExplore;
    BaseViewModel().pushPage(context, ExploreMainView());
  }

  void _avatarAction() {
    setState(() {
      if (BaseViewModel().isLogin()) {
        GlobalData.mainBottomType = AppNavigationBarType.typePersonal;
        // BaseViewModel().pushPage(context, page);
      } else {
        GlobalData.mainBottomType = AppNavigationBarType.typeLogin;
        // BaseViewModel().pushPage(context, page);
      }
    });
  }

  void _globalAction() async {
    await BaseViewModel().pushPage(context, const SettingLanguagePage());
  }
}
