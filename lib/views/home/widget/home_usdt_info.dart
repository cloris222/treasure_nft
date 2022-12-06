import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/trading_volume_data.dart';
import '../../../view_models/home/home_main_viewmodel.dart';
import '../../../widgets/gradient_text.dart';

class HomeUsdtInfo extends StatefulWidget {
  const HomeUsdtInfo({Key? key}) : super(key: key);

  @override
  State<HomeUsdtInfo> createState() => _HomeUsdtInfoState();
}

class _HomeUsdtInfoState extends State<HomeUsdtInfo> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  TradingVolumeData? data;

  @override
  void initState() {
    super.initState();
    viewModel.getUsdtInfo().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: UIDefine.fontSize12,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w300);
    TextStyle titleBolderStyle = TextStyle(
        fontSize: UIDefine.fontSize12,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w500);
    TextStyle valueStyle = TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack);
    TextStyle hintStyle =
        TextStyle(fontSize: UIDefine.fontSize10, color: AppColors.barFont01);

    StrutStyle strutStyle =
        const StrutStyle(forceStrutHeight: true, leading: 0.5);

    return SizedBox(
        width: UIDefine.getWidth(),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ///MARK: 交易額
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Wrap(children: [
                  Text(tr('vol'),
                      style: titleBolderStyle, strutStyle: strutStyle),
                  Text(' (${tr('usdt')})',
                      style: titleStyle, strutStyle: strutStyle)
                ]),
                viewModel.buildSpace(height: 1),
                Text('${data?.transactionAmount ?? '0'}M', style: valueStyle),
                viewModel.buildSpace(height: 1),
                Text(tr('last24h'), style: hintStyle)
              ])),

          _buildLine(),

          ///MARK: 費用
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Wrap(children: [
                  Text(tr("index-fee'"),
                      style: titleBolderStyle, strutStyle: strutStyle),
                  Text(' (${tr('usdt')})',
                      style: titleStyle, strutStyle: strutStyle)
                ]),
                viewModel.buildSpace(height: 1),
                Text('${data?.cost ?? '0'}M', style: valueStyle),
                viewModel.buildSpace(height: 1),
                Text(tr('updated-3-min\''), style: hintStyle)
              ])),

          _buildLine(),

          ///MARK: NFT
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${tr('NFTs')} (${tr('usdt')})', style: titleStyle),
                viewModel.buildSpace(height: 1),
                GradientText('${data?.nfts ?? '0'}M',
                    size: UIDefine.fontSize14, weight: FontWeight.w500),
                viewModel.buildSpace(height: 1),
                Text(tr('trading'), style: hintStyle)
              ]))
        ]));
  }

  Widget _buildLine() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: UIDefine.getScreenHeight(10),
        child: const VerticalDivider(
          color: AppColors.pageUnChoose,
          thickness: 1,
        ));
  }
}
