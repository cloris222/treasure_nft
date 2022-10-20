import 'dart:typed_data';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../models/http/api/wallet_api.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class OrderRechargeViewModel extends BaseViewModel {
  OrderRechargeViewModel({required this.setState});

  final ViewChange setState;

  Map<String, dynamic>? address;
  String currentChain = 'TRON';
  final String chainTRON = 'TRON';
  final String chainBSC = 'BSC';

  Future<void> initState() async {
    address = await WalletAPI().getBalanceRecharge();
    setState(() {});
  }

  onSaveQrcode(BuildContext context, GlobalKey repaintKey) {
    capturePng(repaintKey).then((value) {
      print('value:$value');
      bool success = value.isNotEmpty;
      SimpleCustomDialog(context,
              mainText: success ? null : tr("recharge-FAIL'"),
              isSuccess: success)
          .show();
    });
  }

  ///MARK: 儲存QR Code
  ///https://medium.com/codex/exporting-qr-codes-in-flutter-dd30220fcba4
  Future<String> capturePng(GlobalKey repaintKey) async {
    try {
      print('开始保存');
      var qrValidationResult = QrValidator.validate(
        data: address?[currentChain] ?? '',
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
      final result = await ImageGallerySaver.saveImage(
          picData!.buffer.asUint8List());
      print('result:$result');
      return result['filePath'];
    } catch (e) {
      print(e);
    }
    return '';
  }
}
