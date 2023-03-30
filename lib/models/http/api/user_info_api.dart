import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/api_response.dart';
import '../parameter/check_level_info.dart';
import '../parameter/sign_in_data.dart';
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

  ///MARK: 查詢簽到
  Future<SignInData> getSignInInfo() async {
    var response = await get('/user/sign-in');
    return SignInData.fromJson(response.data);
  }

  ///MARK: 簽到
  Future<ApiResponse> setSignIn() async {
    return post('/user/sign-in');
  }

  Future<ApiResponse> setUserAvtar(String avatarUrl) {
    return put('/user/change-photo', data: {'photoUrl': avatarUrl});
  }

  Future<ApiResponse> setUserBanner(String bannerUrl) {
    return put('/user/change-banner', data: {'photoUrl': bannerUrl});
  }

  ///MARK: 更新會員資訊
  Future<ApiResponse> updatePersonInfo({
    // 所有req欄位皆是 '非必須'
    required String name,
    required String phoneCountry,
    required String phone,
    required String password,
    required String oldPassword,
    required String gender,
    required String birthday,
    String email = '',
    String emailVerifyCode = '',
    String address = '',
    String signature = '',
  }) async {
    return await post('/user/update', data: {
      'account': name,
      'phoneCountry': phoneCountry,
      'phone': phone,
      'password': password,
      'oldPassword': oldPassword,
      'gender': gender,
      'birthday': birthday,
      'address': address,
      'signature': signature,
      'email': email,
      'emailVerifyCode': emailVerifyCode
    });
  }

  Future<ApiResponse> bindEmail(String email, String code) async {
    return await post('/user/email/bind', data: {"email": email, "code": code});
  }

  Future<ApiResponse> deleteAccount() async {
    return await post('/user/close');
  }
}
