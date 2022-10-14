import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/api/trade_api.dart';

class TradeMainViewModel extends BaseViewModel {
  TradeMainViewModel({required this.setState});

  final ViewChange setState;
  CheckReservationInfo? reservationInfo;
  CheckLevelInfo? userLevelInfo;

  Future<void> initState() async {
    reservationInfo = await TradeAPI().getCheckReservationInfoAPI();
    userLevelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    setState(() {});
  }

  /// display star ~ end price range
  String getRange() {
    dynamic? min;
    dynamic? max;

    min = userLevelInfo?.buyRangeStart;
    max = userLevelInfo?.buyRangeEnd;
    return '$min~$max';
  }

  /// display level image
  String getLevelImg() {
    return format(AppImagePath.level, ({'level': GlobalData.userInfo.level}));
  }
}
