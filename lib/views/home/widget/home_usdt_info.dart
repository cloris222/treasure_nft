import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';

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
    TextStyle titleBolderStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        color: AppColors.textNineBlack,
        fontWeight: FontWeight.w400);
    TextStyle valueStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize26,
        fontWeight: FontWeight.w600,
        color: AppColors.textBlack,
        fontFamily: AppTextFamily.Posterama1927);

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
                Text('${viewModel.volumeData?.transactionAmount ?? '0'}K+',
                    style: valueStyle),
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
                Text('${viewModel.volumeData?.cost ?? '0'}K+',
                    style: valueStyle),
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
                Text('${viewModel.volumeData?.nfts ?? '0'}K+',
                    style: valueStyle),
                viewModel.buildSpace(height: 1),
                Text('${tr('NFTs')} ', style: titleBolderStyle),
                viewModel.buildSpace(height: 1),
              ]))
        ]));
  }
}
