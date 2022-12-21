import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/collect_top_info.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/http/parameter/trading_volume_data.dart';

class HomeMainViewModel extends BaseViewModel {
  ///Widget Style----------
  Widget buildSpace({double width = 0, double height = 0}) {
    return SizedBox(
        height: UIDefine.getPixelHeight(height * 5),
        width: UIDefine.getPixelWidth(width * 5));
  }

  ///MARK: 主標題
  TextStyle getMainTitleStyle() {
    return TextStyle(
        fontSize: UIDefine.fontSize20,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack);
  }

  ///MARK: 副標題
  TextStyle getSubTitleStyle() {
    return TextStyle(
        fontSize: UIDefine.fontSize16,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack);
  }

  ///MARK: 內容
  TextStyle getContextStyle({Color color=AppColors.textBlack}) {
    return TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w400,
        color: color);
  }

  ///MARK: 共用的左右間距
  EdgeInsetsGeometry getMainPadding({double width = 20, double height = 0}) {
    return EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(width),
        vertical: UIDefine.getPixelHeight(height));
  }

  ///API----------
  /// 取得輪播圖
  Future<List<HomeCarousel>> getHomeCarousel(
      {ResponseErrorFunction? onConnectFail}) async {
    return await HomeAPI(onConnectFail: onConnectFail).getCarouselItem();
  }

  /// 查詢畫家列表
  Future<List<ArtistRecord>> getArtistRecord(
      {ResponseErrorFunction? onConnectFail}) async {
    return await HomeAPI(onConnectFail: onConnectFail).getArtistRecord();
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

  Future<TradingVolumeData> getUsdtInfo() async {
    return HomeAPI().getTradingVolume();
  }

  Future<List<CollectTopInfo>> getCollectTop() async {
    return HomeAPI().getCollectTop();
  }

  Future<List<RandomCollectInfo>> getRandomCollect() async {
    return HomeAPI().getRandomCollectList();
  }
}
