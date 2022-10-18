import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeMainViewModel extends BaseViewModel {

  /// 取得輪播圖
  Future<List<HomeCarousel>> getHomeCarousel(
      {ResponseErrorFunction? onConnectFail}) async {
    return await HomeAPI(onConnectFail: onConnectFail)
        .getCarouselItem();
  }

  /// 查詢畫家列表
  Future<List<ArtistRecord>> getArtistRecord(
      {ResponseErrorFunction? onConnectFail}) async {
    return await HomeAPI(onConnectFail: onConnectFail)
        .getArtistRecord();
  }


  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }
  Widget getPaddingWithView(double val, Widget view) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)),
      child: view,
    );
  }

  /// 外部連結
  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

}