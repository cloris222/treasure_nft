import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';

class UpdatePwdAPI extends HttpManager {
  UpdatePwdAPI({super.onConnectFail});

  ///MARK: 修改密碼
  Future<ApiResponse> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    return await post('/user/update', data: {
      'password': newPassword,
      'oldPassword': oldPassword,
    });
  }
}