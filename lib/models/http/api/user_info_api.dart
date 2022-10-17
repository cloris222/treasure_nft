import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/check_level_info.dart';
import '../parameter/user_info_data.dart';

class UserInfoAPI extends HttpManager {
  UserInfoAPI({super.onConnectFail});

  ///MARK: 會員資訊
  Future<UserInfoData> getPersonInfo() async {
    var response = await get('/user/info');
    return UserInfoData.fromJson(response.data);
  }

  /// 查詢等級資訊
  Future<CheckLevelInfo> getCheckLevelInfoAPI() async{
    var response = await get('/level/user-info');
    print('levelInfo:');
    response.printLog();
    return CheckLevelInfo.fromJson(response.data);
  }
}