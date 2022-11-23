import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

/// 無圖片的訂單信息_副本預約 (外部先將部分Data存成 List<CardShowingData>)
class OrderInfoCard extends StatefulWidget {
  const OrderInfoCard({super.key,
  this.status = '', this.walletBalance = 0, this.onEnoughMoney,
  required this.imageUrl, required this.itemName, this.price = '',
  required this.orderNumber,required this.dateTime, required this.dataList
  });

  final String status;
  final num walletBalance;
  final String itemName;
  final String imageUrl;
  final String price;
  final String orderNumber;
  final String dateTime;
  final List<CardShowingData> dataList;
  final onClickFunction? onEnoughMoney;

  @override
  State<StatefulWidget> createState() => _OrderInfoCard();
}

class _OrderInfoCard extends State<OrderInfoCard> {

  bool bNotEnoughMoney = false;

  @override
  void initState() {
    super.initState();
    if (widget.status == 'SUCCESS') {
      if (widget.walletBalance < double.parse(widget.price)) {
        bNotEnoughMoney = true;
      }
    }
  }

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
                      widget.orderNumber,
                      style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.dateTime,
                      style: TextStyle(color: AppColors.searchBar, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),

                /// 中籤icon
                Visibility(
                    visible: widget.status != '' ,
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
              visible: widget.status == 'SUCCESS',
              child: _getImageView(),
            )

          ],
        )
    );
  }

  Color _getLuckyStrawBorderColor() {
    switch(widget.status) {
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
    switch(widget.status) {
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
    switch(widget.status) {
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
    switch(widget.status) {
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
    for (int i = 0; i < widget.dataList.length; i++) {
      titleContent.add(
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(widget.dataList[i].title), // 在外部要塞多語系的key
                    style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Visibility(
                          visible: _checkTitleShowCoins(widget.dataList[i]),
                          child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.dataList[i].bPrice ?
                        BaseViewModel().numberFormat(widget.dataList[i].content)
                            :
                        widget.dataList[i].content,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.imageUrl, width: UIDefine.getScreenWidth(21.3), height: UIDefine.getScreenWidth(21.3)),
            SizedBox(width: UIDefine.getScreenWidth(2.77)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: UIDefine.getScreenWidth(50),
                    child: Text(
                      widget.itemName,
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
                          BaseViewModel().numberFormat(widget.price),
                          style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),

        const SizedBox(height: 8),
        Visibility(
            visible: bNotEnoughMoney,
            child: Text(
              tr('insufficientBalance'),
              style: TextStyle(color: AppColors.dialogGrey,
                  fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            )
        ),

        const SizedBox(height: 8),
        Visibility(
            visible: bNotEnoughMoney,
            child: ActionButtonWidget(
                btnText: tr('balanceMadeUp'),
                setHeight: UIDefine.getScreenWidth(12),
                onPressed: () {
                  setState(() { bNotEnoughMoney = false; });
                  widget.onEnoughMoney!();
                })
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
