import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

/// 收藏 我的票券(活動時使用 ex.世足)
class EventInfoCard extends StatefulWidget {
  const EventInfoCard({super.key,
  required this.itemStatus,
  required this.prizeStatus,
  required this.itemName,
  required this.imageUrl,
  required this.price,
  required this.prizeAmount,
  required this.prizeLevel,
  required this.lotteryNo,
  required this.createdAt,
  required this.dataList
  });

  final String itemStatus;
  final String prizeStatus;
  final String itemName;
  final String imageUrl;
  final String price;
  final String prizeAmount;
  final num prizeLevel;
  final String lotteryNo;
  final String createdAt;
  final List<CardShowingData> dataList; // 訂單編號, 預約金, 券值

  @override
  State<StatefulWidget> createState() => _EventInfoCard();
}

class _EventInfoCard extends State<EventInfoCard> {
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
                /// 抽獎號碼Title
                Row(
                  children: [
                    Image.asset('assets/icon/icon/icon_ticket.png'),
                    const SizedBox(width: 6),
                    Text(
                      tr('lotteryNumber'),
                      style: CustomTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                /// 中籤icon 1
                Container(
                    decoration: BoxDecoration(
                      color: _getLuckyStrawBkgrnColor(),
                      border: Border.all(color: _getLuckyStrawBorderColor(), width: 2),
                    ),
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Row(
                      children: [
                        Image.asset(_getItemIconColor()),
                        const SizedBox(width: 4),
                        Text(
                          _getLuckyStrawString(),
                          style: CustomTextStyle.getBaseStyle(color: _getLuckyStrawStringColor(), fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                )
              ],
            ),

            SizedBox(height: UIDefine.getScreenWidth(2.77)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 這張的獎號
                Text(
                  widget.lotteryNo,
                  style: CustomTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                ),
                /// 中籤icon 2
                Container(
                    decoration: BoxDecoration(
                      color: _getPrizeBkgrnColor(),
                      border: Border.all(color: _getPrizeBorderColor(), width: 2),
                    ),
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Row(
                      children: [
                        Image.asset(_getPrizeIconColor()),
                        const SizedBox(width: 4),
                        Text(
                          _getPrizeLuckyStrawString(),
                          style: CustomTextStyle.getBaseStyle(color: _getPrizeLuckyStrawStringColor(), fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                )
              ],
            ),

            /// 時間
            Text(
              widget.createdAt,
              style: CustomTextStyle.getBaseStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
            ),

            /// 活動獎池Title
            SizedBox(height: UIDefine.getScreenWidth(2.7)),
            Text(
              tr('activity-title-text'),
              style: CustomTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: UIDefine.getScreenWidth(2.7)),

            /// 商品中籤時的圖+文
            Visibility(
              visible: widget.itemStatus == 'SUCCESS',
              child: _getImageView(true),
            ),
            /// 中獎金時的圖+文
            Visibility(
              visible: widget.prizeStatus == 'SUCCESS',
              child: _getImageView(false),
            ),

            /// 底部: 訂單編號,預約金,券值
            Column(
              children: _getTitleContent(),
            ),

          ],
        )
    );
  }

  String _getItemIconColor() {
    if (widget.itemStatus == 'PENDING') {
      return 'assets/icon/icon/icon_item_02.png';
    }
    return 'assets/icon/icon/icon_item_01.png';
  }

  String _getPrizeIconColor() {
    if (widget.prizeStatus == 'PENDING') {
      return 'assets/icon/icon/icon_bonus_02.png';
    }
    return 'assets/icon/icon/icon_bonus_01.png';
  }

  Color _getLuckyStrawBorderColor() {
    switch(widget.itemStatus) {
      case 'SUCCESS':
        return AppColors.growPrice;
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  Color _getPrizeBorderColor() {
    switch(widget.prizeLevel) {
      case 1:
        return AppColors.growPrice;
      case 2:
        return AppColors.prizeOrange;
      case 3:
        return AppColors.prizePurple;
    }

    switch(widget.prizeStatus) {
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  Color _getLuckyStrawBkgrnColor() {
    switch(widget.itemStatus) {
      case 'SUCCESS':
        return AppColors.growPrice;
      case 'PENDING':
        return AppColors.textWhite;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  Color _getPrizeBkgrnColor() {
    switch(widget.prizeLevel) {
      case 1:
        return AppColors.growPrice;
      case 2:
        return AppColors.prizeOrange;
      case 3:
        return AppColors.prizePurple;
    }

    switch(widget.prizeStatus) {
      case 'PENDING':
        return AppColors.textWhite;
      case 'FAIL':
        return AppColors.textRed;
    }
    return AppColors.transParent;
  }

  String _getLuckyStrawString() {
    switch(widget.itemStatus) {
      case 'SUCCESS':
        return tr("notification-SUCCESS'");
      case 'PENDING':
        return tr("notification-PENDING'");
      case 'FAIL':
        return tr("notification-FAIL'");
    }
    return '';
  }

  String _getPrizeLuckyStrawString() {
    switch(widget.prizeLevel) {
      case 1:
        return tr('bonus-win-1');
      case 2:
        return tr('bonus-win-2');
      case 3:
        return tr('bonus-win-3');
    }

    switch(widget.prizeStatus) {
      case 'PENDING':
        return tr("notification-PENDING'");
      case 'FAIL':
        return tr("notification-FAIL'");
    }
    return '';
  }

  Color _getLuckyStrawStringColor() {
    switch(widget.itemStatus) {
      case 'SUCCESS':
        return AppColors.textWhite;
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textWhite;
    }
    return AppColors.transParent;
  }

  Color _getPrizeLuckyStrawStringColor() {
    switch(widget.prizeLevel) {
      case 1:
      case 2:
      case 3:
        return AppColors.textWhite;
    }

    switch(widget.prizeStatus) {
      case 'PENDING':
        return AppColors.textRed;
      case 'FAIL':
        return AppColors.textWhite;
    }
    return AppColors.transParent;
  }

  List<Widget> _getTitleContent() {
    List<Widget> titleContent = [];
    for (int i = 0; i < widget.dataList.length; i++) {
      titleContent.add(
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              child: Row(
                mainAxisAlignment: i == 0 ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(widget.dataList[i].title), // 在外部要塞多語系的key
                    style: CustomTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                  ),

                  Row(
                    children: [
                      Visibility(
                          visible: _checkTitleShowCoins(widget.dataList[i]),
                          child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tr(widget.dataList[i].content),
                        style: CustomTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
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

  Widget _getImageView(bool bIsItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bIsItem?
            GraduallyNetworkImage(
              imageUrl: widget.imageUrl,
              height: UIDefine.getScreenWidth(21.3),
              width: UIDefine.getScreenWidth(21.3),
              fit: BoxFit.cover,
            )
               :
            Image.asset('assets/icon/img/img_bonus.png',
                width: UIDefine.getScreenWidth(21.3), height: UIDefine.getScreenWidth(21.3)),

            SizedBox(width: UIDefine.getScreenWidth(2.77)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: UIDefine.getScreenWidth(50),
                    child: Text(
                      bIsItem? widget.itemName: tr('awardMoney'),
                      style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),
                    )
                ),

                SizedBox(height: UIDefine.getScreenWidth(2.5)),

                Row(
                  children: [
                    Text(
                      bIsItem? tr('theAmountGoods') : tr('itemValue'),
                      style: CustomTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                    ),

                    SizedBox(width: UIDefine.getScreenWidth(3)),

                    Row(
                      children: [
                        Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                        const SizedBox(width: 2.5),
                        Text(
                          widget.price,
                          style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),

        SizedBox(height: UIDefine.getScreenWidth(2.7)),
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