import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/trading_volume_data.dart';
import '../../../view_models/home/home_main_viewmodel.dart';

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
    TextStyle titleBolderStyle = TextStyle(
        fontSize: UIDefine.fontSize12,
        color: AppColors.homeGrey,
        fontWeight: FontWeight.w300);
    TextStyle valueStyle = TextStyle(
        fontSize: UIDefine.fontSize24,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack);

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
                Text('${data?.transactionAmount ?? '0'}K+', style: valueStyle),
                viewModel.buildSpace(height: 1),
                Wrap(children: [
                  Text(tr('vol'),
                      style: titleBolderStyle, strutStyle: strutStyle),
                ]),
                viewModel.buildSpace(height: 1),
              ])),

          // _buildLine(),

          ///MARK: 費用
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${data?.cost ?? '0'}K+', style: valueStyle),
                viewModel.buildSpace(height: 1),
                Wrap(children: [
                  Text(tr("index-fee'"),
                      style: titleBolderStyle, strutStyle: strutStyle),
                ]),
                viewModel.buildSpace(height: 1),
              ])),

          // _buildLine(),

          ///MARK: NFT
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${data?.nfts ?? '0'}K+', style: valueStyle),
                viewModel.buildSpace(height: 1),
                Text('${tr('NFTs')} ', style: titleBolderStyle),
                viewModel.buildSpace(height: 1),
              ]))
        ]));
  }
}
