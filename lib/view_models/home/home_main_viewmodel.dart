import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/discover_collect_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification_data.dart';
import 'package:treasure_nft_project/utils/observer_pattern/subject.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/home/provider/home_discover_provider.dart';
import 'package:treasure_nft_project/views/explore/data/explore_category_response_data.dart';

import 'provider/home_artist_random_provider.dart';
import 'provider/home_carousel_provider.dart';
import 'provider/home_collect_random_provider.dart';
import 'provider/home_collect_rank_provider.dart';
import 'provider/home_contact_info_provider.dart';
import 'provider/home_usdt_provider.dart';

class HomeMainViewModel extends BaseViewModel {
  Subject homeSubject = Subject();

  bool needRecordAnimation = Platform.isIOS;

  void dispose() {
    homeSubject.clearObserver();
  }

  int animateIndex = -1;

  ///MARK: 動畫翻轉
  void playAnimate(WidgetRef ref) async {
    homeSubject.notifyObservers(
        NotificationData(key: SubjectKey.keyHomeAnimationWait));
    _loopAnimate(ref);
  }

  void resetAnimate(WidgetRef ref) async {
    animateIndex = -1;
    homeSubject.notifyObservers(
        NotificationData(key: SubjectKey.keyHomeAnimationReset));
  }

  _loopAnimate(WidgetRef ref) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      animateIndex += 1;
      homeSubject.notifyObservers(NotificationData(
          key: '${SubjectKey.keyHomeAnimationStart}_$animateIndex'));
      if (animateIndex < ref.read(homeCollectRankProvider).length) {
        _loopAnimate(ref);
      }
    });
  }
}
