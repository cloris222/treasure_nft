
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

/// 有圖片的商品信息_單一預約 (外部先將部分Data存成 List<ItemInfoCardShowingData>)
class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard({super.key,
  this.bShowPriceAtEnd = false, this.status = '',
  required this.itemName, required this.dateTime,
  required this.imageUrl, required this.price, required this.dataList
  });

  final bool bShowPriceAtEnd;
  final String status;
  final String itemName;
  final String dateTime;
  final String imageUrl;
  final String price;
  final List<CardShowingData> dataList;

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
        children: [
          /// 上半部
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  /// 標題
                  Text(
                    itemName,
                    style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                  ),
                  /// 副標題
                  Text(
                    dateTime,
                    style: TextStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              /// 中籤
              Visibility(
                visible: status != '' ,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: _getLuckyStrawBorderColor(), width: 2),
                    color: _getLuckyStrawColor()
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

          /// 下半部
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 左半邊圖片價格
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 商品圖
                  Image.network(imageUrl),
                  /// 商品價格
                  Visibility(
                    visible: bShowPriceAtEnd,
                    child: Row(
                      children: [
                        Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                        const SizedBox(width: 6),
                        Text(
                          price,
                          style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  )
                ],
              ),

              SizedBox(height: UIDefine.getScreenWidth(2.7)),

              /// 右半邊文字內容
              Column(
                children: _getTitleContent(),
              )
            ],
          )
        ],
      ),
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
        return tr('success');
      case 'PENDING':
        return tr('pending');
      case 'FAIL':
        return tr('fail');
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
                tr(dataList[i].title),
                style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Visibility(
                      visible: _checkTitleShowCoins(dataList[i]), // test 這要確認欄位是什麼 是否每隻API都是同名稱
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

  bool _checkTitleShowCoins(CardShowingData data) {
    if (data.title.contains('price')) {
      return true;
    }
    if (data.title.contains('Amount')) {
      return true;
    }
    return false;
  }

}