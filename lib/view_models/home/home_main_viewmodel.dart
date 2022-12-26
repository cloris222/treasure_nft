import 'dart:convert';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification_data.dart';
import 'package:treasure_nft_project/utils/observer_pattern/subject.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../models/http/parameter/trading_volume_data.dart';

class HomeMainViewModel extends BaseViewModel {
  Subject homeSubject = Subject();

  bool needRecordAnimation = Platform.isIOS;

  List<HomeCarousel> homeCarouselList = [];
  List<ArtistRecord> homeArtistRecordList = [];
  Map<String, String> status = {};
  TradingVolumeData? volumeData;

  late VideoPlayerController videoController;
  ChewieController? playerController;

  void initState() async {
    /// to read pre load image
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("homeCarousel")) {
      List<String>? decodeHomeCarouselString =
          prefs.getStringList("homeCarousel");
      homeCarouselList = decodeHomeCarouselString!
          .map((res) => HomeCarousel.fromJson(json.decode(res)))
          .toList();
      homeSubject
          .notifyObservers(NotificationData(key: SubjectKey.keyHomeCarousel));
    }

    getHomeCarousel();
    getArtistRecord();
    getUsdtInfo();
    getContactInfo();
  }

  void dispose() {
    homeSubject.clearObserver();
    videoController.dispose();
    playerController?.dispose();
  }

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
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeArtRecords));
  }

  Future<void> getUsdtInfo() async {
    volumeData = await HomeAPI().getTradingVolume();
    homeSubject.notifyObservers(NotificationData(key: SubjectKey.keyHomeUSDT));
  }

  Future<void> getContactInfo() async {
    ///MARK: 取得聯絡資訊
    status = await HomeAPI().getFooterSetting();
    homeSubject
        .notifyObservers(NotificationData(key: SubjectKey.keyHomeContact));
  }

  void initHomeAdVideo() async {
    videoController = VideoPlayerController.network(HttpSetting.homeAdUrl);
    await Future.delayed(const Duration(seconds: 1));
    videoController.initialize().then((value) {
      playerController = ChewieController(
          videoPlayerController: videoController,
          looping: true,
          customControls: const CupertinoControls(
            backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
            iconColor: Color.fromARGB(255, 200, 200, 200),
          ),
          deviceOrientationsOnEnterFullScreen: [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
      homeSubject
          .notifyObservers(NotificationData(key: SubjectKey.keyHomeVideo));
    });
  }

  Widget buildSpace({double width = 0, double height = 0}) {
    return SizedBox(height: height * 5, width: width * 5);
  }

  Widget getPaddingWithView(double val, Widget view) {
    return Padding(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(val)),
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

  int animateIndex = -1;

  ///MARK: 動畫翻轉
  void playAnimate() async {
    homeSubject.notifyObservers(
        NotificationData(key: SubjectKey.keyHomeAnimationWait));
    _loopAnimate();
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
