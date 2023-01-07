import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

/// 有圖片的商品信息_單一預約 (外部先將部分Data存成 List<CardShowingData>)
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 標題
                  Text(
                    itemName,
                    style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  /// 副標題
                  Text(
                    dateTime,
                    style: CustomTextStyle.getBaseStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10)
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
                    style: CustomTextStyle.getBaseStyle(color: _getLuckyStrawStringColor(), fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
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
                  imageUrl!=''?
                  GraduallyNetworkImage(
                    imageUrl: imageUrl,
                    width: UIDefine.getScreenWidth(22),
                    height: UIDefine.getScreenWidth(22),
                    fit: BoxFit.cover,
                  )
                      :
                  const SizedBox(),

                  SizedBox(height: UIDefine.getScreenWidth(2.5)),

                  /// 商品價格
                  Visibility(
                    visible: bShowPriceAtEnd,
                    child: Row(
                      children: [
                        Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                        const SizedBox(width: 6),
                        Text(
                          BaseViewModel().numberFormat(price),
                          style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  )
                ],
              ),

              SizedBox(width: UIDefine.getScreenWidth(3)),

              /// 右半邊文字內容
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
        return tr("notification-SUCCESS'");
      case 'PENDING':
        return tr("notification-PENDING'");
      case 'FAIL':
        return tr("notification-FAIL'");
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(dataList[i].title), // 在外部要塞多語系的key
                style: CustomTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Visibility(
                      visible: _checkTitleShowCoins(dataList[i]),
                      child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tr(dataList[i].content),
                    style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
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
    if (data.bIcon) {
      return true;
    }
    return false;
  }

}