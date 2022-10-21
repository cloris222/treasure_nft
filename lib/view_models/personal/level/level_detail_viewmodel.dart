import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/models/http/api/level_api.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../models/http/parameter/check_level_info.dart';

class LevelDetailViewModel extends BaseViewModel {
  LevelDetailViewModel({required this.setState});

  final ViewChange setState;
  CheckLevelInfo? levelInfo;
  bool isLevelUp = false;

  void initState() async {
    levelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    isLevelUp = await LevelAPI().checkLevelUpdate();
    setState(() {});
  }

  String getStrPointPercentage() {
    return '${NumberFormatUtil().integerFormat(getPointPercentage() * 100)}%';
  }

  double getPointPercentage() {
    if (levelInfo != null) {
      if (levelInfo!.userLevel == 6) {
        return 1;
      }
      return levelInfo!.point / levelInfo!.pointRequired;
    }
    return 0;
  }

  void onPressLevelUp(BuildContext context) {
    if (isLevelUp) {
      ///MARK: 判斷等級可以提升
    }
  }
}
