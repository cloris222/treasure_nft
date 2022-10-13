import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/explore/explore_artist_home_page_view_model.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../data/explore_artist_detail_response_data.dart';
import '../data/explore_main_response_data.dart';
import 'home_page_widgets.dart';

class ExploreArtistHomePageView extends StatefulWidget {
  const ExploreArtistHomePageView({super.key, required this.artistData});

  final ExploreMainResponseData artistData;

  @override
  State<StatefulWidget> createState() => _ExploreArtistHomePageView();

}

class _ExploreArtistHomePageView extends State<ExploreArtistHomePageView> {

  ExploreArtistHomePageViewModel viewModel = ExploreArtistHomePageViewModel();
  bool bMore = false;
  ExploreArtistDetailResponseData data = ExploreArtistDetailResponseData(sms: [], list: ListClass(pageList: []));
  // List<ExploreArtistDetailResponseData> dataList = [];
  List productList = [];

  ExploreMainResponseData get artistData {
    return widget.artistData;
  }

  @override
  void initState() {
    super.initState();
    Future<ExploreArtistDetailResponseData> resList = viewModel.getArtistDetailResponse(artistData.artistId, '', 1, 10, 'time');
    resList.then((value) => _setData(value));
  }

  _setData(value) {
    data = value;
    productList = data.list.pageList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack( // 上方AppBar + 畫家資訊
              children: [
                /// 畫家照片+背景照+名稱
                HomePageWidgets.homePageTop(artistData, data.creatorName),

                /// AppBar
                CustomAppBar.getCornerAppBar(
                      () {
                    BaseViewModel().popPage(context);
                  },
                  artistData.artistName,
                  fontSize: UIDefine.fontSize24,
                  arrowFontSize: UIDefine.fontSize34,
                  circular: 40,
                  appBarHeight: UIDefine.getScreenWidth(20),
                ),
              ],
            ),
            /// 畫家簡介+更多Btn
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(4.3),
                  UIDefine.getScreenWidth(5), 0),
              child: Text(bMore? data.artistInfo : _shortString(data.artistInfo),
                style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(3.3), 0,
                  UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(4)),
              child: TextButton(
                onPressed: () => setState(() {
                  bMore = !bMore;
                }),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(bMore? 'Close' : 'See more',
                      style: TextStyle(color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),),
                    Image.asset(bMore? 'assets/icon/btn/btn_arrow_01_up.png' : 'assets/icon/btn/btn_arrow_01_down.png')
                  ],
                ),
              ),
            ),

            /// 數字統計
            HomePageWidgets.artistInfo(data),

            /// 輸入Bar
            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(5), 0),
              child: _searchBar(),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(5), 0),
              child: Row(
                children: [
                  Expanded(
                      child: _dropDownBar()
                  ),
                  SizedBox(width: UIDefine.getScreenWidth(2.77)),
                  Container(
                    alignment: Alignment.center,
                    width: 64,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppColors.mainThemeButton),
                        borderRadius: BorderRadius.circular(6)),
                    child: Image.asset('assets/icon/btn/btn_sort_01_nor.png'),
                  )
                ],
              ),
            ),

            /// 作品列表


          ],
        ),
      ),
    );
  }


  String _shortString(String sValue) {
    return sValue.length > 50? '${sValue.substring(0, 50)}....' : sValue;
  }

  Widget _searchBar() {
    return TextField(
        onChanged: (text) {
          // 撈產品資料 by text
          setState(() {

          });
        },
        style: TextStyle(fontSize: UIDefine.fontSize14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, UIDefine.getScreenWidth(4.16), 0, 0),
          prefixIcon: Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
          hintText: 'Select by name or attribute',
          hintStyle: const TextStyle(height: 1.6, color: AppColors.searchBar),
          labelStyle: const TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          border: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
        )
    );
  }

  final List<String> _currencies = [
    "Price",
    "Time",
  ];

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        // 選擇後近來這執行資料篩選
      },
      value: _currencies.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        hintText: 'Price',
        hintStyle: const TextStyle(height: 1.6, color: AppColors.searchBar),
        border: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(color: AppColors.searchBar, radius: 10),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
          value: category,
          child: Row(
            children: <Widget>[
              Text(category, style: const TextStyle(color: AppColors.searchBar)),
            ],
          )
        );
      }).toList(),
    );
  }


}