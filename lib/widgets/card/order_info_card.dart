import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../views/airdrop/airdrop_main_page.dart';
import '../dialog/simple_custom_dialog.dart';
import 'data/card_showing_data.dart';

/// 無圖片的訂單信息_副本預約 (外部先將部分Data存成 List<CardShowingData>)
class OrderInfoCard extends StatefulWidget {
  const OrderInfoCard(
      {super.key,
        this.status = '',
        this.isPaying = false,
        required this.imageUrl,
        required this.itemName,
        this.price = '',
        required this.orderNumber,
        required this.dateTime,
        required this.dataList,
        required this.drewAt});

  final String status;
  final String itemName;
  final String imageUrl;
  final String price;
  final String orderNumber;
  final String dateTime;
  final bool isPaying; // 如果True，代表交易中但餘額不足
  final List<CardShowingData> dataList;
  final DateTime? drewAt;

  ///開獎時間

  @override
  State<StatefulWidget> createState() => _OrderInfoCard();
}

class _OrderInfoCard extends State<OrderInfoCard> {
  CollectionMainViewModel viewModel = CollectionMainViewModel();
  bool bNotEnoughMoney = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPaying) {
      bNotEnoughMoney = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(UIDefine.getPixelWidth(4.4)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.bolderGrey, width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///開獎日期
            ...(widget.drewAt != null)
                ? [
              GradientThirdText(
                '${tr('drawDate')}:${DateFormatUtil().getFullWithDateFormat(widget.drewAt!)}',
                size: UIDefine.fontSize12,weight: FontWeight.w500,
              )
            ]
                : [],

            /// 上半部
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 訂單編號+日期
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(width: UIDefine.getScreenWidth(79.5),
                        child:Row(children: [
                          Text(
                            '${tr('orderNo')}:',
                            style: AppTextStyle.getBaseStyle(
                                color: AppColors.textBlack,
                                fontSize: UIDefine.fontSize20,
                                fontWeight: FontWeight.w500),
                          ),
                          // Flexible(child:Container()),

                          Expanded(child: Container()),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            /// 中籤icon
                            Visibility(
                                visible: widget.status != '',
                                child: Container(
                                    height: UIDefine.getPixelHeight(32),
                                    decoration: BoxDecoration(
                                      color: _getLuckyStrawColor(),
                                      border: Border.all(
                                          color: _getLuckyStrawBorderColor(), width: 2),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                    child: Text(
                                      _getLuckyStrawString(),
                                      style: AppTextStyle.getBaseStyle(
                                          color: _getLuckyStrawStringColor(),
                                          fontSize: UIDefine.fontSize12,
                                          fontWeight: FontWeight.w500),
                                    ))),
                            SizedBox(width: UIDefine.getPixelHeight(5)),

                            /// 未中籤寶箱icon
                              Visibility(
                                visible: false,
                                  // visible: widget.status == 'FAIL',
                                  child:  GestureDetector(
                                      onTap: () => viewModel.pushPage(
                                          context, const AirdropMainPage()),
                                      child: Container(
                                        height: UIDefine.getPixelHeight(32),
                                        decoration: BoxDecoration(
                                          color: AppColors.textWhite,
                                          border: Border.all(
                                              color: AppColors.growPrice, width: 2),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(1.5, 1, 1.5, 1),
                                        child: Row(children: [
                                          Image.asset(AppImagePath.giftIcon),
                                          Image.asset(AppImagePath.arrowRightIcon),
                                        ]),
                                      )))
                            ])

                        ])),

                    const SizedBox(height: 4),
                    Text(
                      widget.orderNumber,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontSize: UIDefine.fontSize20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.dateTime,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.searchBar,
                          fontSize: UIDefine.fontSize12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),

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
        ));
  }

  Color _getLuckyStrawBorderColor() {
    switch (widget.status) {
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
    switch (widget.status) {
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
    switch (widget.status) {
      case 'SUCCESS':
        return tr("notification-SUCCESS'");
      case 'PENDING':
        return tr("notification-PENDING'");
      case 'FAIL':
        return tr("notification-NOTWON'");
      case 'THROW':
        return tr("notification-THROW'");
    }
    return '';
  }

  Color _getLuckyStrawStringColor() {
    switch (widget.status) {
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
    for (int i = 0; i < widget.dataList.length - 1; i++) { // 隱藏預約金
      titleContent.add(Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(widget.dataList[i].title), // 在外部要塞多語系的key
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.dialogGrey,
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Visibility(
                      visible: _checkTitleShowCoins(widget.dataList[i]),
                      child: Image.asset('assets/icon/coins/icon_tether_01.png',
                          width: UIDefine.getScreenWidth(3.7),
                          height: UIDefine.getScreenWidth(3.7))),
                  const SizedBox(width: 4),
                  Text(
                    widget.dataList[i].bPrice
                        ? BaseViewModel()
                        .numberFormat(widget.dataList[i].content)
                        : widget.dataList[i].content,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textBlack,
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          )));
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
            GraduallyNetworkImage(
                imageUrl: widget.imageUrl,
                width: UIDefine.getScreenWidth(21.3),
                height: UIDefine.getScreenWidth(21.3),
                fit: BoxFit.cover),
            SizedBox(width: UIDefine.getScreenWidth(2.77)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: UIDefine.getScreenWidth(50),
                    child: Text(
                      widget.itemName,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontSize: UIDefine.fontSize18,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(height: UIDefine.getScreenWidth(2.5)),
                Row(
                  children: [
                    Text(
                      tr("theAmountGoods"),
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.dialogGrey,
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: UIDefine.getScreenWidth(3)),
                    Row(
                      children: [
                        Image.asset('assets/icon/coins/icon_tether_01.png',
                            width: UIDefine.getScreenWidth(3.7),
                            height: UIDefine.getScreenWidth(3.7)),
                        const SizedBox(width: 2.5),
                        Text(
                          BaseViewModel().numberFormat(widget.price),
                          style: AppTextStyle.getBaseStyle(
                              color: AppColors.textBlack,
                              fontSize: UIDefine.fontSize14,
                              fontWeight: FontWeight.w500),
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
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.dialogGrey,
                  fontSize: UIDefine.fontSize14,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(height: 8),
        Visibility(
            visible: bNotEnoughMoney,
            child: ActionButtonWidget(
                btnText: tr('balanceMadeUp'),
                setHeight: UIDefine.getScreenWidth(12),
                onPressed: () {
                  _onMakeUpBalance();
                }))
      ],
    );
  }

  bool _checkTitleShowCoins(CardShowingData data) {
    if (data.bIcon) {
      return true;
    }
    return false;
  }

  /// 按下補足餘額
  void _onMakeUpBalance() {
    viewModel
        .requestMakeUpBalance(
        recordNo: widget.orderNumber,
        onConnectFail: (errMessage) {
          viewModel.onBaseConnectFail(context, errMessage);
        })
        .then((value) {
      if (value == 'SUCCESS') {
        SimpleCustomDialog(context, isSuccess: true).show();
        setState(() {
          bNotEnoughMoney = false;
        });

        // 更新bottomNavigationBar的狀態
        GlobalData.bottomNavigationNotifier.minus();
      }
    });
  }
}
