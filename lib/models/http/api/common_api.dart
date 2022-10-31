import 'dart:io';

import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';
import '../parameter/upload_img_video.dart';

class CommonAPI extends HttpManager {
  CommonAPI(
      {super.onConnectFail, super.baseUrl = HttpSetting.developCommonUrl});

  Future<ApiResponse> uploadImage(String imagePath) async {
    addDioHeader({'Content-Type': 'multipart/form-data'});
    UploadImageAndVideo upload = UploadImageAndVideo(file: File(imagePath));
    return post('/upload/file', data: await upload.formData(), isEncode: false);
  }
}
