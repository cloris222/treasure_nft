import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../view_models/trade/trade_draw_result_view_model.dart';

class TradeDrawResultPage extends StatefulWidget {
  const TradeDrawResultPage({Key? key}) : super(key: key);

  @override
  State<TradeDrawResultPage> createState() => _TradeDrawResultPageState();
}

class _TradeDrawResultPageState extends State<TradeDrawResultPage> {
  late TradeDrawResultViewModel viewModel;
  var mainPadding = EdgeInsets.only(
      left: UIDefine.getScreenWidth(8), right: UIDefine.getScreenWidth(8));

  @override
  void initState() {
    viewModel = TradeDrawResultViewModel(onViewChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needCover: true,
        body: Stack(
          children: [
            Container(
                width: UIDefine.getWidth(),
                constraints:
                    BoxConstraints(minHeight: UIDefine.getPixelHeight(1115)),
                padding: EdgeInsets.only(
                    top: UIDefine.getPixelHeight(70),
                    left: UIDefine.getScreenWidth(8),
                    right: UIDefine.getScreenWidth(8)),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImagePath.tradeDrawBg),
                        fit: BoxFit.fill)),
                child: Column(children: [
                  TitleAppBar(title: tr("winnersList")),
                  _buildActivityInfoView(),
                  SizedBox(height: UIDefine.getPixelHeight(70)),
                  _buildActivityAward(),
                  _buildBar(),
                  _buildDrawResultView(),
                  SizedBox(height: UIDefine.navigationBarPadding)
                ])),
            Positioned(
                right: 0,
                top: UIDefine.getPixelHeight(50),
                child: Image.asset(
                  AppImagePath.tradeDrawCoin,
                  width: UIDefine.getWidth() * 0.3,
                  fit: BoxFit.fitWidth,
                ))
          ],
        ),
        needScrollView: true);
  }

  ///MARK: 活動資訊
  Widget _buildActivityInfoView() {
    return Container(
      width: UIDefine.getWidth(),
      margin: EdgeInsets.only(bottom: UIDefine.getScreenHeight(5)),
      alignment: Alignment.centerLeft,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              'Winner List',
              weight: FontWeight.w500,
              size: UIDefine.fontSize28,
              starColor: AppColors.drawColorBg[1],
            ),
            GradientText(
              'Announcement',
              weight: FontWeight.w500,
              size: UIDefine.fontSize28,
              starColor: AppColors.drawColorBg[1],
            ),
            SizedBox(height: UIDefine.getPixelHeight(20)),
            _buildActivityDate(),
          ]),
    );
  }

  Widget _buildActivityDate() {
    TextStyle textStyle = TextStyle(
        color: AppColors.mainThemeButton,
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500);

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
          'form ${viewModel.getActivityChangeTime(viewModel.drawResultInfo?.startAt ?? '')}',
          textAlign: TextAlign.right,
          style: textStyle),
      Text(
          'to ${viewModel.getActivityChangeTime(viewModel.drawResultInfo?.endAt ?? '')}',
          textAlign: TextAlign.right,
          style: textStyle)
    ]);
  }

  ///MARK: 獎項清單
  Widget _buildActivityAward() {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          _buildAwardTopItem(1),
          SizedBox(width: UIDefine.getScreenWidth(3)),
          _buildAwardTopItem(2),
          SizedBox(width: UIDefine.getScreenWidth(3)),
          _buildAwardTopItem(3)
        ]),
        SizedBox(height: UIDefine.getScreenHeight(1)),
        Row(children: [
          _buildActivityBottomItem(1),
          SizedBox(width: UIDefine.getScreenWidth(3)),
          _buildActivityBottomItem(2),
          SizedBox(width: UIDefine.getScreenWidth(3)),
          _buildActivityBottomItem(3)
        ]),
      ],
    );
  }

  Widget _buildAwardTopItem(int index) {
    return Expanded(
      child: Opacity(
          opacity: 0.87,
          child: Container(
              decoration: AppStyle()
                  .buildGradient(radius: 5, colors: AppColors.drawColorBg),
              padding: const EdgeInsets.all(5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(AppImagePath.tradeDrawInfoStar),
                Expanded(
                    child: Column(children: [
                  Text(viewModel.getPrize(index),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: UIDefine.fontSize16)),
                  Text('prize',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: UIDefine.fontSize14))
                ]))
              ]))),
    );
  }

  Widget _buildActivityBottomItem(int index) {
    return Expanded(
        child: Container(
            decoration: AppStyle().styleColorsRadiusBackground(
                radius: 5, color: Colors.white.withOpacity(0.3)),
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    child: Text(
                        NumberFormatUtil()
                            .integerFormat(viewModel.getPrizeAmount(index)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: UIDefine.fontSize16))),
                const SizedBox(width: 5),
                BaseIconWidget(
                    imageAssetPath: AppImagePath.tradeDrawInfoCoin,
                    size: UIDefine.fontSize12)
              ]),
              Center(
                  child: Text('${viewModel.getPrizePerson(index)} person',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: UIDefine.fontSize14)))
            ])));
  }

  ///MARK: 結果清單
  Widget _buildDrawResultView() {
    return SizedBox(
        width: UIDefine.getWidth(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(children: [
            SizedBox(width: UIDefine.getScreenWidth(15)),
            Expanded(
                child: Image.asset(AppImagePath.tradeDrawResultTitle,
                    fit: BoxFit.fitWidth)),
            SizedBox(width: UIDefine.getScreenWidth(15))
          ]),
          SizedBox(height: UIDefine.getScreenHeight(1)),
          _buildDrawResultList(),
        ]));
  }

  Widget _buildBar() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenHeight(2)),
        height: UIDefine.getScreenHeight(3),
        alignment: Alignment.center,
        child: Row(children: const [
          Expanded(child: Divider(color: AppColors.drawLine, thickness: 1)),
          SizedBox(width: 10),
          BaseIconWidget(imageAssetPath: AppImagePath.tradeDrawResultStar),
          SizedBox(width: 10),
          Expanded(child: Divider(color: AppColors.drawLine, thickness: 1))
        ]));
  }

  Widget _buildDrawResultList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          int length =
              viewModel.drawResultInfo!.prizeList[index].winners.length;

          return Column(children: [
            Container(
                decoration: AppStyle().styleColorsRadiusBackground(
                    radius: 5, color: AppColors.drawLine.withOpacity(0.3)),
                padding: const EdgeInsets.all(5),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(AppImagePath.tradeDrawResultStar),
                  Text(' ${viewModel.getFullPrize(index + 1)} prize',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: UIDefine.fontSize16))
                ])),
            SizedBox(height: UIDefine.getScreenHeight(1)),
            Container(
                decoration: AppStyle().styleColorsRadiusBackground(
                    radius: 5, color: Colors.white.withOpacity(0.3)),
                padding: const EdgeInsets.all(5),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: length == 1 ? 1 : 2,
                        childAspectRatio: length == 1 ? 8 : 4,
                        mainAxisSpacing: UIDefine.getScreenWidth(1),
                        crossAxisSpacing: UIDefine.getScreenWidth(1)),
                    itemBuilder: (context, subIndex) {
                      return Center(
                        child: Text(
                            viewModel.drawResultInfo!.prizeList[index]
                                .winners[subIndex],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: UIDefine.fontSize12,
                                fontWeight: FontWeight.w500)),
                      );
                    }))
          ]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: UIDefine.getScreenHeight(3));
        },
        itemCount: viewModel.drawResultInfo?.prizeList.length ?? 0);
  }
}
