import 'package:charts_flutter/flutter.dart' as chart;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/explore/explore_product_detail_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
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

  @override
  void initState() {
    super.initState();
    Future<ExploreItemResponseData> resList = viewModel.getExploreItemDetail(widget.itemId);
    resList.then((value) => _setData(value));
  }

  _setData(value) {
    data = value;
    sellTimeList = data.sellTimeList;
    priceHistoryList = data.priceHistory;
    setState(() {});
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
            Padding(
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
                          '00:01:00:20',
                          style: TextStyle(color: Colors.white, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )
                ],
              ),
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

            /// 折線圖
            Container( // 標題
              alignment: Alignment.center,
              padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
              child: Text(
                'Historical Value',
                style: TextStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w700),
              ),
            ),

            Container( // 折線圖
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(5), 0),
              width: UIDefine.getScreenWidth(100),
              height: UIDefine.getScreenWidth(55),

              child: AbsorbPointer(
                absorbing: true, // Disable折線圖的click 不然會影響scroll
                child: chart.LineChart(
                    _setChartData(),
                    animate: true,
                    primaryMeasureAxis: chart.NumericAxisSpec(
                        showAxisLine: true,
                        tickProviderSpec: chart.StaticNumericTickProviderSpec(
                          priceHistoryList.isNotEmpty?
                          <chart.TickSpec<num>> [ // 可另外寫Func找出最低最高點 用來設表格上下限 (這裡是劃出橫向界線)
                            chart.TickSpec<num>(double.parse(priceHistoryList[0].price)),
                            chart.TickSpec<num>(double.parse(priceHistoryList[1].price)),
                            chart.TickSpec<num>(double.parse(priceHistoryList[2].price)),
                            chart.TickSpec<num>(double.parse(priceHistoryList[3].price)),
                            chart.TickSpec<num>(double.parse(data.price)),
                            chart.TickSpec<num>(double.parse(priceHistoryList[3].price) - (double.parse(priceHistoryList[3].price)/10)),
                            chart.TickSpec<num>(double.parse(priceHistoryList[3].price) + (double.parse(priceHistoryList[3].price)/10)),
                          ]
                              :
                          <chart.TickSpec<num>> []
                        ),
                        renderSpec: chart.GridlineRendererSpec(
                            labelStyle: chart.TextStyleSpec(
                                fontSize: 14, // size in Pts.
                                color: chart.Color.fromHex(code: '#7A7C7D')),

                            lineStyle: chart.LineStyleSpec(
                                thickness: 1,
                                color: chart.Color.fromHex(code: '#7A7C7D'))
                      )
                  ),

                  domainAxis: chart.NumericAxisSpec(
                      tickProviderSpec: const chart.BasicNumericTickProviderSpec(desiredTickCount:7),
                      tickFormatterSpec: customTickFormatter,
                      showAxisLine: false,
                      renderSpec: chart.GridlineRendererSpec(
                          labelStyle: chart.TextStyleSpec(
                              fontSize: 14, // size in Pts.
                              color: chart.Color.fromHex(code: '#7A7C7D')),

                          lineStyle: const chart.LineStyleSpec(
                              thickness: 0,
                              color: chart.MaterialPalette.transparent)
                      )
                  ),

                  defaultRenderer: chart.LineRendererConfig(
                    radiusPx: 4,
                    stacked: false,
                    strokeWidthPx: 4,
                    includeLine: true,
                    includePoints: true,
                  )
                )
              )
            ),

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

  /// 將橫軸名稱轉換為日期
  late chart.BasicNumericTickFormatterSpec customTickFormatter = chart.BasicNumericTickFormatterSpec((value) {
    if (value == 1) {
      return _getLastFourDate(priceHistoryList[0].date);
    } else if (value == 2) {
      return _getLastFourDate(priceHistoryList[1].date);
    } else if (value == 3) {
      return _getLastFourDate(priceHistoryList[2].date);
    } else if (value == 4) {
      return _getLastFourDate(priceHistoryList[3].date);
    } else if (value == 5) {
      return _getMonthDate(data.price);
    }
    return '';
  });

  /// X,Y軸的數值設置
  _setChartData() {
    List<chart.Series<dynamic, num>> seriesList = [];
    if (priceHistoryList.isNotEmpty) {
      var data = [
        ChartData(1, double.parse(priceHistoryList[0].price)),
        ChartData(2, double.parse(priceHistoryList[1].price)),
        ChartData(3, double.parse(priceHistoryList[2].price)),
        ChartData(4, double.parse(priceHistoryList[3].price)),
        ChartData(5, double.parse(this.data.price)),
      ];

      seriesList = [
        chart.Series<ChartData, int>(
          id: 'Sales',
          colorFn: (_, __) => chart.MaterialPalette.green.shadeDefault,
          domainFn: (ChartData sales, _) => sales.date,
          measureFn: (ChartData sales, _) => sales.price,
          data: data,
        )
      ];
      setState(() {});
    }
    return seriesList;
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

  /// 將今天的日期轉為HH/dd 顯示
  String _getMonthDate(String sValue) {
    DateFormat dateFormat = DateFormat("MM-dd");
    String sDate = dateFormat.format(DateTime.now());
    return sDate.replaceAll('-', '/');
  }

  /// 將response的四個日期轉為HH/dd 顯示
  String _getLastFourDate(String sValue) {
    return sValue.substring(5, 10).replaceAll('-', '/');
  }

}