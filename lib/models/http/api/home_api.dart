import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/collect_top_info.dart';
import 'package:treasure_nft_project/models/http/parameter/discover_collect_data.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/models/http/parameter/home_footer_data.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/views/explore/api/explore_api.dart';
import 'package:treasure_nft_project/views/explore/data/explore_category_response_data.dart';

import '../../../view_models/home/provider/home_banner_provider.dart';
import '../parameter/home_banner_data.dart';
import '../parameter/home_film_data.dart';
import '../parameter/trading_volume_data.dart';

class HomeAPI extends HttpManager {
  HomeAPI({super.onConnectFail, super.baseUrl = HttpSetting.appUrl});

  Future<List<HomeCarousel>> getCarouselItem() async {
    List<HomeCarousel> result = <HomeCarousel>[];
    try {
      ApiResponse response = await get('/index/rotate/item');
      for (Map<String, dynamic> json in response.data) {
        result.add(HomeCarousel.fromJson(json));
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }

    /// save home carousel images
    List<String> encodeHomeCarousel =
        result.map((res) => json.encode(res.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// to write
    prefs.setStringList("homeCarousel", encodeHomeCarousel);

    return result;
  }

  Future<List<ArtistRecord>> getArtistRecord(
      {int page = 1, int size = 10}) async {
    List<ArtistRecord> result = <ArtistRecord>[];
    try {
      ApiResponse response =
          await get('/index/artist/record', queryParameters: {
        'size': size,
        'page': page,
      });
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(ArtistRecord.fromJson(json));
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return result;
  }

  ///MARK: 交易平台額
  Future<TradingVolumeData> getTradingVolume() async {
    var response = await get('/index/platform/tradingVolume');
    return TradingVolumeData.fromJson(response.data);
  }

  Future<Map<String, String>> getFooterSetting() async {
    var response = await get('/index/footer/icon');
    Map<String, String> list = {};
    for (Map<String, dynamic> json in response.data) {
      HomeFooterData data = HomeFooterData.fromJson(json);
      list[data.name] = data.status == "ENABLE" ? data.link : '';
    }
    return list;
  }

  ///MARK: 取得收藏集排行榜
  Future<List<CollectTopInfo>> getCollectRank() async {
    var response = await get('/index/artists/top');
    List<CollectTopInfo> list = [];
    try {
      for (Map<String, dynamic> json in response.data) {
        list.add(CollectTopInfo.fromJson(json));
      }
    } catch (e) {
      // print(e.toString());
    }
    return list;
  }

  ///MARK: 取得隨機收藏冊
  Future<List<RandomCollectInfo>> getRandomCollectList() async {
    var response = await get('/index/collection/fetured/nfts');
    List<RandomCollectInfo> list = [];
    try {
      for (Map<String, dynamic> json in response.data) {
        list.add(RandomCollectInfo.fromJson(json));
      }
    } catch (e) {}
    return list;
  }

  ///MARK: Discover More NFTS
  Future<List<DiscoverCollectData>> getDiscoverMoreNFT(
      {String category = ''}) async {
    List<DiscoverCollectData> list = [];
    try {
      var response = await get('/index/discover/moreNfts',
          queryParameters: {"page": 1, "size": 8, "categoryName": category});
      for (Map<String, dynamic> json in response.data['pageList']) {
        list.add(DiscoverCollectData.fromJson(json));
      }
    } catch (e) {}
    return list;
  }

  Future<List<ExploreCategoryResponseData>> getDiscoverTag() async {
    List<ExploreCategoryResponseData> tags = [];
    var respList = await ExploreApi().getExploreCategory();
    for (int i = 0; i < respList.length; i++) {
      if (respList[i].name == 'polygonNFT') {
        tags.insert(0, respList[i]);
      }
      if (respList[i].name == 'artwork') {
        tags.add(respList[i]);
      }
      if (respList[i].name == 'collection') {
        tags.add(respList[i]);
      }
    }
    ExploreCategoryResponseData data = ExploreCategoryResponseData();
    data.frontName = 'All';
    data.name = '';
    tags.insert(0, data);
    return tags;
  }

  ///MARK: 查詢廣告
  Future<List<BannerData>> getBanner(WidgetRef ref) async {
    List<BannerData> result = <BannerData>[];
    try {
      ApiResponse response = await get('/index/banner/all',queryParameters: {"lang":LanguageUtil.getAnnouncementLanguage()});

      ref.read(bannerSecondsProvider.notifier)
          .update((state) => response.data['carouselSeconds']);

      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(BannerData.fromJson(json));
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return result;
  }

  ///MARK 查詢影片
  Future<List<HomeFilmData>> getFilm({String? page,String? size, String? lang}) async {
    List<HomeFilmData> data = <HomeFilmData>[];
    ApiResponse response = await get('/index/content/film'
        ,queryParameters: {
        "page": 1,
        "size": 20,
        "lang": lang,
      }
      );
      for(Map<String,dynamic> json in response.data["pageList"]){
        data.add(HomeFilmData.fromJson(json));
      }
    return data;
  }
}
