import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/animation_path_data.dart';

class AnimationDownloadUtil {
  /// 單例
  static AnimationDownloadUtil? _self;

  AnimationDownloadUtil._();

  /// 獲取單例内部方法
  factory AnimationDownloadUtil() {
    /// 只能有一个實例
    return _self ??= AnimationDownloadUtil._();
  }

  final String key = '-AnimationDownload:';
  List<AnimationPathData> paths = [];
  Map<String, String> assetFiles = {};
  String _animatePath = '';
  bool hasPermission = false;

  File? getAnimationFile(String fileName) {
    if (assetFiles.containsKey(fileName)) {
      return File(assetFiles[fileName]!);
    }
    return null;
  }

  void init() async {
    ///MARK: 檢查權限
    PermissionStatus status = await _getStoragePermission();
    if (status == PermissionStatus.permanentlyDenied) {
      // showStorageDialog();
    }
    if (status.isGranted) {
      hasPermission = true;
    }
    start();
  }

  void start() async {
    if (hasPermission) {
      GlobalData.printLog('$key =======START=======');
      var originalFolder = await getApplicationSupportDirectory();
      _animatePath = '${originalFolder.path}/assetAnimate';
      GlobalData.printLog('$key$_animatePath');
      var folder = Directory(_animatePath);
      if (!await folder.exists()) {
        folder.create();
      }

      paths = await CommonAPI(onConnectFail: (msg) {}).getBucketAnimation();
      if (paths.isEmpty) {
        reStart();
        return;
      }
      bool isDownloadFinish = true;
      for (AnimationPathData data in paths) {
        File file = File('$_animatePath/${data.name}');
        GlobalData.printLog('$key${file.path}');
        bool needDownload = true;
        if (await file.exists()) {
          GlobalData.printLog('$key${await file.length()}');
          GlobalData.printLog('$key${data.size}');

          if (await file.length() == data.size) {
            needDownload = false;
          }
        }
        GlobalData.printLog(
            '$key${data.name} is ${needDownload ? 'download start' : 'exist'}');

        if (needDownload) {
          try {
            GlobalData.printLog('${key}loadUrl_${data.url}');
            await HttpManager(addToken: false, onConnectFail: (msg) {})
                .downloadFile(
              data.url,
              file.path,
              data.name,
              // onReceiveProgress: (received, total) =>
              //     showDownloadProgress(received, total, data.name),
            );
            GlobalData.printLog('${key}downloadFile_${data.name} : success');
          } catch (e) {
            GlobalData.printLog(e.toString());

            ///MARK: 10秒後自動重啟
            isDownloadFinish = false;
            reStart();
            break;
          }
        }
        assetFiles[data.name] = file.path;
      }
      if (isDownloadFinish) {
        GlobalData.printLog('$key downloadFinish');
      }
      GlobalData.printLog('$key =======END=======');
    } else {
      GlobalData.printLog('$key =======No Storage Permission=======');
    }
  }

  void reStart() {
    ///MARK: 10秒後自動重啟
    GlobalData.printLog('$key waitRestart');
    Future.delayed(const Duration(seconds: 10)).then((value) => start());
  }

  Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      return result;
    } else {
      return status;
    }
  }

  void showDownloadProgress(received, total, String fileName) {
    if (total != -1) {
      GlobalData.printLog(
          '$key${fileName}_ ${(received / total * 100).toStringAsFixed(0)}%');
    }
  }
}
