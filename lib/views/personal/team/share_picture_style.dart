import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../widgets/label/icon/level_icon_widget.dart';
import '../../../widgets/label/icon/medal_icon_widget.dart';
import '../../login/circle_network_icon.dart';

class SharePicStyle extends ConsumerStatefulWidget {
  const SharePicStyle({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  ConsumerState createState() => _SharePicStyleState();
}

class _SharePicStyleState extends ConsumerState<SharePicStyle> {
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
    UserInfoData userInfo = ref.watch(userInfoProvider);
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
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize20, color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            tr("style${pageIndex + 1}"),
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize16, color: Colors.white),
          ),
          _buildSpace(),
          Expanded(
            /// 截图的widget外包一层RepaintBoundary
            child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  _shareImage(context, pageIndex, repaintFirstKey, userInfo),
                  _shareImage(context, pageIndex, repaintSecondKey, userInfo),
                ],
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                }),
          ),
          // _shareImage(context),
          SizedBox(height: UIDefine.getScreenHeight(3)),
          LoginButtonWidget(
            btnText: tr('confirm'),
            onPressed: () {
              //saveQrcodeImage();
              _capturePngToByteData();
              _shareUiImage();
              Navigator.pop(context);
            },
            height: UIDefine.getScreenWidth(13.6),
            margin:
                EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(5.5)),
          ),
          _buildSpace()
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(height: UIDefine.getScreenHeight(1.5));
  }

  Widget _shareImage(
      BuildContext context, int index, GlobalKey key, UserInfoData userInfo) {
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
            fit: BoxFit.cover,
            alignment: Alignment.center,
            matchTextDirection: true,
            repeat: ImageRepeat.noRepeat,
            image: AssetImage('assets/icon/img/img_background_05.png'),
          )),
          child: _shareImgHeader(context, userInfo),
        ),
      ),
    );
  }

  Widget _shareImgHeader(BuildContext context, UserInfoData userInfo) {
    double iconHeight = UIDefine.getScreenHeight(10);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(AppImagePath.mainAppBarLogo,
                height: UIDefine.getScreenHeight(4), fit: BoxFit.fitHeight),
          ],
        ),
        _buildSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userInfo.photoUrl.isNotEmpty
                ? CircleNetworkIcon(
                    showNormal: true,
                    networkUrl: userInfo.photoUrl,
                    radius: iconHeight / 2)
                : Image.asset(AppImagePath.avatarImg,
                    width: iconHeight, height: iconHeight),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo.name,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LevelIconWidget(
                        level: userInfo.level, size: UIDefine.fontSize24),
                    const SizedBox(width: 5),
                    userInfo.medal.isNotEmpty
                        ? MedalIconWidget(
                            medal: userInfo.medal,
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

        /// 下半部
        Flexible(child: _shareImgBottom(context, pageIndex, userInfo))
      ],
    );
  }

  Widget _shareImgBottom(
      BuildContext context, int index, UserInfoData userInfo) {
    TextStyle styleBlack = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w600);
    TextStyle styleGrey = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSpace(),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getScreenWidth(6),
                vertical: UIDefine.getScreenWidth(2.4)
            ),
            decoration: const BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr("registerNow"),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14
                    )),
              Row(children: [
                Text('${tr("get")} ',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14
                  )),
                Image.asset(AppImagePath.shareText3),
                Text(' ${tr("andEarnMore")}',
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14
                    )),
              ])
            ],),
           ),
            // index == 0
            //     ? Image.asset(
            //         AppImagePath.shareText1,
            //         height: UIDefine.getScreenHeight(10),
            //         fit: BoxFit.contain,
            //       )
            //     : Image.asset(AppImagePath.shareText2,
            //         height: UIDefine.getScreenHeight(10), fit: BoxFit.contain)),
        _buildSpace(),
        Flexible(
          child: QrImage(
            errorStateBuilder: (context, error) => Text(error.toString()),
            data: widget.link,
            version: QrVersions.auto,
            size: UIDefine.getScreenWidth(40),
            foregroundColor: AppColors.mainThemeButton,
          ),
        ),
        Text(tr("referralLink"), style: styleGrey),
        Text(
          userInfo.inviteCode,
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
