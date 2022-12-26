import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/collect_top_info.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification_data.dart';
import 'package:treasure_nft_project/utils/observer_pattern/subject.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/http/parameter/trading_volume_data.dart';

class HomeMainViewModel extends BaseViewModel {
  Subject homeSubject = Subject();

  bool needRecordAnimation = Platform.isIOS;

  List<HomeCarousel> homeCarouselList = [];
  List<ArtistRecord> homeArtistRecordList = [];
  Map<String, String> status = {};
  TradingVolumeData? volumeData;

  ///new ui
  List<CollectTopInfo> homeCollectTopList = [];
  List<RandomCollectInfo> homeRandomCollectList = [];
  ArtistRecord? randomArt;

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
  TextStyle getContextStyle({Color color = AppColors.textBlack}) {
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

  void initState() async {
    /// to read pre load image
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? decodeHomeCarouselString =
        prefs.getStringList("homeCarousel");
    homeCarouselList = decodeHomeCarouselString!
        .map((res) => HomeCarousel.fromJson(json.decode(res)))
        .toList();
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeCarousel));

    ///更新畫面API
    getHomeCarousel();
    getArtistRecord();
    getUsdtInfo();
    getCollectTop();
    getRandomCollect();
    getContactInfo();
  }

  void dispose() {
    homeSubject.clearObserver();
  }

  ///API----------
  /// 取得輪播圖
  Future<void> getHomeCarousel({ResponseErrorFunction? onConnectFail}) async {
    homeCarouselList =
        await HomeAPI(onConnectFail: onConnectFail).getCarouselItem();
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeCarousel));
  }

  /// 查詢畫家列表
  Future<void> getArtistRecord({ResponseErrorFunction? onConnectFail}) async {
    homeArtistRecordList =
        await HomeAPI(onConnectFail: onConnectFail).getArtistRecord();
    randomArt =
        homeArtistRecordList[Random().nextInt(homeArtistRecordList.length)];
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeArtRecords));
  }

  Future<void> getUsdtInfo() async {
    volumeData = await HomeAPI().getTradingVolume();
    homeSubject.notifyObservers(NotificationData(key: SubjectKey.keyHomeUSDT));
  }

  Future<void> getCollectTop() async {
    homeCollectTopList = await HomeAPI().getCollectTop();
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeCollectTop));
  }

  Future<void> getRandomCollect() async {
    homeRandomCollectList = await HomeAPI().getRandomCollectList();
    homeSubject.notifyObservers(
        NotificationData(key: SubjectKey.keyHomeRandomCollect));
  }

  Future<void> getContactInfo() async {
    ///MARK: 取得聯絡資訊
    status = await HomeAPI().getFooterSetting();
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeContact));
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

  int animateIndex = -1;

  ///MARK: 動畫翻轉
  void playAnimate() async {
    if (homeCarouselList.isNotEmpty) {
      _loopAnimate();
    }
  }

  void resetAnimate() async {
    animateIndex = -1;
    homeSubject.notifyObservers(
        NotificationData(key: SubjectKey.keyHomeAnimationReset));
  }

  _loopAnimate() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      animateIndex += 1;
      homeSubject.notifyObservers(NotificationData(
          key: '${SubjectKey.keyHomeAnimationStart}_$animateIndex'));
      if (animateIndex < homeArtistRecordList.length) {
        _loopAnimate();
      }
    });
  }
}
