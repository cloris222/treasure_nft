import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/coin_enum.dart';
import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../models/http/api/wallet_api.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class OrderRechargeViewModel extends BaseViewModel {
  onSaveQrcode(
      BuildContext context, GlobalKey repaintKey, String? chainAddress) {
    capturePng(repaintKey, chainAddress).then((success) {
      SimpleCustomDialog(context,
              mainText: success ? null : tr("recharge-FAIL'"),
              isSuccess: success)
          .show();
    });
  }

  ///MARK: 儲存QR Code
  ///https://medium.com/codex/exporting-qr-codes-in-flutter-dd30220fcba4
  Future<bool> capturePng(GlobalKey repaintKey, String? chainAddress) async {
    try {
      GlobalData.printLog('开始保存');
      var qrValidationResult = QrValidator.validate(
        data: chainAddress ?? '',
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      var qrCode = qrValidationResult.qrCode;
      var painter = QrPainter.withQr(
        qr: qrCode!,
        color: AppColors.mainThemeButton,
        emptyColor: Colors.white,
        gapless: true,
        embeddedImageStyle: null,
        embeddedImage: null,
      );
      var picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      final result =
          await ImageGallerySaver.saveImage(picData!.buffer.asUint8List());
      GlobalData.printLog('result:$result');
      return true;
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return false;
  }
}
