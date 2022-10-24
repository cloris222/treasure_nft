import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/personal/level/level_bonus_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';

class LevelBonusPage extends StatefulWidget {
  const LevelBonusPage({Key? key}) : super(key: key);

  @override
  State<LevelBonusPage> createState() => _LevelBonusPageState();
}

class _LevelBonusPageState extends State<LevelBonusPage> {
  late LevelBonusViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LevelBonusViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('bonus')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: UIDefine.getScreenWidth(15),
                  vertical: UIDefine.getScreenHeight(3)),
              child: _buildBody())),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [_buildTradeView(), _buildLine(), _buildShareView()],
    );
  }

  Widget _buildSpace({double height = 4}) {
    return SizedBox(height: UIDefine.getScreenHeight(height));
  }

  Widget _buildLine() {
    return Column(children: [
      _buildSpace(),
      const Divider(color: AppColors.searchBar),
      _buildSpace()
    ]);
  }

  Widget _buildTradeView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Flexible(
            child: _buildTextView(tr('交易儲蓄罐'), viewModel.levelBonus?.bonus)),
        Flexible(child: _buildCanView())
      ]),
      _buildNextBonusHint(
          viewModel.levelBonus?.nextLevel,
          viewModel.levelBonus?.nextLevelBonus,
          viewModel.levelBonus?.nextLevelBonusPct),
      _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
      _buildBonusHint(12, '10/20')
      // _buildNextBonusHint(level, bonus, percentage)
    ]);
  }

  Widget _buildShareView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Flexible(child: _buildCanView()),
        Flexible(
            child: _buildTextView(tr('推廣儲蓄罐'), viewModel.levelBonus?.bonus))
      ]),
      _buildNextBonusHint(
          viewModel.levelBonus?.nextLevel,
          viewModel.levelBonus?.nextLevelBonus,
          viewModel.levelBonus?.nextLevelBonusPct),
      _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
      _buildBonusHint(12, '10/20')
      // _buildNextBonusHint(level, bonus, percentage)
    ]);
  }

  /// Title &coin
  Widget _buildTextView(String title, double? currentCoin) {
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(title,
              style: TextStyle(
                  color: AppColors.dialogBlack,
                  fontSize: UIDefine.fontSize20,
                  fontWeight: FontWeight.w600)),
          _buildSpace(height: 1),
          Row(mainAxisSize: MainAxisSize.min, children: [
            const TetherCoinWidget(),
            const SizedBox(width: 5),
            Text(NumberFormatUtil().removeTwoPointFormat(currentCoin ?? 0))
          ])
        ]));
  }

  /// IMG
  Widget _buildCanView() {
    return Image.asset(AppImagePath.bonusIcon, fit: BoxFit.contain);
  }

  /// 達到XX 可領取XX
  Widget _buildNextBonusHint(int? level, double? bonus, int? percentage) {
    String text = format(tr('reach_level_hint'), {
      'level': level ?? 0,
      'bonus': NumberFormatUtil().removeTwoPointFormat(bonus ?? 0.0),
      'ratio': percentage ?? 0
    });
    return Text(text,
        maxLines: 2,
        style: TextStyle(
            color: AppColors.dialogGrey,
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w500));
  }

  /// 達到XX 可全部領取
  Widget _buildMaxBonusHint(int? level) {
    String text = format(tr('reach_level_all_hint'), {'level': level ?? 0});
    return Text(text,
        maxLines: 2,
        style: TextStyle(
            color: AppColors.dialogGrey,
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w500));
  }

  /// 提醒 剩餘OO天 XX天尚未升級
  Widget _buildBonusHint(int? hasDay, String? day) {
    String text = format('※獎勵保留{hasDay}天，{day}前未升級，將回收全部獎勵',
        {'hasDay': hasDay ?? 0, 'day': '0'});
    return Text(text,
        maxLines: 2,
        style: TextStyle(
            color: AppColors.dialogGrey,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w500));
  }
}
