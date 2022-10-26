import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../../constant/call_back_function.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/sell/collection_sell_dialog_view.dart';
import '../../../views/collection/transfer/collection_transfer_dialog_view.dart';

/// 收藏 上架中/未上架 ItemView
class CollectionSellUnSellItemView extends StatefulWidget {
  const CollectionSellUnSellItemView({super.key,
  required this.collectionNftItemResponseData,
  required this.index,
  required this.type,
  required this.callBack
  });

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
          margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(5), 0),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.searchBar, width: 1))),
          child: Column(
            children: [
              /// 上半部分
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 狀態標題 + icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _getIcon(),
                      const SizedBox(width: 6),
                      Text(
                        _getStatusTitle(),
                        style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),

                  /// 計時器View
                  _getTimerView()
                ],
              ),

              SizedBox(height: UIDefine.getScreenWidth(4)),

              /// 中間部分 圖+文
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(data.imgUrl, width: UIDefine.getScreenWidth(20), height: UIDefine.getScreenWidth(20)),
                  SizedBox(width: UIDefine.getScreenWidth(2.7)),
                  IntrinsicWidth(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: UIDefine.getScreenWidth(67),
                              child: Text( // 商品名
                                data.name,
                                style: TextStyle(color: AppColors.dialogBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                              )
                          ),

                          SizedBox(height: UIDefine.getScreenWidth(2.7)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                                  const SizedBox(width: 4),
                                  Text( // 商品價格
                                    data.price.toString(),
                                    style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Image.asset('assets/icon/icon/icon_trend_up_01.png'),
                                  const SizedBox(width: 4),
                                  Text( // 商品漲幅價格
                                    data.growAmount.toString(),
                                    style: TextStyle(color: AppColors.growPrice, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 4),
                                  Text( // 計價單位
                                    'USD',
                                    style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                  )
                ],
              ),

              SizedBox(height: UIDefine.getScreenWidth(2.2)),

              /// 下半部 按鈕
              _getBottomBtn(),

              SizedBox(height: UIDefine.getScreenWidth(2.2))

            ],
          ),
        ),

        /// 半透明遮罩
        // Positioned(
        //   left: 0, top: 0, right: 0, bottom: 0,
        //   child: _getGrayCover()
        // )
      ],
    );
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
              style: TextStyle(color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w700),
            )
          ],
        );
      }
    }
    return const SizedBox();
  }

  Widget _getIcon() {
    String imgPath = '';
    switch(data.status) {
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
    switch(data.status) {
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
      if (data.status == 'PAYING') {
        return Container(
          width: UIDefine.getScreenWidth(88),
          decoration: BoxDecoration(
              color: AppColors.mainThemeButton,
              borderRadius: BorderRadius.circular(6)
          ),
          child: TextButton(
              onPressed: () {  },
              child: Text(
                tr('donePay'), // 完成付款
                style: TextStyle(
                    color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
              )
          ),
        );

      } else if (data.status == 'PENDING') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: UIDefine.getScreenWidth(44),
              height: UIDefine.getScreenWidth(11),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainThemeButton, width: 2),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                  onPressed: () {
                    _pressTransfer();
                  },
                  child: Text(
                    tr('transfer'), // 轉讓
                    style: TextStyle(
                        color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                  )
              ),
            ),

            Container(
              width: UIDefine.getScreenWidth(44),
              height: UIDefine.getScreenWidth(11),
              decoration: BoxDecoration(
                  color: AppColors.mainThemeButton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                  onPressed: () {
                    _pressSell();
                  },
                  child: Text(
                    tr('sell'), // 販售
                    style: TextStyle(
                        color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                  )
              ),
            )
          ],
        );
      }
    }
    return const SizedBox();
  }

  Widget _getGrayCover() {
    if (itemType == 'Selling') {
      return Container(color: AppColors.transParentHalf);

    } else {
      if (data.status == 'AUDITING') {
        return Container(color: AppColors.transParentHalf);
      }
    }

    return const SizedBox();
  }

  void _pressTransfer() {
    CollectionTransferDialogView(
        context,
        data.imgUrl,
        data.name,
        data.itemId).show();
  }

  void _pressSell() {
    CollectionSellDialogView(
        context,
        data.imgUrl,
        data.name,
        data.itemId,
        data.growPrice,
        () => _onViewChange()
    ).show();
  }

  void _onViewChange() {
    widget.callBack(widget.index);
  }

}