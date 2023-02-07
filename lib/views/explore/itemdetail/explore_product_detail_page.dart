import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../../constant/ui_define.dart';
import '../../../utils/timer_util.dart';
import '../../../view_models/explore/explore_product_detail_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../../explore_chart_view.dart';
import '../../personal/level/level_achievement_page.dart';
import '../data/explore_item_response_data.dart';
import '../data/explore_level_info_response_data.dart';
import '../data/explore_reserve_insert_response_error_data.dart';

class ExploreItemDetailPage extends StatefulWidget {
  const ExploreItemDetailPage({super.key, required this.itemId});

  final String itemId;

  @override
  State<StatefulWidget> createState() => _ExploreItemDetailPage();
}

class ChartData {
  final int date;
  final double price;
  ChartData(this.date, this.price);
}

class _ExploreItemDetailPage extends State<ExploreItemDetailPage> {

  ExploreItemDetailViewModel viewModel = ExploreItemDetailViewModel();
  ExploreItemResponseData data = ExploreItemResponseData(priceHistory: [], sellTimeList: []);
  ExploreLevelInfoResponseData levelData = ExploreLevelInfoResponseData();
  List<SellTimeList> sellTimeList = [];
  List<PriceHistory> priceHistoryList = [];
  String sTimeLeft = '00:00:00:00';
  Widget chartView = const ExploreChartView(priceHistoryList: [], todayPrice: '',);
  late Timer timer;

  @override
  void initState() {
    super.initState();
    Future<ExploreItemResponseData> resList = viewModel.getExploreItemDetail(widget.itemId);
    resList.then((value) => _setData(value));

    Future<ExploreLevelInfoResponseData> data = viewModel.getCheckLevelInfoAPI();
    data.then((value) => {levelData = value, setState(() {})});

    // _timer();
  }

  @override
  void dispose() {
    CountDownTimerUtil().cancelTimer();
    super.dispose();
  }

  _setData(value) {
    data = value;
    sellTimeList = data.sellTimeList;
    priceHistoryList = data.priceHistory;
    chartView = ExploreChartView(priceHistoryList: priceHistoryList, todayPrice: data.price);
    setState(() {});
  }

  _timer(int secondLeft) {
    CountDownTimerUtil().init(callBackListener:
    MyCallBackListener(
        myCallBack: (sTimeLeft) {
      setState(() { this.sTimeLeft = sTimeLeft; });
    }),
        endTimeSeconds: secondLeft);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typeExplore,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 商品大圖 + back箭頭
            Stack(
              children: [
                data.imgUrl != ''?
                GraduallyNetworkImage(
                  imageUrl: data.imgUrl,
                  cacheWidth: 1440,
                  width: UIDefine.getScreenWidth(100),
                  height: UIDefine.getScreenWidth(100),
                )
                    :
                Container(),

                Positioned(
                  left: 5, top: 10,
                  child: Image.asset('assets/icon/btn/btn_arrow_03_left.png', scale: 0.7)
                )
              ],
            ),

            /// 提醒標語+倒數計時
            Visibility(
              visible: _checkCountry(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5),
                    UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('auctionIn'),
                      style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                      decoration: BoxDecoration(
                          color: AppColors.mainThemeButton,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/icon/icon/icon_clock_01.png'),
                          const SizedBox(width: 4),
                          Text(
                            sTimeLeft,
                            style: AppTextStyle.getBaseStyle(color: Colors.white, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),

            /// 商品名+詳細資訊
            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize26, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  _buildContractAddressView(tr('contractAddress'), _buildShortContractAddress('0xd7bF69a92DD126752FD8Aab5bC07439c56B2Abf5')),
                  _oneRowForm(tr('owner'), _setShowingForm(data.ownerName), false, false),
                  _oneRowForm(tr('price'), _setShowingForm(data.price), true, true),
                  _oneRowForm(tr('resaleIncome'), _setShowingForm(data.growAmount), true, true),
                  _oneRowForm(tr('network'), _setShowingForm('Polygon'), false, false), // test 這是啥 resp內沒有
                  _oneRowForm(tr('timeZone'), _getTimeZoneList(), false, false),
                ],
              ),
            ),

            /// 折線圖標題
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
              child: Text(
                tr('historicalVal'),
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w700),
              ),
            ),

            /// 折線圖圖表
            chartView,

            /// 底部間距
            SizedBox(height: UIDefine.getScreenWidth(10)),

            ///MARK: 按鈕(含)以下都拿掉 2022/11/04 Ethan
            // /// 預約按鈕+預約券總數量
            // Container(
            //   margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10),
            //       UIDefine.getScreenWidth(5), 0),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       color: AppColors.mainThemeButton,
            //       borderRadius: BorderRadius.circular(6)
            //   ),
            //   child: TextButton(
            //     onPressed: () {
            //       _pressReserve();
            //     },
            //       child: Text(
            //         tr('reserve'),
            //         style: CustomTextStyle.getBaseStyle(
            //             color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
            //       )
            //   ),
            // ),
            // const SizedBox(height: 6),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0,
            //       UIDefine.getScreenWidth(5), 0),
            //   child: Text(
            //     tr('reserveCount') + ': ' + levelData.dailyRCouponAmount.toString() + ' ' + tr('reserveCountPiece'),
            //     style: CustomTextStyle.getBaseStyle(
            //         color: AppColors.textRed, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            //   )
            // ),
            //
            // /// 等級+Range
            // Padding(
            //   padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10),
            //       UIDefine.getScreenWidth(5), 0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Image.asset(viewModel.getLevelImg(), width: UIDefine.getScreenWidth(10), height: UIDefine.getScreenWidth(10)),
            //       const SizedBox(width: 10),
            //       Text(
            //         tr('level') + ' ' + levelData.userLevel.toString(),
            //         style: CustomTextStyle.getBaseStyle(
            //             color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
            //       )
            //     ],
            //   )
            // ),
            //
            // Padding(
            //   padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(2),
            //       UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         tr('amountRangeNFT'),
            //         style: CustomTextStyle.getBaseStyle(
            //             color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            //       ),
            //       Row(
            //         children: [
            //           Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(5), height: UIDefine.getScreenWidth(5)),
            //           const SizedBox(width: 10),
            //           Text(
            //             levelData.buyRangeStart.toString() + ' ~ ' + levelData.buyRangeEnd.toString(),
            //             style: CustomTextStyle.getBaseStyle(
            //                 color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
            //           )
            //         ],
            //       )
            //     ],
            //   )
            // )
            SizedBox(height: UIDefine.navigationBarPadding)
          ],
        ),
      ),
    );
  }

  List<String> _getTimeZoneList() {
    List<String> list = [];
    for (int i = 0; i < sellTimeList.length; i++) {
      list.add('GMT ${sellTimeList[i].zone}  ${sellTimeList[i].localTime}');
    }
    return list;
  }

  String _buildShortContractAddress(String value) {
    return value.substring(0, 6) + '....' + value.substring(value.length - 4, value.length);
  }

  Widget _buildContractAddressView(String title, String content) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$title:',
              style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            ),

            Container(width: 4),

            GestureDetector(
              onTap: () {
                viewModel.launchInBrowser('https://polygonscan.com/address/0x01Dd0424E8cA954e93B1159E748099f2877720A0#readContract');
              },
              child: Text(
                content,
                style: AppTextStyle.getBaseStyle(color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              )
            )

          ],
        )
    );
  }

  List<String> _setShowingForm(String value) {
    List<String> list = [];
    list.add(value);
    return list;
  }

  Widget _oneRowForm(String title, List<String> contentList, bool bIcon, bool bContentColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title:',
            style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
          ),

          Container(width: 4),

          bIcon? Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)) : Container(),

          const SizedBox(width: 4),

          Column(
              children: _getFormContent(contentList, bContentColor)
          ),

        ],
      )
    );
  }

  List<Widget> _getFormContent(List<String> contentList, bool bContentColor) {
    List<Widget> textView = [];
    for (int i = 0; i < contentList.length; i++) {
      textView.add(Text(
        contentList[i],
        style: AppTextStyle.getBaseStyle(color: bContentColor? AppColors.textBlack : AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
      ));
    }
    return textView;
  }

  void _pressReserve() {
    Future<dynamic> result = viewModel.getNewReservationAPI('ITEM', widget.itemId, (errorMessage) { _getErrorResponse(errorMessage); });
    result.then((value) => _checkResponse(value));

  }

  void _checkResponse(dynamic value) {
    if (value == 'SUCCESS') { // 成功預約
      _showResultDialog(
        DialogImageType.success,
        tr('dly_t_DlyRsvScs'),
        tr("reserve-success-text'"),
        tr('confirm'),
        () => Navigator.pop(context)
      );

    } else { // 預約等級不符
      ExploreReserveInsertResponseErrorData errorData = ExploreReserveInsertResponseErrorData();
      errorData = value;
      _showResultDialog(DialogImageType.warning, tr('reserve-failed-level'),
          format(tr("reserve-APP_0041'"), {'level': errorData.level, 'needLevel': errorData.needLevel}),
          tr('goLevelUp'),
          (){ viewModel.pushPage(context, const LevelAchievementPage()); });
    }
  }

  void _getErrorResponse(String errorMessage) {
    switch(errorMessage) {
      case 'APP_0065': // 預約所屬國家錯誤
        _showResultDialog(
            DialogImageType.fail,
            tr("reserve-failed'"),
            tr("reserve-APP_0065"),
            tr('confirm'),
                () => Navigator.pop(context)
        );
        break;
      case 'APP_0063': // 預約時間錯誤
        _showResultDialog(
            DialogImageType.fail,
            tr("reserve-not-available'"),
            tr("reserve-TimeOut'"),
            tr('confirm'),
                () => Navigator.pop(context)
        );
        break;
      case 'APP_0064': // 預約金不足
        _showResultDialog(
            DialogImageType.fail,
            tr("reserve-failed'"), // 只顯示預約失敗標題
            '',
            tr('confirm'),
                () => Navigator.pop(context)
        );
        break;
      case 'APP_0013': // 餘額不足
        _showResultDialog(
            DialogImageType.fail,
            tr("APP_0013"),
            '',
            tr('confirm'),
                () => Navigator.pop(context)
        );
        break;
    }
  }

  void _showResultDialog(DialogImageType type, String title, String content, String rightBtnText, Function click) {
    CommonCustomDialog(
        context,
        type: type,
        title: title,
        content: content,
        rightBtnText: rightBtnText,
        onLeftPress: (){},
        onRightPress: click)
        .show();
  }

  bool _checkCountry() {
    for (int i = 0; i < sellTimeList.length; i++) {
      if (sellTimeList[i].country == GlobalData.userInfo.country) {
        DateTime dateTime;
        if (sellTimeList[i].sellDate.isEmpty) {
          dateTime = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()) +' '
              + sellTimeList[i].startTime);
        } else {
          dateTime = DateTime.parse(sellTimeList[i].sellDate +' '+ sellTimeList[i].startTime);
        }
        int secondLeft = dateTime.difference(DateTime.now()).inSeconds;
        if (secondLeft > 0) { // 大於0才是尚未開賣，如是開賣中,另外判是否已過結束時間,但現在沒看到開賣的圖..
          _timer(secondLeft);
          return true;
        }
      }
    }
    return false;
  }

}