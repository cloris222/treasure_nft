import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';

///MARK: 尚未登入前-登入 註冊 忘記密碼 使用
class LoginAPI extends HttpManager {
  LoginAPI({super.onConnectFail});

  Future<ApiResponse> login(
      {required String account, required String password}) async {
    return post('/user/login',
        data: {'account': account, 'password': password});
  }

  Future<UserInfoData> getPersonInfo() async {
    var response = await get('/user/info');
    return UserInfoData.fromJson(response.data);
  }
}
