import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:ui' as ui;

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_share_info.dart';

class ShareTeamOrderViewModel extends BaseViewModel {
  ShareTeamOrderViewModel(
      {required this.onViewUpdate, required this.onShareFinish});

  final onClickFunction onViewUpdate;
  final onClickFunction onShareFinish;
  final GlobalKey repaintKey = GlobalKey();

  TeamShareInfo? teamShareInfo;

  void initState(TeamOrderData itemData) async {
    teamShareInfo = await GroupAPI().getTeamShareInfo(itemData.orderNo);
    onViewUpdate();

    ///MARK: time late 做 share image
    await Future.delayed(const Duration(seconds: 1));
    _shareUiImage(repaintKey).then((value) => onShareFinish());
  }

  void dispose() {}

  /// 把图片ByteData写入File，并触发分享
  Future<void> _shareUiImage(GlobalKey key) async {
    ByteData? sourceByteData = await _capturePngToByteData(key);
    Uint8List sourceBytes = sourceByteData!.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();

    String storagePath = tempDir.path;
    File file = File('$storagePath/TreasureNFT.png');

    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
    var shareFile = XFile((file.path));
    Share.shareXFiles([shareFile]);
  }

  /// 截屏图片生成图片流ByteData
  Future<ByteData?> _capturePngToByteData(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      return await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
