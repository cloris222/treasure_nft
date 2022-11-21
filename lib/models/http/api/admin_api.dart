import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';

class AdminAPI extends HttpManager {
  AdminAPI({super.onConnectFail, super.baseUrl = HttpSetting.adminUrl});


  ///MARK: 修改密碼
  Future<ApiResponse> updatePassword(
      {required String oldPassword,
        required String newPassword}) {
    return post('/user/updatePassword', data: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
  }


}