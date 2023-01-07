import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/views/home/home_main_view.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/explore/explore_artist_home_page_view_model.dart';
import '../../custom_appbar_view.dart';
import '../../server_web_page.dart';
import '../../setting_language_page.dart';
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

  // bool bMore = false; // 第一版UI
  bool bShowMore = false;
  ExploreArtistDetailResponseData data =
      ExploreArtistDetailResponseData(sms: [], list: ListClass(pageList: []));
  List<PageList> productList = [];
  String searchValue = '';
  String dropDownValue = 'Price';
  bool bSort = true;
  String sortBy = 'price';
  int page = 1;
  bool bDownloading = false;

  ExploreMainResponseData get artistData {
    return widget.artistData;
  }

  @override
  void initState() {
    super.initState();
    Future<ExploreArtistDetailResponseData> resList = viewModel
        .getArtistDetailResponse(artistData.artistId, '', page, 10, sortBy);
    resList.then((value) => _setData(value));
  }

  _setData(value) {
    data = value;
    productList = data.list.pageList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      body: NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isTop = metrics.pixels == 0;
              if (isTop) {
                GlobalData.printLog('At the top');
              } else {
                if (!bDownloading) {
                  // 防止短時間載入過多造成OOM
                  bDownloading = true;
                  page += 1;
                  _updateView();
                }
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomePageWidgets().newHomePageTop(artistData, data, bShowMore,
                    popBack: _popBack,
                    shareAction: _shareAction,
                    searchAction: _searchAction,
                    sortAction: _sortAction, seeMoreAction: () {
                  setState(() {
                    bShowMore = !bShowMore;
                  });
                }),
                Stack(
                  children: [
                    /// 黑色底
                    Container(
                        color: AppColors.textBlack,
                        width: double.infinity,
                        height: UIDefine.getScreenWidth(10)),

                    Container(
                        padding:
                            EdgeInsets.only(top: UIDefine.getScreenWidth(4.5)),
                        decoration: const BoxDecoration(
                            color: AppColors.textWhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              if (index == productList.length - 1) {
                                // 開啟'到底更新'的Flag
                                bDownloading = false;
                              }
                              if (index % 2 == 0 &&
                                  index == productList.length - 1) {
                                return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        UIDefine.getScreenWidth(4.5),
                                        0,
                                        0,
                                        UIDefine.getScreenWidth(4.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        HomePageWidgets().productView(
                                            context, productList[index]),
                                      ],
                                    ));
                              }
                              if (index % 2 != 0) {
                                return Container();
                              }
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    UIDefine.getScreenWidth(4.5),
                                    0,
                                    UIDefine.getScreenWidth(4.5),
                                    UIDefine.getScreenWidth(4.5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HomePageWidgets().productView(
                                        context, productList[index]),
                                    HomePageWidgets().productView(
                                        context, productList[index + 1])
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
                SizedBox(height: UIDefine.navigationBarPadding)
              ],
            ),
          )),
    );
  }

  // @override // 第一版UI
  // Widget build(BuildContext context) {
  //   return CustomAppbarView(
  //     needCover: true,
  //     needScrollView: false,
  //     title: artistData.artistName,
  //     type: AppNavigationBarType.typeExplore,
  //     body: NotificationListener<ScrollEndNotification>(
  //         onNotification: (scrollEnd) {
  //           final metrics = scrollEnd.metrics;
  //           if (metrics.atEdge) {
  //             bool isTop = metrics.pixels == 0;
  //             if (isTop) {
  //               debugPrint('At the top');
  //             } else {
  //               if (!bDownloading) { // 防止短時間載入過多造成OOM
  //                 bDownloading = true;
  //                 page += 1;
  //                 _updateView();
  //               }
  //             }
  //           }
  //           return true;
  //         },
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Stack(
  //                 // 上方AppBar + 畫家資訊
  //                 children: [
  //                   /// 畫家照片+背景照+名稱
  //                   HomePageWidgets().homePageTop(
  //                       artistData, data.creatorName,
  //                       callBack: (url) {
  //                         if (url == 'Share') {
  //                           viewModel.sharePCUrl(artistData.artistId);
  //                         } else {
  //                           viewModel.launchInBrowser(url);
  //                         }
  //                       },
  //                       smList: data.sms
  //                   )
  //                 ],
  //               ),
  //
  //               /// 畫家簡介+更多Btn
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 padding: EdgeInsets.fromLTRB(
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(4.3),
  //                     UIDefine.getScreenWidth(5),
  //                     0),
  //                 child: Text(
  //                   bMore ? data.artistInfo : _shortString(data.artistInfo),
  //                   style: CustomTextStyle.getBaseStyle(
  //                       color: AppColors.dialogGrey,
  //                       fontSize: UIDefine.fontSize12,
  //                       fontWeight: FontWeight.w500),
  //                 ),
  //               ),
  //
  //               Padding(
  //                 padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(3.3), 0,
  //                     UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(4)),
  //                 child: TextButton(
  //                   onPressed: () => setState(() {
  //                     bMore = !bMore;
  //                   }),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         bMore ? tr('SeeLess') : tr('SeeMore'),
  //                         style: CustomTextStyle.getBaseStyle(
  //                             color: AppColors.mainThemeButton,
  //                             fontSize: UIDefine.fontSize14,
  //                             fontWeight: FontWeight.w500),
  //                       ),
  //                       Image.asset(bMore
  //                           ? 'assets/icon/btn/btn_arrow_01_up.png'
  //                           : 'assets/icon/btn/btn_arrow_01_down.png')
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //
  //               /// 數字統計
  //               HomePageWidgets().artistInfo(data),
  //
  //               /// 輸入Bar
  //               Padding(
  //                 padding: EdgeInsets.fromLTRB(
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(5),
  //                     0),
  //                 child: _searchBar(),
  //               ),
  //
  //               Padding(
  //                 padding: EdgeInsets.fromLTRB(
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(5),
  //                     UIDefine.getScreenWidth(5)),
  //                 child: Row(
  //                   children: [
  //                     Expanded(child: _dropDownBar()),
  //                     SizedBox(width: UIDefine.getScreenWidth(2.77)),
  //                     GestureDetector(
  //                         onTap: () => _onPressSort(),
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           width: UIDefine.getScreenWidth(17.77),
  //                           height: UIDefine.getScreenWidth(13.88),
  //                           decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   width: 2, color: AppColors.mainThemeButton),
  //                               borderRadius: BorderRadius.circular(6)),
  //                           child: Image.asset(
  //                               'assets/icon/btn/btn_sort_01_nor.png'),
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //
  //               /// 作品列表
  //               ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount: productList.length,
  //                   itemBuilder: (context, index) {
  //                     if (index == productList.length - 1) { // 開啟'到底更新'的Flag
  //                       bDownloading = false;
  //                     }
  //                     if (index % 2 == 0 && index == productList.length - 1) {
  //                       return Padding(
  //                           padding: EdgeInsets.fromLTRB(
  //                               UIDefine.getScreenWidth(5),
  //                               0,
  //                               0,
  //                               UIDefine.getScreenWidth(5)),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               HomePageWidgets().productView(
  //                                   context, productList[index]),
  //                             ],
  //                           ));
  //                     }
  //                     if (index % 2 != 0) {
  //                       return Container();
  //                     }
  //                     return Padding(
  //                       padding: EdgeInsets.fromLTRB(
  //                           UIDefine.getScreenWidth(5),
  //                           0,
  //                           UIDefine.getScreenWidth(5),
  //                           UIDefine.getScreenWidth(5)),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           HomePageWidgets().productView(
  //                               context, productList[index]),
  //                           HomePageWidgets().productView(
  //                               context, productList[index + 1])
  //                         ],
  //                       ),
  //                     );
  //                   })
  //             ],
  //           ),
  //         )),
  //   );
  // }

  String _shortString(String sValue) {
    return sValue.length > 50 ? '${sValue.substring(0, 50)}....' : sValue;
  }

  _updateView() {
    Future<ExploreArtistDetailResponseData> resList =
        viewModel.getArtistDetailResponse(
            artistData.artistId, searchValue, page, 10, sortBy);
    resList.then((value) => setState(() {
          productList.addAll(value.list.pageList);
        }));
  }

  _onPressSort() {
    // 撈產品資料 by sort
    bSort = !bSort;
    _getNewProductListResponse();
  }

  _getNewProductListResponse() {
    // String sortBy = 'time';
    page = 1;
    if (bSort) {
      if (dropDownValue == 'Price') {
        sortBy = 'price';
      } else {
        sortBy = 'time';
      }
    } else {
      if (dropDownValue == 'Price') {
        sortBy = 'priceAsc';
      } else {
        sortBy = 'timeAsc';
      }
    }
    productList.clear();
    Future<ExploreArtistDetailResponseData> resList =
        viewModel.getArtistDetailResponse(
            artistData.artistId, searchValue, page, 10, sortBy);
    resList.then((value) => _setData(value));
  }

  Widget _searchBar() {
    return TextField(
        onChanged: (text) {
          // 撈產品資料 by text
          searchValue = text;
          _getNewProductListResponse();
        },
        style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.fromLTRB(0, UIDefine.getScreenWidth(4.16), 0, 0),
          prefixIcon: Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
          hintText: tr("select-placeholder'"),
          hintStyle:  AppTextStyle.getBaseStyle(height: 1.6, color: AppColors.searchBar),
          labelStyle:  AppTextStyle.getBaseStyle(color: Colors.black),
          alignLabelWithHint: true,
          border: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
        ));
  }

  final List<String> _currencies = [
    "Price",
    "Time",
  ];

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        // 將選擇的暫存在全域
        dropDownValue = newValue!;
      },
      value: _currencies.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style:  AppTextStyle.getBaseStyle(color: AppColors.searchBar)),
              ],
            ));
      }).toList(),
    );
  }

  String _getCategoryText(String value) {
    // 下拉選單 多國
    switch (value) {
      case 'Price':
        return tr('price');
      case 'Time':
        return tr('time');
    }
    return '';
  }

  void _serverAction() {
    viewModel.pushPage(context, const ServerWebPage());
    // viewModel.pushPage(context, const SplashScreenPage());
  }

  void _globalAction() async {
    await BaseViewModel().pushPage(context, const SettingLanguagePage());
  }

  void _mainAction() {
    viewModel.pushPage(context, const HomeMainView());
  }

  void _shareAction() {
    // test 等規格出來
  }

  void _popBack() {
    Navigator.pop(context);
  }

  void _searchAction() {
    // test 等規格出來
  }

  void _sortAction() {
    // test 等規格出來
  }
}
