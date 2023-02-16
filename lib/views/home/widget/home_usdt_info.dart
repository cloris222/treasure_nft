import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/home/provider/home_usdt_provider.dart';
import '../home_main_style.dart';

class HomeUsdtInfo extends ConsumerWidget with HomeMainStyle {
  const HomeUsdtInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle titleBolderStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        color: AppColors.textNineBlack,
        fontWeight: FontWeight.w400);
    TextStyle valueStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize22,
        fontWeight: FontWeight.w600,
        color: AppColors.textBlack,
        fontFamily: AppTextFamily.Posterama1927);

    StrutStyle strutStyle =
        const StrutStyle(forceStrutHeight: true, leading: 0.5);
    double maxWidth = (UIDefine.getWidth()) * 0.33;
    double spaceWidth = (UIDefine.getWidth()) * 0.03;

    return SizedBox(
        width: UIDefine.getWidth(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///MARK: 交易額
              Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ref.watch(homeUSDTProvider).transactionAmount}K+',
                          style: valueStyle),
                      buildSpace(height: 1),
                      Wrap(children: [
                        Text(tr('vol'),
                            style: titleBolderStyle, strutStyle: strutStyle),
                      ]),
                      buildSpace(height: 1),
                    ]),
              ),

              SizedBox(width: spaceWidth),
              // _buildLine(),

              ///MARK: 費用
              Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${ref.watch(homeUSDTProvider).cost}K+',
                            style: valueStyle),
                        buildSpace(height: 1),
                        Wrap(children: [
                          Text(tr("index-fee'"),
                              style: titleBolderStyle, strutStyle: strutStyle),
                        ]),
                        buildSpace(height: 1),
                      ])),

              SizedBox(width: spaceWidth),

              ///MARK: NFT
              Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${ref.watch(homeUSDTProvider).nfts}K+',
                            style: valueStyle),
                        buildSpace(height: 1),
                        Text('${tr('NFTs')} ', style: titleBolderStyle),
                        buildSpace(height: 1),
                      ]))
            ]));
  }
}
