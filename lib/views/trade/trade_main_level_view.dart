import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

///MARK: 交易 切換交易等級&轉轉轉方塊
class TradeMainLevelView extends StatefulWidget {
  const TradeMainLevelView({Key? key, required this.viewModel})
      : super(key: key);
  final TradeNewMainViewModel viewModel;

  @override
  State<TradeMainLevelView> createState() => _TradeMainLevelViewState();
}

class _TradeMainLevelViewState extends State<TradeMainLevelView> {
  TradeNewMainViewModel get viewModel {
    return widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivision(),
        SizedBox(height: UIDefine.getPixelWidth(10)),
        _buildSystemInfo(),
      ],
    );
  }

  ///MARK: 中間選擇副本區間
  Widget _buildDivision() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: _buildLevelDropButton()),
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Expanded(child: _buildRangeDropButton()),
            ],
          ),
          _buildDivisionInfo()
        ],
      ),
    );
  }

  Widget _buildLevelDropButton() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.textSixBlack, radius: 8, borderLine: 0.5),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(viewModel.division.length,
            (index) {
          return DropdownMenuItem<int>(
            value: viewModel.division[index],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'LV ${viewModel.division[index]}',
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize12,
                    color: AppColors.textSixBlack,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
        }),
        value: viewModel.currentDivision,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              viewModel.currentDivision = value;
            });
            viewModel.getDivisionLevelInfo(value);
          }
        },
        buttonHeight: 40,
        dropdownMaxHeight: 200,
        buttonWidth: 140,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildRangeDropButton() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.textSixBlack, radius: 8, borderLine: 0.5),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        isExpanded: true,
        hint: Row(children: [
          TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          Text('0-0',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w600))
        ]),
        items: List<DropdownMenuItem<int>>.generate(viewModel.ranges.length,
            (index) {
          return DropdownMenuItem<int>(
            value: index,
            child: Row(
              children: [
                TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
                SizedBox(width: UIDefine.getPixelWidth(5)),
                Text(
                  '${NumberFormatUtil().numberCompatFormat(viewModel.ranges[index].startPrice.toString(), decimalDigits: 0)}-${NumberFormatUtil().numberCompatFormat(viewModel.ranges[index].endPrice.toString(), decimalDigits: 0)}',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }),
        value: viewModel.ranges.isEmpty ? null : viewModel.currentIndex,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              viewModel.currentIndex = value;
            });
            viewModel.getDivisionIndexInfo(viewModel.ranges[value].index);
          }
        },
        buttonHeight: 40,
        dropdownMaxHeight: 200,
        buttonWidth: 140,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildDivisionInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Text('${viewModel.checkReserveDeposit?.reward}')],
    );
  }

  ///MARK: 交易量
  Widget _buildSystemInfo() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItem(tr('tradeVol'),
                  '\$ ${NumberFormatUtil().integerFormat(viewModel.reserveViewData?.vol ?? 0)}'),
              _buildItem(tr('PRICE'),
                  '${NumberFormatUtil().integerFormat(viewModel.reserveViewData?.price ?? 0)} \$')
            ],
          )),
          SizedBox(width: UIDefine.getPixelWidth(10)),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItem(tr('annualROI'),
                  '${NumberFormatUtil().removeTwoPointFormat(viewModel.reserveViewData?.annualRoi ?? 0)} %'),
              _buildItem(tr('APR'),
                  '${NumberFormatUtil().removeTwoPointFormat(viewModel.reserveViewData?.apr ?? 0)} %')
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildItem(String title, String context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTextStyle.getBaseStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textThreeBlack),
                ))),
        Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                child: Text(context,
                    style: AppTextStyle.getBaseStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: UIDefine.fontSize14)))),
      ],
    );
  }
}
