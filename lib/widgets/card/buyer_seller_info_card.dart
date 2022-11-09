import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import 'data/card_showing_data.dart';

class BuyerSellerInfoCard extends StatefulWidget {
  const BuyerSellerInfoCard({super.key,
  required this.imgUrl,
  required this.dataList,
  required this.moreInfoDataList});

  final List<CardShowingData> dataList;
  final List<CardShowingData> moreInfoDataList;
  final String imgUrl;

  @override
  State<StatefulWidget> createState() => _BuyerSellerInfoCard();

}

class _BuyerSellerInfoCard extends State<BuyerSellerInfoCard> {

  List<CardShowingData> get dataList {
    return widget.dataList;
  }

  List<CardShowingData> get moreInfoDataList {
    return widget.moreInfoDataList;
  }

  bool bShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: UIDefine.getScreenWidth(4), right: UIDefine.getScreenWidth(4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.imgUrl, width: UIDefine.getScreenWidth(14.5), height: UIDefine.getScreenWidth(14.5)),
                  SizedBox(height: UIDefine.getScreenWidth(2.77)),
                  Image.asset('assets/icon/icon/icon_share_02.png')
                ],
              ),

              SizedBox(width: UIDefine.getScreenWidth(2.77)),

              GestureDetector(
                  onTap: _clickMore,
                  child: IntrinsicWidth(
                      child: Column(
                        children: _getTitleContent(),
                      )
                  )
              )
            ],
          )
        ),

        SizedBox(height: UIDefine.getScreenWidth(2.8)),
        Container(width: double.infinity, height: 1, color: AppColors.searchBar),

        Visibility(
          visible: bShowMore,
          child: Padding(
            padding: EdgeInsets.only(left: UIDefine.getScreenWidth(8.25), right: UIDefine.getScreenWidth(8.25)),
            child: Column(
              children: [
                SizedBox(height: UIDefine.getScreenWidth(2.8)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getMoreInfoWidget(0)
                ),

                SizedBox(height: UIDefine.getScreenWidth(2.8)),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getMoreInfoWidget(3)
                )
              ],
            )
          )
        )
      ],
    );
  }

  List<Widget> _getTitleContent() {
    List<Widget> titleContent = [];
    for (int i = 0; i < dataList.length; i++) {
      titleContent.add(
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, UIDefine.getScreenWidth(2.77)),
              child: SizedBox(
                width: UIDefine.getScreenWidth(67),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          i == dataList.length - 1 ?
                          bShowMore? tr('seeLess') : tr('seeMore')
                              :
                          tr(dataList[i].title), // 在外部要塞多語系的key
                          style: TextStyle(color: _setTextColor(dataList[i]),
                              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        ),

                        i == dataList.length - 1 ?
                        bShowMore?
                        Image.asset('assets/icon/btn/btn_arrow_02_up.png')
                            :
                        Image.asset('assets/icon/btn/btn_arrow_02_down.png')
                            : const SizedBox(),
                      ],
                    ),

                    Row(
                      children: [
                        Visibility(
                            visible: _checkTitleShowCoins(dataList[i]),
                            child: Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7))
                        ),
                        const SizedBox(width: 4),
                        Container(
                          constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(35)),
                          child: Text(
                            tr(dataList[i].content),
                            softWrap: true,
                            style: TextStyle(color: _setTextColor(dataList[i]),
                                fontSize: i == dataList.length - 1 ? UIDefine.fontSize12 : UIDefine.fontSize14,
                                fontWeight: FontWeight.w500),
                          )
                        )
                      ],
                    )
                  ],
                )
              )
          )
      );
    }
    return titleContent;
  }

  List<Widget> _getMoreInfoWidget(int startIndex) {
    List<Widget> titleContent = [];
    for (int i = startIndex; i < moreInfoDataList.length; i++) {
      titleContent.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tr(moreInfoDataList[i].title),
              style: TextStyle(color: AppColors.textGrey,
                  fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 6),

            Row(
              children: [
                moreInfoDataList[i].bIcon? Image.asset(
                    'assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.73), height: UIDefine.getScreenWidth(3.73))
                    : const SizedBox(),
                moreInfoDataList[i].bIcon? const SizedBox(width: 4): const SizedBox(),
                Text(
                  tr(moreInfoDataList[i].content),
                  style: TextStyle(color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                )
              ]
            )
          ]
        ));
    }
    return titleContent;
  }

  void _clickMore() {
    setState(() {
      bShowMore = !bShowMore;
    });
  }

  Color _setTextColor(CardShowingData data) {
    if (data.bIcon) {
      return AppColors.textBlack;
    }
    return AppColors.textGrey;
  }

  bool _checkTitleShowCoins(CardShowingData data) {
    if (data.bIcon) {
      return true;
    }
    return false;
  }

}