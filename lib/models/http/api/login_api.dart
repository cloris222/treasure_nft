import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

///MARK: 尚未登入前-登入 註冊 忘記密碼 使用
class LoginAPI extends HttpManager {
  LoginAPI({super.onConnectFail});

  ///MARK: 會員登入
  Future<ApiResponse> login(
      {required String account,
      required String password,
      required bool isWallet}) async {
    return post('/user/login', data: {
      'account': account.trim(),
      'password': password.trim(),
      'isWallet': isWallet
    });
  }

  ///MARK: 會員登出
  Future<ApiResponse> logout() async {
    return post('/user/logout');
  }

  ///MARK: 註冊
  Future<ApiResponse> register(
      {required String account,
      required String password,
      required String email,
      required String nickname,
      required String phone,
      required String country,
      required String inviteCode,
      required String emailVerifyCode,
      WalletInfo? walletInfo}) async {
    return post('/user/register', data: {
      'account': account.trim(),
      'password': password.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'phoneCountry': country.trim(),
      'name': nickname.trim(),
      'inviteCode': inviteCode.trim(),
      'emailVerifyCode': emailVerifyCode.trim(),
      'address': walletInfo?.address ?? '',
      'signature': walletInfo?.personalSign ?? '',
    });
  }

  ///MARK: 忘記密碼
  Future<ApiResponse> forgetPassword({required String email}) async {
    return post('/user/forget/password', data: {'email': email.trim()});
  }
}
