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
    TextStyle valueStyle = TextStyle(
      fontSize: UIDefine.fontSize16,
      color: AppColors.textBlack,
    );
    TextStyle hintStyle = TextStyle(
      fontSize: UIDefine.fontSize12,
      color: AppColors.textGrey,
    );

    return SizedBox(
        width: UIDefine.getWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr('vol'), style: titleStyle),
                  viewModel.getPadding(1),
                  Text('(${tr('usdt')})', style: titleStyle),
                  viewModel.getPadding(1),
                  Text('${data?.transactionAmount ?? '0'}M', style: valueStyle),
                  viewModel.getPadding(1),
                  Text(
                    tr('last24h'),
                    style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),

            viewModel.getPadding(1),

            //分隔線
            SizedBox(
                height: UIDefine.getScreenHeight(10),
                child: const VerticalDivider(
                  width: 3,
                  color: AppColors.dialogBlack,
                  thickness: 0.5,
                )),

            viewModel.getPadding(1),

            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tr("index-fee'")} (${tr('usdt')})',
                    style: titleStyle,
                  ),
                  viewModel.getPadding(1),
                  Text(
                    '${data?.cost ?? '0'}M',
                    style: TextStyle(
                      fontSize: UIDefine.fontSize18,
                      color: AppColors.textBlack,
                    ),
                  ),
                  viewModel.getPadding(1),
                  Text(
                    tr('updated-3-min\''),
                    style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),

            viewModel.getPadding(1),

            //分隔線
            SizedBox(
                height: UIDefine.getScreenHeight(10),
                child: const VerticalDivider(
                  width: 3,
                  color: AppColors.dialogBlack,
                  thickness: 0.5,
                )),

            viewModel.getPadding(1),

            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${tr('NFTs')}(${tr('usdt')})', style: titleStyle),
                  viewModel.getPadding(1),
                  GradientText(
                    '${data?.nfts ?? '0'}M',
                    size: UIDefine.fontSize18,
                    endColor: AppColors.subThemePurple,
                  ),
                  viewModel.getPadding(1),
                  Text(
                    tr('trading'),
                    style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
