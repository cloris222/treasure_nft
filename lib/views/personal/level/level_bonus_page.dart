import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/personal/level/level_bonus_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

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
    return CustomAppbarView(
      needScrollView: false,
      title: tr("bonus"),
      type: AppNavigationBarType.typePersonal,
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: UIDefine.getScreenWidth(15),
                  vertical: UIDefine.getScreenHeight(3)),
              child: _buildBody())),
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
            child: _buildTextView(
                tr('bonus_trade'), viewModel.levelBonus?.tradeBonus)),
        Flexible(child: _buildCanView())
      ]),
      _buildNextBonusHint(
          viewModel.levelBonus?.nextLevel,
          viewModel.levelBonus?.nextLevelTradeBonus,
          viewModel.levelBonus?.nextLevelTradeBonusPct),
      _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
      _buildSpace(),
      _buildBonusHint(viewModel.levelBonus?.tradeMoneyBoxExpireTime,
          viewModel.levelBonus?.tradeMoneyBoxExpireDate)
      // _buildNextBonusHint(level, bonus, percentage)
    ]);
  }

  Widget _buildShareView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Flexible(child: _buildCanView()),
        Flexible(
            child: _buildTextView(
                tr('bonus_referral'), viewModel.levelBonus?.bonus))
      ]),
      _buildNextBonusHint(
          viewModel.levelBonus?.nextLevel,
          viewModel.levelBonus?.nextLevelBonus,
          viewModel.levelBonus?.nextLevelBonusPct),
      _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
      _buildSpace(),
      _buildBonusHint(viewModel.levelBonus?.moneyBoxExpireTime,
          viewModel.levelBonus?.moneyBoxExpireDate)
      // _buildNextBonusHint(level, bonus, percentage)
    ]);
  }

  /// Title &coin
  Widget _buildTextView(String title, double? currentCoin) {
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  color: AppColors.dialogBlack,
                  fontSize: UIDefine.fontSize20,
                  fontWeight: FontWeight.w600)),
          _buildSpace(height: 1),
          Row(mainAxisSize: MainAxisSize.min, children: [
            const TetherCoinWidget(),
            const SizedBox(width: 5),
            Text(NumberFormatUtil().removeTwoPointFormat(currentCoin ?? 0),
                style: TextStyle(
                    color: AppColors.dialogBlack,
                    fontSize: UIDefine.fontSize20,
                    fontWeight: FontWeight.w600))
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
    String text = format('※${tr('bonus_keep_hint')}', {
      'day': hasDay ?? '',
      'date': day == null
          ? ''
          : day.isEmpty
              ? ''
              : BaseViewModel()
                  .changeTimeZone('$day 00:00:00', strFormat: 'yyyy-MM-dd')
    });
    return Text(text,
        maxLines: 2,
        style: TextStyle(
            color: AppColors.dialogGrey,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w500));
  }
}
