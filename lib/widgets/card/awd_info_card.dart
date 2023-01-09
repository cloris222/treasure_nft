import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import 'data/card_showing_data.dart';

/// A:活動獎勵 W:提領 D:充值 (外部先將部分Data存成 List<CardShowingData>)
class AWDInfoCard extends StatelessWidget {
  AWDInfoCard({super.key,
  this.status = '', 
  required this.type,
  required this.datetime,
  required this.dataList
  });

  String status;
  String type; // ACTIVITY_AWARD:活動獎勵, LEVEL_UP_ADD:升等獎勵(儲金罐), AD_PRIZE:活動副本(獎金)
  String datetime;
  List<CardShowingData> dataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(4.4)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bolderGrey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 上半部
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// icon + 標題
                  Row(
                    children: [
                      _getImage(),
                      const SizedBox(width: 4),
                      Text(
                        _getTitle(),
                        style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  /// 日期
                  const SizedBox(height: 4),
                  Text(
                    datetime,
                    style: AppTextStyle.getBaseStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              /// Status icon
              Visibility(
                visible: status != '' ,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: _getLuckyStrawBorderColor(), width: 2),
                      color: _getLuckyStrawColor()),
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Text(
                    _getLuckyStrawString(),
                    style: AppTextStyle.getBaseStyle(color: _getLuckyStrawStringColor(), fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                  )
                )
              )
            ],
          ),
          /// 活動名稱(only for Activity)
          _getActivityName(),
          
          SizedBox(height: UIDefine.getScreenWidth(2.7)),

          /// 下半部
          Column(
            children: _getTitleContent(),
          )
        ],
      )
    );
  }

  Widget _getActivityName() {
    if (type.contains('ACTIVITY') || type.contains('PRIZE')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            tr('world-cups-event'), // 活動名 (後端沒給欄位 目前寫死)
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
          )
        ],
      );
    }
    return const SizedBox();
  }

  Color _getLuckyStrawBorderColor() {
    switch(status) {
      case 'SUCCESS':
        return AppColors.growPrice;
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  Color _getLuckyStrawColor() {
    switch(status) {
      case 'SUCCESS':
        return AppColors.growPrice;
      case 'PENDING':
        return AppColors.textWhite;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  String _getLuckyStrawString() {
    switch(status) {
      case 'SUCCESS':
        return tr("success");
      case 'PENDING':
        return tr("recharge-PENDING'");
      case 'FAIL':
        return tr("recharge-FAIL'");
    }
    return '';
  }

  Color _getLuckyStrawStringColor() {
    switch(status) {
      case 'SUCCESS':
        return AppColors.textWhite;
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textWhite;
    }
    return AppColors.transParent;
  }

  String _getTitle() {
    if (type.contains('ACTIVITY')) {
      return tr('activitiesUSDT');

    } else if (type == 'LEVEL_UP_ADD') {
      return tr('bonus_referral');

    } else if (type == 'LEVEL_UP_ADD_TRADE') {
      return tr('bonus_trade');

    } else if (type.contains('PRIZE')) {
      return tr('activitiesUSDT');

    } else if (type.contains('DEPOSIT')) {
      return tr('recharge');

    } else if (type.contains('WITHDRAW')) {
      return tr('withdraw');
    }
    return '';
  }
  
  _getImage() {
    if (type.contains('ACTIVITY') || type.contains('LEVEL') || type.contains('PRIZE')) {
      return Image.asset('assets/icon/icon/icon_file_03.png');

    } else if (type.contains('DEPOSIT')) {
      return Image.asset('assets/icon/icon/icon_card_02.png');

    } else if (type.contains('WITHDRAW')) {
      return Image.asset('assets/icon/icon/icon_extraction_01.png');
    }
  }

  List<Widget> _getTitleContent() {
    List<Widget> titleContent = [];
    for (int i = 0; i < dataList.length; i++) {
      titleContent.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(dataList[i].title), // 在外部要塞多語系的key
                style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Visibility(
                      visible: dataList[i].title.contains('預開欄位'), // test 不確定AWD是否會有icon的需要 目前沒
                      child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                  ),
                  const SizedBox(width: 4),
                  Text(
                    dataList[i].bPrice ?
                    BaseViewModel().numberFormat(dataList[i].content)
                        :
                    tr(dataList[i].content),
                    style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          )
        )
      );
    }
    return titleContent;
  }

}
