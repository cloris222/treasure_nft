import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';

///MARK: 尚未登入前-登入 註冊 忘記密碼 使用
class LoginAPI extends HttpManager {
  LoginAPI({super.onConnectFail});

  ///MARK: 會員登入
  Future<ApiResponse> login(
      {required String account, required String password}) async {
    return post('/user/login',
        data: {'account': account, 'password': password});
  }

  ///MARK: 註冊
  Future<ApiResponse> register(
      {required String account, required String email}) async {
    return post('/user/forget/password',
        data: {'account': account, 'email': email});
  }

  ///MARK: 忘記密碼
  Future<ApiResponse> forgetPassword(
      {required String account, required String email}) async {
    return post('/user/forget/password',
        data: {'account': account, 'email': email});
  }

  ///MARK: 會員資訊
  Future<UserInfoData> getPersonInfo() async {
    var response = await get('/user/info');
    return UserInfoData.fromJson(response.data);
  }
}
