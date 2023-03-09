import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/bonus_trade_record_data.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/level_api.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/date_format_util.dart';
import '../../../utils/number_format_util.dart';
import '../../label/coin/tether_coin_widget.dart';
import '../../label/gradually_network_image.dart';

class LevelTradeBonusRecordListView extends StatefulWidget {
  const LevelTradeBonusRecordListView(
      {Key? key, required this.startTime, required this.endTime})
      : super(key: key);
  final String startTime;
  final String endTime;

  @override
  State<LevelTradeBonusRecordListView> createState() =>
      _LevelTradeBonusRecordListViewState();
}

class _LevelTradeBonusRecordListViewState
    extends State<LevelTradeBonusRecordListView> with BaseListInterface {
  @override
  void didUpdateWidget(covariant LevelTradeBonusRecordListView oldWidget) {
    ///MARK: 代表數值有更動
    if (oldWidget.endTime.compareTo(widget.endTime) != 0 ||
        oldWidget.startTime.compareTo(widget.startTime) != 0) {
      initListView();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.endTime.isEmpty && widget.startTime.isEmpty) {
      init();
    } else {
      initListView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(
            top: UIDefine.getScreenWidth(5),
            bottom: UIDefine.navigationBarPadding));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    BonusTradeRecordData record = data;

    return Container(
        decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Flexible(
                child: Text(record.itemName,
                    style: AppTextStyle.getBaseStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: UIDefine.fontSize16)),
              ),
            ],
          ),
          SizedBox(height: UIDefine.getPixelWidth(5)),
          Text(DateFormatUtil().getFullWithDateFormat(record.createdAt),
              style: AppTextStyle.getBaseStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize14,
                  color: AppColors.textSixBlack)),
          SizedBox(height: UIDefine.getPixelWidth(10)),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: GraduallyNetworkImage(
                  imageUrl: record.imgUrl,
                  width: UIDefine.getPixelWidth(80),
                  height: UIDefine.getPixelWidth(80),
                )),
            SizedBox(width: UIDefine.getPixelWidth(10)),
            Expanded(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(tr('orderNo'),
                          style: AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize14,
                              color: AppColors.textSixBlack)),
                    ),
                    Text(record.orderNo,
                        textAlign: TextAlign.end,
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w400))
                  ]),
              SizedBox(height: UIDefine.getPixelWidth(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(tr('bonus'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            color: AppColors.textSixBlack)),
                  ),
                  Text(
                      textAlign: TextAlign.end,
                      '${record.tradeSavingsRate} %',
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w400))
                ],
              ),
              SizedBox(height: UIDefine.getPixelWidth(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(tr('income'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            color: AppColors.textSixBlack)),
                  ),
                  Text(
                      NumberFormatUtil()
                          .removeCustomPointFormat(record.income, 2),
                      textAlign: TextAlign.end,
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w400))
                ],
              ),
              SizedBox(height: UIDefine.getPixelWidth(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
                  SizedBox(width: UIDefine.getPixelWidth(5)),
                  Flexible(
                    child: Text(
                        NumberFormatUtil()
                            .removeCustomPointFormat(record.price, 2),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600)),
                  )
                ],
              )
            ]))
          ])
        ]));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return BonusTradeRecordData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await LevelAPI().getBonusTradeRecord(
        page: page,
        size: size,
        startTime: widget.startTime,
        endTime: widget.endTime);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return page == 1 && widget.startTime.isEmpty && widget.endTime.isEmpty;
  }

  @override
  String setKey() {
    return 'levelTradeBonusRecord';
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
