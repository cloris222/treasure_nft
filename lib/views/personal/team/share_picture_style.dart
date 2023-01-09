import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'dart:ui' as ui;
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
  GlobalKey repaintFirstKey = GlobalKey();
  GlobalKey repaintSecondKey = GlobalKey();

  /// 截屏图片生成图片流ByteData
  Future<ByteData?> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary boundary = pageIndex == 0
          ? repaintFirstKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary
          : repaintSecondKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      return await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      GlobalData.printLog(e.toString());
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Text(
            tr("choosestyle"),
            style:
                AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            tr("style${pageIndex + 1}"),
            style:
                AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, color: Colors.white),
          ),
          _buildSpace(),
          Expanded(
            /// 截图的widget外包一层RepaintBoundary
            child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  _shareImage(context, pageIndex, repaintFirstKey),
                  _shareImage(context, pageIndex, repaintSecondKey),
                ],
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                }),
          ),
          // _shareImage(context),
          SizedBox(height: UIDefine.getScreenHeight(3)),
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
          ),
          _buildSpace()
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(height: UIDefine.getScreenHeight(1.5));
  }

  Widget _shareImage(BuildContext context, int index, GlobalKey key) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).padding.top, vertical: 0),
      child: RepaintBoundary(
        key: key,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            matchTextDirection: true,
            repeat: ImageRepeat.noRepeat,
            image: AssetImage(AppImagePath.shareBackground),
          )),
          child: _shareImgHeader(context),
        ),
      ),
    );
  }

  Widget _shareImgHeader(BuildContext context) {
    double iconHeight = UIDefine.getScreenHeight(10);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(AppImagePath.mainAppBarLogo,
                height: UIDefine.getScreenHeight(5), fit: BoxFit.fitHeight),
          ],
        ),
        _buildSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalData.userInfo.photoUrl.isNotEmpty
                ? CircleNetworkIcon(
                    networkUrl: GlobalData.userInfo.photoUrl,
                    radius: iconHeight / 2)
                : Image.asset(AppImagePath.avatarImg,
                    width: iconHeight, height: iconHeight),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GlobalData.userInfo.name,
                  style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                        setHeight: UIDefine.fontSize24,
                        fontSize: UIDefine.fontSize14,
                        isFillWidth: false,
                        btnText: 'Level ${GlobalData.userInfo.level}',
                        radius: 5,
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    LevelIconWidget(
                        level: GlobalData.userInfo.level,
                        size: UIDefine.fontSize24),
                    const SizedBox(width: 5),
                    GlobalData.userInfo.medal.isNotEmpty
                        ? MedalIconWidget(
                            medal: GlobalData.userInfo.medal,
                            size: UIDefine.fontSize24,
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ],
        ),
        _buildSpace(),
        SizedBox(
            width: UIDefine.getWidth() * 0.75,
            child: const Divider(
              thickness: 0.5,
              color: Colors.black,
            )),
        _buildSpace(),

        /// 下半部
        //const SizedBox(height: 10,),
        _shareImgBottom(context, pageIndex)
      ],
    );
  }

  Widget _shareImgBottom(BuildContext context, int index) {
    TextStyle styleBlack =
        AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500);
    TextStyle styleGrey = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        index == 0
            ? Image.asset(
                AppImagePath.shareText1,
                height:UIDefine.getScreenHeight(10),
                fit: BoxFit.fitHeight,
              )
            : Image.asset(AppImagePath.shareText2,
                height: UIDefine.getScreenHeight(10), fit: BoxFit.fitHeight),
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
