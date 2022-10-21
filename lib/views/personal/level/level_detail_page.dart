import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../view_models/personal/level/level_detail_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/action_button_widget.dart';
import '../../../widgets/label/custom_linear_progress.dart';

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

  Widget _buildSpace({double height = 5}) {
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
          '${tr('lv_point')} : ${viewModel.levelInfo?.point} / ${viewModel.levelInfo?.pointRequired} (${viewModel.getStrPointPercentage()})',
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
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const BaseIconWidget(imageAssetPath: AppImagePath.walletLogIcon),
        SizedBox(width: UIDefine.getScreenWidth(2)),
        Text(
          tr('pt_DAILY'),
          style: TextStyle(fontSize: UIDefine.fontSize16),
        ),
        Flexible(child: Container()),
        const BaseIconWidget(imageAssetPath: AppImagePath.rightArrow)
      ]),
      _buildSpace(height: 2),

      ///MARK: 成就
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const BaseIconWidget(imageAssetPath: AppImagePath.trophyIcon),
        SizedBox(width: UIDefine.getScreenWidth(2)),
        Text(
          tr('achievement'),
          style: TextStyle(fontSize: UIDefine.fontSize16),
        ),
        Flexible(child: Container()),
        const BaseIconWidget(imageAssetPath: AppImagePath.rightArrow)
      ]),
    ]);
  }

  ///MARK: 建立現在等級諮詢
  Widget _buildCurrentLevelInfo() {
    return Container();
  }

  ///MARK: 建立全部等級資訊
  Widget _buildAllLevelInfo() {
    return Container();
  }
}
