import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

/// QRCode掃碼器 (可自訂畫面 於Scaffold裡)
class QRCodeScannerUtil extends StatefulWidget {
  const QRCodeScannerUtil({super.key, required this.callBack});

  final onGetStringFunction callBack;

  @override
  State<StatefulWidget> createState() => _QRCodeScannerUtil();
}

class _QRCodeScannerUtil extends State<QRCodeScannerUtil> {
  var result;
  QRViewController? controller;
  bool bSuccess = false; // 開關 掃到一次即停止
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildQrView(context)
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = UIDefine.getScreenWidth(90);
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.mainThemeButton,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 8,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      _initController();
    });

    controller.scannedDataStream.listen((scanData) {
      if (!bSuccess) {
        bSuccess = true;
        result = scanData;
        widget.callBack(result.code);
        Navigator.of(context).pop();
      }
    });
  }

  void _initController() async {
    await controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}