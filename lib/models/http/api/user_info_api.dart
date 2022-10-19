import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/check_level_info.dart';
import '../parameter/user_info_data.dart';
import '../parameter/user_order_info.dart';
import '../parameter/user_property.dart';

class UserInfoAPI extends HttpManager {
  UserInfoAPI({super.onConnectFail});

  ///MARK: 會員資訊
  Future<UserInfoData> getPersonInfo() async {
    var response = await get('/user/info');
    return UserInfoData.fromJson(response.data);
  }

  /// 查詢等級資訊
  Future<CheckLevelInfo> getCheckLevelInfoAPI() async {
    var response = await get('/level/user-info');
    return CheckLevelInfo.fromJson(response.data);
  }

  ///MARK: 查詢資產
  Future<UserProperty> getUserPropertyInfo() async {
    var response = await get('/user/property');
    return UserProperty.fromJson(response.data);
  }

  ///MARK: 取得訂單記數資訊
  Future<UserOrderInfo> getUserOrderInfo() async {
    var response = await get('/user/order-count');
    return UserOrderInfo.fromJson(response.data);
  }
}
