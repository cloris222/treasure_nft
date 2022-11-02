import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../widgets/button/action_button_widget.dart';
import '../../../widgets/label/icon/level_icon_widget.dart';
import '../../../widgets/label/icon/medal_icon_widget.dart';
import '../../login/circle_network_icon.dart';

class SharePicStyle extends StatefulWidget {
  const SharePicStyle({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  State<SharePicStyle> createState() => _SharePicStyleState();
}

class _SharePicStyleState extends State<SharePicStyle> {
  ///pageView
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  /// 绘图key值
  GlobalKey repaintKey = GlobalKey();

  /// 截屏图片生成图片流ByteData
  Future<ByteData?> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return _byteData;
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 把图片ByteData写入File，并触发分享
  Future<void> _shareUiImage() async {

    ByteData? sourceByteData = await _capturePngToByteData();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.opacityBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tr("choosestyle"),
              style:
                  TextStyle(fontSize: UIDefine.fontSize20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              tr("style${pageIndex + 1}"),
              style:
                  TextStyle(fontSize: UIDefine.fontSize16, color: Colors.white),
            ),
            SizedBox(
              height: UIDefine.getHeight() / 50,
            ),
            SizedBox(
              height: UIDefine.getHeight() / 2,
              width: UIDefine.getWidth(),
              /// 截图的widget外包一层RepaintBoundary
              child: RepaintBoundary(
                key: repaintKey,
                child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _shareImage(context, pageIndex),
                      _shareImage(context, pageIndex),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                      });
                    }),
              ),
            ),
            // _shareImage(context),
            SizedBox(
              height: UIDefine.getHeight() / 30,
            ),
            ActionButtonWidget(
              btnText: tr('confirm'),
              onPressed: () {
                //saveQrcodeImage();
                _capturePngToByteData();
                _shareUiImage();
                Navigator.pop(context);
              },
              setHeight: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _shareImage(BuildContext context, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppImagePath.shareBackground),
        Positioned(
            left: UIDefine.getWidth() / 8,
            top: 10,
            child: Image.asset(AppImagePath.mainAppBarLogo)),
        Positioned(
            left: 0,
            right: 0,
            top: UIDefine.getHeight() / 12,
            child: _shareImgHeader(context)),
      ],
    );
  }

  Widget _shareImgHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalData.userInfo.photoUrl.isNotEmpty
                ? CircleNetworkIcon(
                    networkUrl: GlobalData.userInfo.photoUrl, radius: 35)
                : Image.asset(
                    AppImagePath.avatarImg,
                    width: UIDefine.getWidth() / 6,
                    height: UIDefine.getWidth() / 6,
                  ),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GlobalData.userInfo.name,
                  style: TextStyle(fontSize: UIDefine.fontSize20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                        isFillWidth: false,
                        btnText: 'Level${GlobalData.userInfo.level}',
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    LevelIconWidget(
                        level: GlobalData.userInfo.level,
                        size: UIDefine.fontSize30),
                    const SizedBox(width: 10),
                    GlobalData.userInfo.medal.isNotEmpty
                        ? MedalIconWidget(
                            medal: GlobalData.userInfo.medal,
                            size: UIDefine.fontSize30,
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
            width: UIDefine.getWidth() * 0.75,
            child: const Divider(
              thickness: 0.5,
              color: Colors.black,
            )),

        /// 下半部
        //const SizedBox(height: 10,),
        _shareImgBottom(context, pageIndex)
      ],
    );
  }

  Widget _shareImgBottom(BuildContext context, int index) {
    TextStyle styleBlack =
        TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600);
    TextStyle styleGrey = TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        index == 0
            ? Image.asset(
                AppImagePath.shareText1,
                fit: BoxFit.contain,
              )
            : Image.asset(AppImagePath.shareText2, fit: BoxFit.contain),
        QrImage(
          errorStateBuilder: (context, error) => Text(error.toString()),
          data: widget.link,
          version: QrVersions.auto,
          size: UIDefine.getScreenWidth(40),
          foregroundColor: AppColors.textBlack,
        ),
        Text(tr("referralLink"), style: styleGrey),
        Text(
          GlobalData.userInfo.inviteCode,
          textAlign: TextAlign.start,
          style: styleBlack,
        ),
      ],
    );
  }

// MaterialPageRoute _showShareBottomSheet(BuildContext context){
//   return MaterialPageRoute(
//     builder: (context) => Scaffold(
//         body: CupertinoScaffold(
//         body: Builder(
//         builder: (context) => CupertinoPageScaffold(
//     navigationBar: CupertinoNavigationBar(
//     transitionBetweenRoutes: false,
//     middle: Text('Normal Navigation Presentation'),
//     trailing: GestureDetector(
//       child: Icon(Icons.arrow_upward),
//       onTap: () =>
//           CupertinoScaffold.showCupertinoModalBottomSheet(
//             expand: true,
//             context: context,
//             backgroundColor: Colors.transparent,
//             builder: (context) => Stack(
//               children: <Widget>[
//                 ModalWithScroll(),
//                 Positioned(
//                   height: 40,
//                   left: 40,
//                   right: 40,
//                   bottom: 20,
//                   child: MaterialButton(
//                     onPressed: () => Navigator.of(context).popUntil(
//                             (route) => route.settings.name == '/'),
//                     child: Text('Pop back home'),
//                   ),
//                 )
//               ],
//             ),
//           ),
//     ),
//   ),  child: Center(
//             child: Container(),
//         ),
//         ),
//     ),
//   ),
//   ),
//   settings: settings,
//   );
// }
}
