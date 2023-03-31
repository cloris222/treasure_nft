import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/parameter/animation_path_data.dart';

import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';
import '../parameter/country_phone_data.dart';
import '../parameter/upload_img_video.dart';

class CommonAPI extends HttpManager {
  CommonAPI({super.onConnectFail, super.baseUrl = HttpSetting.commonUrl});

  Future<ApiResponse> uploadImage(String imagePath,
      {required bool uploadOriginalName, String? setFileName}) async {
    addDioHeader({'Content-Type': 'multipart/form-data'});
    UploadImageAndVideo upload = UploadImageAndVideo(
        file: File(imagePath), uploadOriginalName: uploadOriginalName);
    return post('/upload/file',
        data: await upload.formData(setFileName: setFileName), isEncode: false);
  }

  Future<ApiResponse> uploadImageByFile(File file,
      {required bool uploadOriginalName, required String setFileName}) async {
    addDioHeader({'Content-Type': 'multipart/form-data'});
    UploadImageAndVideo upload =
        UploadImageAndVideo(file: file, uploadOriginalName: uploadOriginalName);
    return post('/upload/file',
        data: await upload.formData(setFileName: setFileName), isEncode: false);
  }

  Future<List<CountryPhoneData>> getCountryList() async {
    List<CountryPhoneData> list = [];
    try {
      var response = await get('/query/areaCode');

      for (Map<String, dynamic> json in response.data) {
        list.add(CountryPhoneData.fromJson(json));
      }
    } catch (e) {
      list.clear();
      //v0.0.2 2022/11/28 手動++
      list.add(CountryPhoneData(country: 'Canada', areaCode: '1'));
      list.add(CountryPhoneData(country: 'SaudiArabia', areaCode: '966'));
      list.add(CountryPhoneData(country: 'Jordan', areaCode: '962'));
      list.add(CountryPhoneData(country: 'Spain', areaCode: '34'));
      list.add(CountryPhoneData(country: 'Brazil', areaCode: '55'));
      list.add(CountryPhoneData(country: 'Singapore', areaCode: '65'));
      list.add(CountryPhoneData(country: 'America', areaCode: '1'));
      list.add(CountryPhoneData(country: 'Kuwait', areaCode: '965'));
      list.add(CountryPhoneData(country: 'Iran', areaCode: '98'));
      list.add(CountryPhoneData(country: 'Taiwan', areaCode: '886'));
      list.add(CountryPhoneData(country: 'Philippines', areaCode: '63'));
      list.add(CountryPhoneData(country: 'Turkey', areaCode: '90'));
      list.add(CountryPhoneData(country: 'UnitedKingdom', areaCode: '44'));
      list.add(CountryPhoneData(country: 'Korea', areaCode: '82'));
      list.add(CountryPhoneData(country: 'Thailand', areaCode: '66'));
      list.add(CountryPhoneData(country: 'Laos', areaCode: '856'));
      list.add(CountryPhoneData(country: 'Indonesia', areaCode: '62'));
      list.add(CountryPhoneData(country: 'Malaysia', areaCode: '60'));
      list.add(CountryPhoneData(country: 'TimorTimur', areaCode: '670'));
      list.add(CountryPhoneData(country: 'Japan', areaCode: '81'));
      list.add(CountryPhoneData(country: 'PapuaNewGuinea', areaCode: '675'));
    }
    return list;
  }

  Future<List<AnimationPathData>> getBucketAnimation() async {
    List<AnimationPathData> list = [];
    try {
      var response = await get('/bucket/files');
      for (Map<String, dynamic> json in response.data) {
        list.add(AnimationPathData.fromJson(json));
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return list;
  }

  ///MARK: APP驗證版本
  Future<String> checkAppVersion() async {
    try {
      var package = await PackageInfo.fromPlatform();
      var response = await get('/query/verify/appVersion', queryParameters: {
        "osType": (Platform.isAndroid ? "ANDROID" : "IOS"),
        "appVersion": package.version
      });
      if (response.data["needToUpdate"]) {
        return response.data["versionRequirements"];
      }
    } catch (e) {}
    return '';
  }

  // Future<List<String>> getRegisterCountryInfo() async {
  //   try {
  //     var response = await get('/query/country/type',
  //         queryParameters: {"isQueryUserAppCountry": true});
  //     List<String> list = [];
  //     for (String value in response.data["userAppCountry"]) {
  //       list.add(value);
  //     }
  //     return list;
  //   } catch (e) {}
  //   return [];
  // }
}
