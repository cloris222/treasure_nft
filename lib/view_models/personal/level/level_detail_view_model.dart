import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/level_api.dart';
import 'package:treasure_nft_project/models/http/parameter/level_info_data.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/level/level_bonus_page.dart';

import '../../../models/http/parameter/check_level_info.dart';

class LevelDetailViewModel extends BaseViewModel {
  LevelDetailViewModel();

  String getStrPointPercentage(CheckLevelInfo? userLevelInfo) {
    return '${NumberFormatUtil().integerFormat(getPointPercentage(userLevelInfo) * 100)}%';
  }

  double getPointPercentage(CheckLevelInfo? userLevelInfo) {
    return userLevelInfo?.getPointPercentage() ?? 0;
  }

  LevelInfoData getSingleLevelInfo(List<LevelInfoData> levelDataList,int level) {
    for (var data in levelDataList) {
      if (data.userLevel == level) {
        return data;
      }
    }
    return levelDataList.first;
  }

  bool checkUnlock(int level, UserInfoData userInfo) {
    return userInfo.level >= level;
  }

  ///MARK: 判斷是否為下一等級
  bool nextLevel(int level,CheckLevelInfo? userLevelInfo) {
    ///MARK: v0.0.12 等級6也需要顯示bonus Button
    if (userLevelInfo!.userLevel == 6 && level == 6) {
      return true;
    }
    return (level - userLevelInfo.userLevel) == 1;
  }

  ///MARK: 顯示下一等級獎勵
  void showLeveLBonus(BuildContext context) async {
    pushPage(context, const LevelBonusPage());
  }
}
