import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_bonus_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

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
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child: TitleAppBar(title: tr('bonus'), needArrowIcon: false),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child: _buildBody(),
          ))),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTradeView(),
        _buildShareView(),
      ],
    );
  }

  Widget _buildSpace({double height = 2}) {
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
      Container(
        decoration: AppStyle().styleColorsRadiusBackground(
            color: const Color(0xFFF7F7F7), radius: 4),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
        child: Row(
          children: [
            _buildCanView(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextView(
                    tr('bonus_trade'), viewModel.levelBonus?.tradeBonus),
                _buildNextBonusHint(
                    viewModel.levelBonus?.nextLevel,
                    viewModel.levelBonus?.nextLevelTradeBonus,
                    viewModel.levelBonus?.nextLevelTradeBonusPct),
                _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
              ],
            )),
          ],
        ),
      ),

      SizedBox(height: UIDefine.getPixelWidth(8)),
      _buildBonusHint(viewModel.levelBonus?.tradeMoneyBoxExpireTime,
          viewModel.levelBonus?.tradeMoneyBoxExpireDate),
      SizedBox(height: UIDefine.getPixelWidth(8)),
    ]);
  }

  Widget _buildShareView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: AppStyle().styleColorsRadiusBackground(
            color: const Color(0xFFF7F7F7), radius: 4),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
        child: Row(
          children: [
            _buildCanView(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextView(
                    tr('bonus_referral'), viewModel.levelBonus?.bonus),
                _buildNextBonusHint(
                    viewModel.levelBonus?.nextLevel,
                    viewModel.levelBonus?.nextLevelBonus,
                    viewModel.levelBonus?.nextLevelBonusPct),
                _buildMaxBonusHint(viewModel.levelBonus?.maxLevel),
              ],
            ))
          ],
        ),
      ),

      SizedBox(height: UIDefine.getPixelWidth(8)),
      _buildBonusHint(viewModel.levelBonus?.moneyBoxExpireTime,
          viewModel.levelBonus?.moneyBoxExpireDate),
      SizedBox(height: UIDefine.getPixelWidth(8)),
    ]);
  }

  /// Title &coin
  Widget _buildTextView(String title, double? currentCoin) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textBlack, fontSize: UIDefine.fontSize16)),
      _buildSpace(height: 1),
      // Row(mainAxisSize: MainAxisSize.min, children: [
      //   const TetherCoinWidget(),
      //   const SizedBox(width: 5),
      //   Text(NumberFormatUtil().removeTwoPointFormat(currentCoin ?? 0),
      //       style: AppTextStyle.getBaseStyle(
      //           color: AppColors.dialogBlack,
      //           fontSize: UIDefine.fontSize20,
      //           fontWeight: FontWeight.w500))
      // ])
    ]);
  }

  /// IMG
  Widget _buildCanView() {
    return SizedBox(
        height: UIDefine.getPixelWidth(100),
        child: Image.asset(AppImagePath.bonusIcon, fit: BoxFit.fitHeight));
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
        style: AppTextStyle.getBaseStyle(
            color: AppColors.textSixBlack,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w400));
  }

  /// 達到XX 可全部領取
  Widget _buildMaxBonusHint(int? level) {
    String text = format(tr('reach_level_all_hint'), {'level': level ?? 0});
    return Text(text,
        maxLines: 2,
        style: AppTextStyle.getBaseStyle(
            color: AppColors.textSixBlack,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w400));
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
        style: AppTextStyle.getBaseStyle(
            color: AppColors.textNineBlack,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w400));
  }
}
