import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/level_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../view_models/personal/level/level_detail_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/action_button_widget.dart';
import '../../../widgets/label/custom_linear_progress.dart';
import 'level_achievement_page.dart';

///MARK: 等級詳細
class LevelDetailPage extends StatefulWidget {
  const LevelDetailPage({Key? key}) : super(key: key);

  @override
  State<LevelDetailPage> createState() => _LevelDetailPageState();
}

class _LevelDetailPageState extends State<LevelDetailPage> {
  late LevelDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LevelDetailViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('level')),
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildBody())),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSpace(),
        _buildCurrentLevelStatus(),
        _buildSpace(),
        _buildLine(),
        _buildSpace(),
        _buildCurrentLevelInfo(),
        _buildSpace(),
        _buildLine(),
        _buildSpace(),
        _buildAllLevelInfo(),
        _buildSpace(),
      ],
    );
  }

  Widget _buildSpace({double height = 4}) {
    return SizedBox(height: UIDefine.getScreenHeight(height));
  }

  Widget _buildLine() {
    return const Divider(color: AppColors.searchBar);
  }

  ///MARK: 建立現在等級狀態
  Widget _buildCurrentLevelStatus() {
    return Column(children: [
      LevelIconWidget(
          level: GlobalData.userInfo.level, size: UIDefine.getScreenHeight(20)),
      Text('${tr('level')} ${GlobalData.userInfo.level}',
          style: TextStyle(
              fontSize: UIDefine.fontSize30, fontWeight: FontWeight.w500)),
      _buildSpace(height: 2),

      ///MARK: 積分
      Row(children: [
        Text(
          '${tr('lv_point')} : ${viewModel.userLevelInfo?.point} / ${viewModel.userLevelInfo?.pointRequired} (${viewModel.getStrPointPercentage()})',
          style: TextStyle(
              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),
        ),
        Flexible(child: Container()),
        viewModel.isLevelUp
            ? ActionButtonWidget(
                btnText: tr('levelUp'),
                onPressed: () => viewModel.onPressLevelUp(context),
                isFillWidth: false)
            : ActionButtonWidget(
                setMainColor: AppColors.buttonGrey,
                btnText: tr('levelUp'),
                onPressed: () => viewModel.onPressLevelUp(context),
                isFillWidth: false)
      ]),
      _buildSpace(height: 2),

      ///MARK: 積分條
      Row(children: [
        Flexible(
            child: CustomLinearProgress(
          height: UIDefine.fontSize12,
          backgroundColor: AppColors.transParentHalf,
          valueColor: AppColors.mainThemeButton,
          percentage: viewModel.getPointPercentage(),
        )),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: viewModel.getPointPercentage() == 1
              ? BaseIconWidget(
                  imageAssetPath: AppImagePath.blueCheckIcon,
                  size: UIDefine.fontSize16)
              : Text(
                  viewModel.getStrPointPercentage(),
                  style: TextStyle(fontSize: UIDefine.fontSize12),
                ),
        )
      ]),
      _buildSpace(height: 2),

      ///MARK: 每日任務
      InkWell(
        onTap: () {
          viewModel.pushPage(context, const LevelAchievementPage());
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          BaseIconWidget(
              imageAssetPath: AppImagePath.walletLogIcon,
              size: UIDefine.fontSize18),
          SizedBox(width: UIDefine.getScreenWidth(2)),
          Text(
            tr('pt_DAILY'),
            style: TextStyle(fontSize: UIDefine.fontSize16),
          ),
          Flexible(child: Container()),
          BaseIconWidget(
              imageAssetPath: AppImagePath.rightArrow,
              size: UIDefine.fontSize18)
        ]),
      ),
      _buildSpace(height: 2),

      ///MARK: 成就
      InkWell(
        onTap: () {
          viewModel.pushPage(context, const LevelAchievementPage());
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          BaseIconWidget(
              imageAssetPath: AppImagePath.trophyIcon,
              size: UIDefine.fontSize18),
          SizedBox(width: UIDefine.getScreenWidth(2)),
          Text(
            tr('achievement'),
            style: TextStyle(fontSize: UIDefine.fontSize16),
          ),
          Flexible(child: Container()),
          BaseIconWidget(
              imageAssetPath: AppImagePath.rightArrow,
              size: UIDefine.fontSize18)
        ]),
      ),
    ]);
  }

  ///MARK: 建立現在等級諮詢
  Widget _buildCurrentLevelInfo() {
    if (viewModel.levelDataList.length > GlobalData.userInfo.level) {
      return Column(children: [
        _buildSingleLevelTitle(GlobalData.userInfo.level),
        _buildSpace(height: 2),
        _buildSingleLevelInfo(GlobalData.userInfo.level),
      ]);
    }
    return Container();
  }

  ///MARK: 建立全部等級資訊
  Widget _buildAllLevelInfo() {
    if (viewModel.levelDataList.isNotEmpty) {
      List<Widget> pages = [];
      for (var data in viewModel.levelDataList) {
        if (data.userLevel != 0) {
          pages.add(_buildLevelPageItem(data.userLevel));
        }
      }
      return SizedBox(
        height: UIDefine.getScreenHeight(70),
        child: PageView(children: pages),
      );
    }
    return Container();
  }

  ///MARK: 等級標題
  Widget _buildSingleLevelTitle(int level) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BaseIconWidget(
            imageAssetPath: viewModel.checkUnlock(level)
                ? AppImagePath.levelUnLock
                : AppImagePath.levelLock,
            size: UIDefine.fontSize26),
        Text(' ${tr('level')} $level ',
            style: TextStyle(
                fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w600)),
        LevelIconWidget(level: level, size: UIDefine.fontSize26)
      ],
    );
  }

  ///MARK: 等級詳細
  Widget _buildSingleLevelInfo(int level) {
    LevelInfoData data = viewModel.getSingleLevelInfo(level);

    return Column(
      children: [
        _buildSingleLevelInfoItem(
            title: tr('reserve_pro_range'),
            context:
                '${NumberFormatUtil().removeTwoPointFormat(data.buyRangeStart)} ~ ${NumberFormatUtil().removeTwoPointFormat(data.buyRangeEnd)}',
            showCoin: true),
        _buildSingleLevelInfoItem(
            title: tr('dialy_reserve'), context: '${data.dailyReverseAmount}'),
        _buildSingleLevelInfoItem(
            title: tr('trade_luk'),
            context: NumberFormatUtil().removeTwoPointFormat(data.couponRate)),
        _buildSingleLevelInfoItem(
            title: tr('directShare-extra'),
            context:
                '${NumberFormatUtil().removeTwoPointFormat(data.directShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.directSave)}%'),
        _buildSingleLevelInfoItem(
            title: tr('indirectShare-extra'),
            context:
                '${NumberFormatUtil().removeTwoPointFormat(data.indirectShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.indirectSave)}%'),
        _buildSingleLevelInfoItem(
            title: tr('thirdShare-extra'),
            context:
                '${NumberFormatUtil().removeTwoPointFormat(data.thirdShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.thirdSave)}%'),
      ],
    );
  }

  Widget _buildSingleLevelInfoItem(
      {required String title, required String context, bool showCoin = false}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenHeight(1)),
        child: Row(children: [
          Text(
            title,
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.dialogGrey),
          ),
          Flexible(child: Container()),
          Visibility(
              visible: showCoin,
              child: TetherCoinWidget(size: UIDefine.fontSize16)),
          SizedBox(width: UIDefine.getScreenWidth(1)),
          Text(
            context,
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.dialogBlack),
          )
        ]));
  }

  ///MARK: 等級清單
  Widget _buildLevelPageItem(int level) {
    return Column(children: [
      _buildSingleLevelTitle(level),
      _buildSpace(height: 2),
      _buildSingleLevelInfoRequest(level),
      _buildSpace(height: 2),
      _buildSingleLevelInfo(level),
    ]);
  }

  ///MARK:升級至下一等級的需求
  Widget _buildSingleLevelInfoRequest(int level) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().styleUserSetting(),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: level == 1
            ? _buildLevelOneRequest()
            : _buildLevelOtherRequest(level));
  }

  ///MARK:升級至等級1的需求
  Widget _buildLevelOneRequest() {
    return Column(
      children: [
        _buildSingleRequest(
            level: 1,
            title: tr('depositNFT'),
            value: viewModel.userLevelInfo!.depositAmount,
            request: viewModel.userLevelInfo!.depositAmountRequired),
      ],
    );
  }

  ///MARK:升級至其他等級的需求
  Widget _buildLevelOtherRequest(int level) {
    return Column(
      children: [
        _buildSingleRequest(
            level: level,
            title: tr('open_A_lv'),
            value: viewModel.userLevelInfo!.activeDirect,
            request: viewModel.userLevelInfo!.activeDirectRequired),
        _buildSingleRequest(
            level: level,
            title: tr('open_BC_lv'),
            value: viewModel.userLevelInfo!.activeIndirect,
            request: viewModel.userLevelInfo!.activeIndirectRequired),
      ],
    );
  }

  Widget _buildSingleRequest(
      {required int level,
      required String title,
      required dynamic value,
      required int request}) {
    double percentage = viewModel.checkUnlock(level) ? 1 : value / request;
    return Column(
      children: [
        Row(children: [
          Text(title),
          Flexible(child: Container()),
          Text(percentage == 1
              ? tr('Completed')
              : '${NumberFormatUtil().removeTwoPointFormat(value)} / $request'),
        ]),
        _buildSpace(height: 2),
        CustomLinearProgress(percentage: percentage),
        _buildSpace(height: 2),
      ],
    );
  }
}
