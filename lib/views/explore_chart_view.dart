import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constant/ui_define.dart';
import 'explore/data/explore_item_response_data.dart';
import 'package:charts_flutter/flutter.dart' as chart;

import 'explore/itemdetail/explore_product_detail_page.dart';

class ExploreChartView extends StatefulWidget {

  const ExploreChartView({super.key, required this.priceHistoryList, required this.todayPrice});

  final List<PriceHistory> priceHistoryList;
  final String todayPrice;

  @override
  State<StatefulWidget> createState() => _ExploreChartView();

}

class _ExploreChartView extends State<ExploreChartView> {

  List<PriceHistory> get priceHistoryList {
    return widget.priceHistoryList;
  }

  String get todayPrice {
    return widget.todayPrice;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer( // 折線圖
        absorbing: true, // Disable折線圖的click 不然會影響scroll
        child: Container(
            padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(5), 0),
            width: UIDefine.getScreenWidth(100),
            height: UIDefine.getScreenWidth(55),
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
                          chart.TickSpec<num>(double.parse(todayPrice)),
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
    );
  }

  /// X,Y軸的數值設置
  _setChartData() {
    List<chart.Series<dynamic, num>> seriesList = [];
    if (priceHistoryList.isNotEmpty) {
      var data = [
        ChartData(1, double.parse(priceHistoryList[0].price)),
        ChartData(2, double.parse(priceHistoryList[1].price)),
        ChartData(3, double.parse(priceHistoryList[2].price)),
        ChartData(4, double.parse(priceHistoryList[3].price)),
        ChartData(5, double.parse(todayPrice)),
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
    }
    return seriesList;
  }

  /// 將橫軸名稱轉換為日期
  late chart.BasicNumericTickFormatterSpec customTickFormatter = chart.BasicNumericTickFormatterSpec((value) {
    if (priceHistoryList.isEmpty) {
      return '';
    }
    if (value == 1) {
      return _getLastFourDate(priceHistoryList[0].date);
    } else if (value == 2) {
      return _getLastFourDate(priceHistoryList[1].date);
    } else if (value == 3) {
      return _getLastFourDate(priceHistoryList[2].date);
    } else if (value == 4) {
      return _getLastFourDate(priceHistoryList[3].date);
    } else if (value == 5) {
      return _getMonthDate(todayPrice);
    }
    return '';
  });

  /// 將今天的日期轉為HH/dd 顯示
  String _getMonthDate(String sValue) {
    DateFormat dateFormat = DateFormat("MM-dd","en_US");
    String sDate = dateFormat.format(DateTime.now());
    return sDate.replaceAll('-', '/');
  }

  /// 將response的四個日期轉為HH/dd 顯示
  String _getLastFourDate(String sValue) {
    return sValue.substring(5, 10).replaceAll('-', '/');
  }
}