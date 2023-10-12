import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/call_back_function.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/sell/collection_sell_dialog_view.dart';
import '../../../views/collection/transfer/collection_transfer_dialog_view.dart';
import '../../gradient_text.dart';

/// 收藏 上架中/未上架 ItemView
class CollectionSellUnSellItemView extends StatefulWidget {
  const CollectionSellUnSellItemView(
      {super.key,
      required this.collectionNftItemResponseData,
      required this.index,
      required this.type,
      required this.callBack});

  final CollectionNftItemResponseData collectionNftItemResponseData;
  final int index;
  final String type;
  final onGetIntFunction callBack;

  @override
  State<StatefulWidget> createState() => _SellUnSellItemInfoCard();
}

class _SellUnSellItemInfoCard extends State<CollectionSellUnSellItemView> {
  CollectionNftItemResponseData get data {
    return widget.collectionNftItemResponseData;
  }

  String get itemType {
    return widget.type;
  }

  String timeLeft = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: UIDefine.getScreenWidth(44),
          padding: EdgeInsets.all(UIDefine.getScreenWidth(2.5)),
          decoration: const BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // /// 上半部分
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     /// 狀態標題 + icon
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         _getIcon(),
              //         const SizedBox(width: 6),
              //         Text(
              //           _getStatusTitle(),
              //           style: AppTextStyle.getBaseStyle(
              //               color: AppColors.dialogGrey,
              //               fontSize: UIDefine.fontSize16,
              //               fontWeight: FontWeight.w500),
              //         )
              //       ],
              //     ),
              //
              //     /// 計時器View
              //     _getTimerView() // test Jeff表示交易中將會移到今日預約(還沒定版), 這裡暫時留著不影響
              //   ],
              // ),
              //
              // SizedBox(height: UIDefine.getScreenWidth(4)),
              //
              // /// 交易週期(only for 交易中)
              // _getTradeTimeView(), // test 換版後交易週期改放哪裡？

              /// 商品圖
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GraduallyNetworkImage(
                  imageUrl: data.imgUrl,
                  fit: BoxFit.cover,
                  width: UIDefine.getScreenWidth(40),
                  height: UIDefine.getScreenWidth(36),
                ),
              ),

              SizedBox(height: UIDefine.getScreenWidth(2)),

              /// 商品名
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: UIDefine.getScreenWidth(37.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // 商品名
                                _getItemName(data.name),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.getBaseStyle(
                                    color: AppColors.dialogBlack,
                                    fontSize: UIDefine.fontSize16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                      'assets/icon/icon/icon_quantity_01.png',
                                      width: UIDefine.getScreenWidth(4.2),
                                      height: UIDefine.getScreenWidth(4.2)),
                                  const SizedBox(width: 4),
                                  Text(
                                    // test 商品數量 始終都1? API沒給數量
                                    '1',
                                    style: AppTextStyle.getBaseStyle(
                                        color: AppColors.textGrey,
                                        fontSize: UIDefine.fontSize12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: UIDefine.getScreenWidth(2.5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                      'assets/icon/coins/icon_tether_01.png',
                                      width: UIDefine.getScreenWidth(3.7),
                                      height: UIDefine.getScreenWidth(3.7)),
                                  const SizedBox(width: 4),
                                  Text(
                                    // 商品價格
                                    BaseViewModel().numberFormat(data.price),
                                    style: AppTextStyle.getBaseStyle(
                                        color: AppColors.textGrey,
                                        fontSize: UIDefine.fontSize14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                      'assets/icon/icon/icon_trend_up_01.png'),
                                  const SizedBox(width: 4),
                                  Text(
                                    // 商品漲幅價格
                                    BaseViewModel()
                                        .numberFormat(data.growAmount),
                                    style: AppTextStyle.getBaseStyle(
                                        color: AppColors.growPrice,
                                        fontSize: UIDefine.fontSize12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: UIDefine.getScreenWidth(2.2)),

              /// 下半部 按鈕
              _getBottomBtn(),

              SizedBox(height: UIDefine.getScreenWidth(2.2))
            ],
          ),
        ),
      ],
    );
  }

  String _getItemName(String value) {
    return value.length > 10 ? '${value.substring(0, 10)}....' : value;
  }

  Widget _getTradeTimeView() {
    if (data.status == 'SELLING' && itemType == 'Selling') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${tr('nextTradeDate')}:${data.nextTradeDate}',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500)),
          SizedBox(height: UIDefine.getScreenWidth(2.4)),
          Text('${tr('tradingCycle')}:${data.tradePeriod}${tr('day')}',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500)),
          SizedBox(height: UIDefine.getScreenWidth(4))
        ],
      );
    }
    return const SizedBox();
  }

  Widget _getTimerView() {
    if (itemType == 'Pending') {
      if (data.status == 'PAYING') {
        return Row(
          children: [
            Image.asset('assets/icon/icon/icon_clock_04.png'),
            const SizedBox(width: 6),
            Text(
              timeLeft,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.mainThemeButton,
                  fontSize: UIDefine.fontSize12,
                  fontWeight: FontWeight.w700),
            )
          ],
        );
      }
    }
    return const SizedBox();
  }

  Widget _getIcon() {
    String imgPath = '';
    switch (data.status) {
      case 'SELLING':
      case 'DISABLE':
      case 'PAYING':
      case 'AUDITING':
        imgPath = 'assets/icon/icon/icon_clock_03.png';
        break;

      case 'PENDING':
        imgPath = 'assets/icon/icon/icon_sale_01.png';
        break;
    }
    return Image.asset(imgPath);
  }

  String _getStatusTitle() {
    String title = '';
    switch (data.status) {
      case 'SELLING':
        title = tr("status_SELLING");
        break;
      case 'DISABLE':
        title = tr('status_DISABLE');
        break;
      case 'PAYING':
        title = tr('status_PAYING');
        break;
      case 'AUDITING':
        title = tr("status_AUDITING");
        break;
      case 'PENDING':
        title = tr('status_PENDING');
        break;
    }
    return title;
  }

  Widget _getBottomBtn() {
    if (itemType == 'Pending') {
      if (data.status == '???????') {
        // test 要判斷是否為拆分的商品, 後端還沒完成該欄位
        return Container(
          height: UIDefine.getScreenWidth(11),
          width: UIDefine.getScreenWidth(38),
          decoration: BoxDecoration(
              color: AppColors.mainThemeButton,
              borderRadius: BorderRadius.circular(6)),
          child: TextButton(
              onPressed: () {},
              child: Text(
                tr('sell'), // 完成付款
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textWhite,
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w500),
              )),
        );
      } else if (data.status == 'PENDING') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Platform.isIOS
                ? SizedBox(height: UIDefine.getScreenWidth(11))
                : Expanded(
                    child: Container(
                      height: UIDefine.getScreenWidth(11),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: AppColors.gradientBaseColorBg),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.textWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              _pressTransfer();
                            },
                            child: GradientText(
                              tr('transfer'), // 轉出
                              weight: FontWeight.w500,
                              size: UIDefine.fontSize16,
                              starColor: AppColors.gradientBaseColorBg[0],
                              endColor: AppColors.gradientBaseColorBg[2],
                            )),
                      ),
                    ),
                  ),
            SizedBox(
              width: Platform.isIOS ? null : UIDefine.getPixelWidth(10),
            ),
            Expanded(
              child: Container(
                height: UIDefine.getScreenWidth(11),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: AppColors.gradientBaseColorBg),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {
                      _pressSell();
                    },
                    child: Text(
                      tr('sell'), // 賣出
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textWhite,
                          fontSize: UIDefine.fontSize16,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            )
          ],
        );
      }
    } else if(itemType == 'Selling' || data.status == 'SELLING') {
      return Container(
        width: UIDefine.getPixelWidth(144),
        height: UIDefine.getScreenWidth(11),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: AppColors.gradientBaseColorBg),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            onPressed: () {

            },
            child: Text(
              tr('matchMaking'), // 匹配中
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textWhite,
                  fontSize: UIDefine.fontSize12,
                  fontWeight: FontWeight.w400),
            )),
      );
    }
    return SizedBox(height: UIDefine.getScreenWidth(11));
  }

  void _pressTransfer() {
    CollectionTransferDialogView(context, data.imgUrl, data.name, data.itemId)
        .show();
  }

  void _pressSell() {
    CollectionSellDialogView(context, data.imgUrl, data.name, data.itemId,
        data.growPrice, () => _onViewChange()).show();
  }

  void _onViewChange() {
    widget.callBack(widget.index);
  }
}
