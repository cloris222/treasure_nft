import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

/// 無圖片的訂單信息_副本預約 (外部先將部分Data存成 List<CardShowingData>)
class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key,
  this.status = '', required this.imageUrl, required this.itemName, this.price = '',
  required this.orderNumber,required this.dateTime, required this.dataList
  });

  final String status;
  final String itemName;
  final String imageUrl;
  final String price;
  final String orderNumber;
  final String dateTime;
  final List<CardShowingData> dataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(4.4)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bolderGrey, width: 2.5),
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
              /// 訂單編號+日期
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('orderNo') + ':',
                    style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    orderNumber,
                    style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateTime,
                    style: TextStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              /// 中籤icon
              Visibility(
                visible: status != '' ,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getLuckyStrawColor(),
                    border: Border.all(color: _getLuckyStrawBorderColor(), width: 2),
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Text(
                    _getLuckyStrawString(),
                    style: TextStyle(color: _getLuckyStrawStringColor(), fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w600),
                  )
                )
              )
            ],
          ),

          SizedBox(height: UIDefine.getScreenWidth(2.7)),

          /// 下半部
          Column(
            children: _getTitleContent(),
          ),

          SizedBox(height: UIDefine.getScreenWidth(2.77)),

          /// 成功預約時的圖+文
          Visibility(
            visible: status == 'SUCCESS',
            child: _getImageView(),
          )

        ],
      )
    );
  }

  Color _getLuckyStrawBorderColor() {
    switch(status) {
      case 'SUCCESS':
        return AppColors.growPrice;
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textRed;
      case 'THROW':
        return AppColors.textGrey;
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
      case 'THROW':
        return AppColors.textGrey;
    }
    return AppColors.transParent;
  }

  String _getLuckyStrawString() {
    switch(status) {
      case 'SUCCESS':
        return tr("notification-SUCCESS'");
      case 'PENDING':
        return tr("notification-PENDING'");
      case 'FAIL':
        return tr("notification-FAIL'");
      case 'THROW':
        return tr("notification-THROW'");
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
      case 'THROW':
        return AppColors.dialogGrey;
    }
    return AppColors.transParent;
  }

  List<Widget> _getTitleContent() {
    List<Widget> titleContent = [];
    for (int i = 0; i < dataList.length; i++) {
      titleContent.add(
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(dataList[i].title), // 在外部要塞多語系的key
                style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Visibility(
                      visible: _checkTitleShowCoins(dataList[i]),
                      child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                  ),
                  const SizedBox(width: 4),
                  Text(
                    tr(dataList[i].content),
                    style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
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

  Widget _getImageView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imageUrl, width: UIDefine.getScreenWidth(21.3), height: UIDefine.getScreenWidth(21.3)),
        SizedBox(width: UIDefine.getScreenWidth(2.77)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: UIDefine.getScreenWidth(50),
              child: Text(
                itemName,
                style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),
              )
            ),

            SizedBox(height: UIDefine.getScreenWidth(2.5)),

            Row(
              children: [
                Text(
                  tr("theAmountGoods"),
                  style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                ),

                SizedBox(width: UIDefine.getScreenWidth(3)),

                Row(
                  children: [
                    Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                    const SizedBox(width: 2.5),
                    Text(
                      price,
                      style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }

  bool _checkTitleShowCoins(CardShowingData data) {
    if (data.bIcon) {
      return true;
    }
    return false;
  }

}
