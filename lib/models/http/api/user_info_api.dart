import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/api_response.dart';
import '../parameter/blacklist_config_data.dart';
import '../parameter/check_level_info.dart';
import '../parameter/google_auth_data.dart';
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

  ///MARK: 查詢國家
  Future<String> getIpCountry() async {
    try {
      var response = await get("/user/getCountry");
      return response.data;
    } catch (e) {}
    return "";
  }


  ///MARK: 取得二步驗証碼
  Future<GoogleAuthData> getUserGoogleAuth() async {
    var response = await get('/user/googleAuth');
    return GoogleAuthData.fromJson(response.data);
  }

  ///MARK: 綁定二步驗証碼
  Future<String> bindGoogleAuth(String code) async {
    var response = await post('/user/googleAuth/bind', data:{"code":code});
    return response.message;
  }

  ///MARK: 解除綁定二步驗証碼
  Future<String> unBindGoogleAuth(String code, String password) async {
    var response = await post('/user/googleAuth/unbind',
        data:{
          "code":code,
          "password":password
        });
    return response.message;
  }

  ///MARK: 更改信箱
  Future<String> modifyEmail(
      String code, String password, String email, String emailVerifyCode) async{
    var response = await post('/user/update/email',
        data:{
          "code":code,
          "password":password,
          "email": email,
          "emailVerifyCode": emailVerifyCode
        });
    return response.message;
  }

  ///MARK: 查詢黑名單資訊
  Future<BlacklistConfigData> getBlacklistConfig() async {
    var response = await get('/blacklist/config');
    return BlacklistConfigData.fromJson(response.data);
  }


}
