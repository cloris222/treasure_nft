import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

class HttpExceptions implements Exception {
  late String message;

  HttpExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        GlobalData.printLog('Request to API server was cancelled');
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        GlobalData.printLog('Connection timeout with API server');
        message = tr('httpErrorConnectTimeout');
        break;
      case DioErrorType.receiveTimeout:
        GlobalData.printLog('Receive timeout in connection with API server');
        message = tr('httpErrorConnectTimeout');
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        GlobalData.printLog("Send timeout in connection with API server");
        message = tr('httpErrorConnectTimeout');
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          GlobalData.printLog("No Internet");
          message = tr('httpErrorNoInternet');
          break;
        }
        GlobalData.printLog("Unexpected error occurred");
        message = tr("httpErrorOther");
        break;
      default:
        GlobalData.printLog("Something went wrong");
        message = tr("httpErrorOther");
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'] ?? 'Error 404';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
