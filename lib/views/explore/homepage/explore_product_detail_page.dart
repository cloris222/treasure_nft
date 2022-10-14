import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  _oneRowForm('Network', _setShowingForm('Polygon'), false, false),
                  _oneRowForm('Time zone', _getTimeZoneList(), false, false),
                ],
              ),
            ),

            /// 商品大圖
            data.imgUrl != ''?
            Image.network(data.imgUrl, width: UIDefine.getScreenWidth(100), height: UIDefine.getScreenWidth(100))
            : Container(),

            /// 折線圖

            /// 預約按鈕+預約券總數量

            /// 等級+Range
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavigationBar(initType: AppNavigationBarType.typeExplore),
    );
  }
  
  List<String> _getTimeZoneList() {
    List<String> list = [];
    for (int i = 0; i < sellTimeList.length; i++) {
      list.add(' GMT ${sellTimeList[i].zone}  ${sellTimeList[i].localTime}');
    }
    return list;
  }

  List<String> _setShowingForm(String value) {
    List<String> list = [];
    list.add(value);
    return list;
  }

  Widget _oneRowForm(String title, List<String> contentList, bool bIcon, bool bContentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
        ),

        bIcon? Container(width: 4) : Container(),
        bIcon? Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(4), height: UIDefine.getScreenWidth(4)) : Container(),

        const SizedBox(width: 4),

        Column(
            children: _getFormContent(contentList, bContentColor)
        ),

      ],
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