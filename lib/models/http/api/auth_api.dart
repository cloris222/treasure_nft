import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';

import '../../../constant/enum/login_enum.dart';
import '../parameter/user_info_data.dart';

class AuthAPI extends HttpManager {
  AuthAPI({super.onConnectFail});

  ///MARK: 尚未登入  發送註冊驗證碼
  Future<ApiResponse> sendAuthRegisterMail({required String mail}) async {
    return get('/user/code', queryParameters: {
      'type': 'MAIL',
      'account': mail,

      ///MARK:不影響註冊
      'countryName': 'Taiwan',
      'action': LoginAction.register.name
    });
  }

  ///MARK: 登入後  發送註冊驗證碼 僅支援-支付設定:payment,轉出:withdraw
  Future<ApiResponse> sendAuthActionMail({required LoginAction action, required UserInfoData userInfo}) async {
    return get('/user/code', queryParameters: {
      'action': action.name,
      'account': userInfo.email,
      'countryName': userInfo.country,
      'type': 'MAIL',
      'lang': getLanguage()
    });
  }

  ///MARK: 檢查驗證碼是否正確
  Future<ApiResponse> checkAuthCodeMail(
      {required String mail,
      required LoginAction action,
      required String authCode}) {
    return post('/user/code', data: {
      'action': action.name,
      'email': mail,
      'type': 'MAIL',
      'code': authCode.trim(),
      'phone': '',
      'countryName': 'Taiwan'
    });
  }
}
