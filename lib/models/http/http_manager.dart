import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../constant/call_back_function.dart';
import '../../constant/global_data.dart';
import '../../utils/language_util.dart';
import '../../utils/rsa_util.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import 'http_exceptions.dart';
import 'http_setting.dart';
import 'parameter/api_response.dart';

///MARK: 參考網站
///https://dhruvnakum.xyz/networking-in-flutter-dio#heading-repository
class HttpManager {
// dio instance
  final Dio _dio = Dio();
  final ResponseErrorFunction? onConnectFail;
  final ResponseErrorResponseFunction? onConnectFailResponse;
  String baseUrl;
  final bool addToken;

  ///MARK: 是否自動轉多國
  final bool showTrString;

  ///MARK: 是否自動印log
  final bool printLog;

  HttpManager(
      {this.onConnectFail,
      this.onConnectFailResponse,
      this.baseUrl = HttpSetting.appUrl,
      this.addToken = true,
      this.showTrString = true,
      this.printLog = true,
        String? replaceRoute,
      }) {
    _dio
      ..options.baseUrl = format(baseUrl, {"route": replaceRoute ?? GlobalData.appServerRoute.getDomain()})
      ..options.connectTimeout = HttpSetting.connectionTimeout
      ..options.receiveTimeout = HttpSetting.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  ApiResponse _checkResponse(Response response) {
    if (printLog) {
      GlobalData.printLog(response.realUri.toString());
    }
    var result = ApiResponse.fromJson(response.data);

    ///偷懶看LOG用
    if (printLog) {
      result.printLog();
    }

    ///MARK: 檢查結果
    if (result.code == "G_0000" ||
        result.code == "APP_0062" ||
        result.code == "APP_0041") {
      return result;
    } else if ((result.code.compareTo("G_0201") == 0) ||
        (result.code.compareTo("G_0202") == 0)) {
      BaseViewModel().clearUserLoginInfo();
      BaseViewModel().globalPushAndRemoveUntil(
          const MainPage(type: AppNavigationBarType.typeLogin));
    } else if (result.code == "EO_001_3") {
      BaseViewModel().onLoginFail(result.code,
          result.data["currentErrorNum"],
          result.data["totalCanErrorNum"]);
    } else if (result.code.contains("EO_001")) {
      BaseViewModel().onBaseConnectFail(BaseViewModel().getGlobalContext(), tr(result.code));
    } else if (result.code == "APP_0094"){
      BaseViewModel().showFailDialog(
          DialogImageType.fail,
          tr("applicationFailed"),
          tr("APP_0094"),
          tr('confirm'),
              () => Navigator.pop(BaseViewModel().getGlobalContext())
      );
    }

    ///MARK: 檢查結果 有異常時 直接拋出錯誤
    //取代錯誤code
    response.statusCode = 404;
    response.data['message'] = showTrString ? tr(result.code) : result.code;
    throw DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.response);
  }

  Future<void> _initDio() async {
    if (addToken) {
      if (GlobalData.userToken.isNotEmpty) {
        _dio.options.headers["Authorization"] =
            "Bearer ${GlobalData.userToken}";
        if (printLog) {
          GlobalData.printLog(
              "Authorization:${_dio.options.headers['Authorization']}");
        }
      }
    }
  }

  Future<void> addDioHeader(Map<String, String> header) async {
    header.forEach((key, value) {
      _dio.options.headers[key] = value;
      if (printLog) {
        GlobalData.printLog("addDioHeader $key:${_dio.options.headers[key]}");
      }
    });
  }

  void callFailConnect(String message,
      {required Response? response, bool isOther = false}) {
    if (onConnectFail != null) {
      onConnectFail!(message);
    }
    if (onConnectFailResponse != null) {
      onConnectFailResponse!(message, response);
    }

    ///MARK: 未開啟網路連線時
    else if (isOther) {
      var viewModel = BaseViewModel();
      viewModel.showToast(viewModel.getGlobalContext(), message);
    }
  }

  String getLanguage() {
    return LanguageUtil.getAppStrLanguageForHttp();
  }

  double getDouble(json, String key) {
    return json[key] is int ? (json[key] as int).toDouble() : json[key];
  }

  // Get:-----------------------------------------------------------------------
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _initDio();
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return _checkResponse(response);
    } on DioError catch (e) {
      final errorMessage = HttpExceptions.fromDioError(e).toString();
      if (printLog) {
        GlobalData.printLog('connect errorMessage:$errorMessage');
      }
      callFailConnect(errorMessage,
          response: e.response, isOther: e.type == DioErrorType.other);
      throw "Connect Fail : $errorMessage";
    } catch (e) {
      callFailConnect(e.toString(), response: null);
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<ApiResponse> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isEncode = true,
  }) async {
    await _initDio();
    try {
      final Response response = await _dio.post(
        url,
        data: data != null
            ? isEncode
                ? {
                    'data': [await RSAEncode.encodeLong(data)]
                  }
                : data
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _checkResponse(response);
    } on DioError catch (e) {
      final errorMessage = HttpExceptions.fromDioError(e).toString();
      if (printLog) {
        GlobalData.printLog('connect errorMessage:$errorMessage');
      }
      callFailConnect(errorMessage,
          response: e.response, isOther: e.type == DioErrorType.other);
      throw "Connect Fail : $errorMessage";
    } catch (e) {
      callFailConnect(e.toString(), response: null);
      rethrow;
    }
  }

// Put:-----------------------------------------------------------------------
  Future<ApiResponse> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _initDio();
    try {
      final Response response = await _dio.put(
        url,
        data: data != null
            ? {
                'data': [await RSAEncode.encodeLong(data)]
              }
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _checkResponse(response);
    } on DioError catch (e) {
      final errorMessage = HttpExceptions.fromDioError(e).toString();
      if (printLog) {
        GlobalData.printLog('connect errorMessage:$errorMessage');
      }
      callFailConnect(errorMessage,
          response: e.response, isOther: e.type == DioErrorType.other);
      throw "Connect Fail : $errorMessage";
    } catch (e) {
      callFailConnect(e.toString(), response: null);
      rethrow;
    }
  }

// Delete:--------------------------------------------------------------------
  Future<ApiResponse> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    await _initDio();
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = HttpExceptions.fromDioError(e).toString();
      if (printLog) {
        GlobalData.printLog('connect errorMessage:$errorMessage');
      }
      callFailConnect(errorMessage,
          response: e.response, isOther: e.type == DioErrorType.other);
      throw "Connect Fail : $errorMessage";
    } catch (e) {
      callFailConnect(e.toString(), response: null);
      rethrow;
    }
  }

  ///MARK: 下載檔案
  Future<Response> downloadFile(String url, String savePath, String fileName,
      {ProgressCallback? onReceiveProgress}) async {
    var cancelToken = CancelToken();
    await _initDio();
    try {
      return await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      final errorMessage = HttpExceptions.fromDioError(e).toString();
      if (printLog) {
        GlobalData.printLog('connect errorMessage:$errorMessage');
      }
      callFailConnect(errorMessage,
          response: e.response, isOther: e.type == DioErrorType.other);
      throw "Connect Fail : $errorMessage";
    } catch (e) {
      callFailConnect(e.toString(), response: null);
      rethrow;
    }
  }
}
