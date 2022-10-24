import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/level_api.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../models/http/parameter/check_level_info.dart';
import '../../../models/http/parameter/level_info_data.dart';

class LevelDetailViewModel extends BaseViewModel {
  LevelDetailViewModel({required this.setState});

  final ViewChange setState;
  CheckLevelInfo? userLevelInfo;
  List<LevelInfoData> levelDataList = [];
  bool isLevelUp = false;
  late PageController pageController;

  void initState() async {
    userLevelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    isLevelUp = await LevelAPI().checkLevelUpdate();
    levelDataList = await LevelAPI().getAllLevelInfo();
    int index = 0;

    ///MARK: 5&6等 跳到第6等等級頁
    if (userLevelInfo!.userLevel >= 5) {
      index = 5;
    }

    ///1~4等 跳到 第+1等 等級頁
    else if (userLevelInfo!.userLevel > 0) {
      index = userLevelInfo!.userLevel;
    }
    pageController = PageController(initialPage: index);
    setState(() {});
  }

  void dispose() {
    pageController.dispose();
  }

  String getStrPointPercentage() {
    return '${NumberFormatUtil().integerFormat(getPointPercentage() * 100)}%';
  }

  double getPointPercentage() {
    if (userLevelInfo != null) {
      if (userLevelInfo!.userLevel == 6) {
        return 1;
      }
      return userLevelInfo!.point / userLevelInfo!.pointRequired;
    }
    return 0;
  }

  void onPressLevelUp(BuildContext context) {
    if (isLevelUp) {
      ///MARK: 判斷等級可以提升
      ///MARK: 自動升級
    }
  }

  LevelInfoData getSingleLevelInfo(int level) {
    for (var data in levelDataList) {
      if (data.userLevel == level) {
        return data;
      }
    }
    return levelDataList.first;
  }

  bool checkUnlock(int level) {
    return GlobalData.userInfo.level >= level;
  }

  void changePage(int level) {
    pageController.jumpToPage(level - 1);
  }

  ///MARK: 判斷是否為下一等級
  bool nextLevel(int level) {
    return (level - userLevelInfo!.userLevel) == 1;
  }

  ///MARK: 顯示下一等級獎勵
  void showLeveLBonus(BuildContext context) async {
    LevelAPI().getBonusInfo().then((levelBonus) {
      ///顯示等級獎勵

    });
  }
}
