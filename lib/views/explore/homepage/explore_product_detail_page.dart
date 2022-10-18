import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../../constant/ui_define.dart';
import '../../../utils/timer_util.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/explore/explore_product_detail_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../../explore_chart_view.dart';
import '../data/explore_item_response_data.dart';

class ExploreProductDetailPage extends StatefulWidget {
  const ExploreProductDetailPage({super.key, required this.itemId});

  final String itemId;

  @override
  State<StatefulWidget> createState() => _ExploreProductDetailPage();
}

class ChartData {
  final int date;
  final double price;
  ChartData(this.date, this.price);
}

class _ExploreProductDetailPage extends State<ExploreProductDetailPage> {

  ExploreProductDetailViewModel viewModel = ExploreProductDetailViewModel();
  ExploreItemResponseData data = ExploreItemResponseData(priceHistory: [], sellTimeList: []);
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

    _timer();
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

  _timer() {
    CountDownTimerUtil().init(callBackListener:
    MyCallBackListener(
        myCallBack: (sTimeLeft) {
      setState(() { this.sTimeLeft = sTimeLeft; });
    }),
        endTimeSeconds: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// AppBar
            CustomAppBar.getCornerAppBar(
                  () {
                BaseViewModel().popPage(context);
              },
              'Detail',
              fontSize: UIDefine.fontSize24,
              arrowFontSize: UIDefine.fontSize34,
              circular: 40,
              appBarHeight: UIDefine.getScreenWidth(20),
            ),

            /// 提醒標語+倒數計時
            Visibility(
              visible: sellTimeList.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10),
                    UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Auction will being in',
                      style: TextStyle(fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),
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
                            style: TextStyle(color: Colors.white, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontSize: UIDefine.fontSize26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  _oneRowForm('Owner', _setShowingForm(data.ownerName), false, false),
                  _oneRowForm('Price', _setShowingForm(data.price), true, true),
                  _oneRowForm('Resale income', _setShowingForm(data.growAmount), true, true),
                  _oneRowForm('Network', _setShowingForm('Polygon'), false, false), // test 這是啥 resp內沒有
                  _oneRowForm('Time zone', _getTimeZoneList(), false, false),
                ],
              ),
            ),

            /// 商品大圖
            data.imgUrl != ''?
            Image.network(data.imgUrl, width: UIDefine.getScreenWidth(100), height: UIDefine.getScreenWidth(100))
            : Container(),

            /// 折線圖標題
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
              child: Text(
                'Historical Value',
                style: TextStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w700),
              ),
            ),

            /// 折線圖圖表
            chartView,

            /// 預約按鈕+預約券總數量
            Container(
              margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10),
                  UIDefine.getScreenWidth(5), 0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.mainThemeButton,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: TextButton(
                onPressed: () {  },
                  child: Text(
                    tr('Reserve'),
                    style: TextStyle(
                        color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                  )
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0,
                  UIDefine.getScreenWidth(5), 0),
              child: Text(
                tr('Reservation Ticket Amount : ' + GlobalData.userInfo.point.toString()),
                style: TextStyle(
                    color: AppColors.textRed, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              )
            ),

            /// 等級+Range
            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10),
                  UIDefine.getScreenWidth(5), 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(viewModel.getLevelImg(), width: UIDefine.getScreenWidth(10), height: UIDefine.getScreenWidth(10)),
                  const SizedBox(width: 10),
                  Text(
                    tr('Level' + GlobalData.userInfo.level.toString()),
                    style: TextStyle(
                        color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(2),
                  UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr('NFT Amount Range'),
                    style: TextStyle(
                        color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(5), height: UIDefine.getScreenWidth(5)),
                      const SizedBox(width: 10),
                      Text(
                        '0~99,999', // test 哪裡來的數字
                        style: TextStyle(
                            color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavigationBar(initType: AppNavigationBarType.typeExplore),
    );
  }

  List<String> _getTimeZoneList() {
    List<String> list = [];
    for (int i = 0; i < sellTimeList.length; i++) {
      list.add('GMT ${sellTimeList[i].zone}  ${sellTimeList[i].localTime}');
    }
    return list;
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
            style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
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
        style: TextStyle(color: bContentColor? AppColors.textBlack : AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
      ));
    }
    return textView;
  }

}